using System.Collections.Generic;
using System.Data.SqlClient;
using KhanEAzam.Models;

namespace KhanEAzam.DAL
{
    public class TableReservationRepository
    {
        private TableReservation Map(SqlDataReader r) => new TableReservation
        {
            Id = (int)r["Id"],
            FullName = r["FullName"].ToString(),
            ContactNumber = r["ContactNumber"].ToString(),
            ReservationDate = (System.DateTime)r["ReservationDate"],
            ReservationTime = r["ReservationTime"].ToString(),
            PartySize = (int)r["PartySize"],
            SpecialRequests = r["SpecialRequests"] == System.DBNull.Value ? null : r["SpecialRequests"].ToString(),
            CreatedAt = (System.DateTime)r["CreatedAt"]
        };

        public List<TableReservation> GetAll()
        {
            var list = new List<TableReservation>();
            using (var conn = Database.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand("SELECT * FROM TableReservations ORDER BY ReservationDate, ReservationTime", conn);
                using (var r = cmd.ExecuteReader()) { while (r.Read()) list.Add(Map(r)); }
            }
            return list;
        }


        /// <summary>
        /// Admin list query: optional date-range / party-size / keyword filters plus an
        /// "upcoming only" shortcut, with a whitelisted sort column and direction.
        /// </summary>
        public PagedResult<TableReservation> Search(System.DateTime? from, System.DateTime? to, int? minPartySize,
                                                    string keyword, bool upcomingOnly, string sortBy, bool sortDescending,
                                                    int pageIndex, int pageSize)
        {
            var where = new List<string>();
            var ps = new List<SqlParameter>();

            if (upcomingOnly)
            {
                where.Add("ReservationDate >= @today");
                ps.Add(new SqlParameter("@today", System.DateTime.Today));
            }
            if (from.HasValue)
            {
                where.Add("ReservationDate >= @from");
                ps.Add(new SqlParameter("@from", from.Value.Date));
            }
            if (to.HasValue)
            {
                where.Add("ReservationDate <= @to");
                ps.Add(new SqlParameter("@to", to.Value.Date));
            }
            if (minPartySize.HasValue)
            {
                where.Add("PartySize >= @ps");
                ps.Add(new SqlParameter("@ps", minPartySize.Value));
            }
            if (!string.IsNullOrWhiteSpace(keyword))
            {
                where.Add("(FullName LIKE @kw OR ContactNumber LIKE @kw)");
                ps.Add(new SqlParameter("@kw", "%" + keyword.Trim() + "%"));
            }

            string col;
            switch ((sortBy ?? "").ToLowerInvariant())
            {
                case "id": col = "Id"; break;
                case "name": col = "FullName"; break;
                case "contact": col = "ContactNumber"; break;
                case "guests": col = "PartySize"; break;
                case "submitted": col = "CreatedAt"; break;
                default: col = "ReservationDate"; break;
            }

            string order = col + (sortDescending ? " DESC" : " ASC");
            // Keep same-day reservations in time order when sorting by date.
            if (col == "ReservationDate") order += ", ReservationTime" + (sortDescending ? " DESC" : " ASC");
            // Id is already unique, so only add it as a tie-breaker when it is not the sort column
            // (SQL Server rejects a column repeated in ORDER BY).
            if (col != "Id") order += ", Id DESC";

            if (pageSize < 1) pageSize = 20; else if (pageSize > 200) pageSize = 200;
            if (pageIndex < 0) pageIndex = 0;

            string sql = "SELECT *, COUNT(*) OVER() AS _TotalRows FROM TableReservations"
                + (where.Count > 0 ? " WHERE " + string.Join(" AND ", where) : "")
                + " ORDER BY " + order
                + " OFFSET @Skip ROWS FETCH NEXT @Take ROWS ONLY";

            ps.Add(new SqlParameter("@Skip", pageIndex * pageSize));
            ps.Add(new SqlParameter("@Take", pageSize));

            var result = new PagedResult<TableReservation> { PageIndex = pageIndex, PageSize = pageSize };
            using (var conn = Database.GetConnection())
            {
                conn.Open();
                using (var cmd = new SqlCommand(sql, conn))
                {
                    cmd.Parameters.AddRange(ps.ToArray());
                    using (var r = cmd.ExecuteReader())
                        while (r.Read())
                        {
                            result.Items.Add(Map(r));
                            result.TotalRows = (int)r["_TotalRows"];
                        }
                }
            }

            // A delete can leave the requested page past the end; fall back to the last real page.
            if (result.Items.Count == 0 && result.TotalRows > 0 && pageIndex > 0)
            {
                int last = (int)System.Math.Ceiling(result.TotalRows / (double)pageSize) - 1;
                if (last != pageIndex)
                    return Search(from, to, minPartySize, keyword, upcomingOnly, sortBy, sortDescending, last, pageSize);
            }

            return result;
        }
        public void Insert(TableReservation t)
        {
            using (var conn = Database.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand(@"INSERT INTO TableReservations (FullName,ContactNumber,ReservationDate,ReservationTime,PartySize,SpecialRequests)
                    VALUES (@fn,@cn,@rd,@rt,@ps,@sr)", conn);
                cmd.Parameters.AddWithValue("@fn", t.FullName ?? "");
                cmd.Parameters.AddWithValue("@cn", t.ContactNumber ?? "");
                cmd.Parameters.AddWithValue("@rd", t.ReservationDate);
                cmd.Parameters.AddWithValue("@rt", t.ReservationTime ?? "");
                cmd.Parameters.AddWithValue("@ps", t.PartySize);
                cmd.Parameters.AddWithValue("@sr", (object)t.SpecialRequests ?? System.DBNull.Value);
                cmd.ExecuteNonQuery();
            }
        }

        public void Delete(int id)
        {
            using (var conn = Database.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand("DELETE FROM TableReservations WHERE Id = @id", conn);
                cmd.Parameters.AddWithValue("@id", id);
                cmd.ExecuteNonQuery();
            }
        }
    }
}

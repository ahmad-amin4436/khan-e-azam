using System.Collections.Generic;
using System.Data.SqlClient;
using KhanEAzam.Models;

namespace KhanEAzam.DAL
{
    public class QuickRequestRepository
    {
        private QuickRequest Map(SqlDataReader r) => new QuickRequest
        {
            Id = (int)r["Id"],
            FullName = r["FullName"].ToString(),
            ContactNumber = r["ContactNumber"].ToString(),
            OrderType = r["OrderType"].ToString(),
            CreatedAt = (System.DateTime)r["CreatedAt"]
        };

        public List<QuickRequest> GetAll()
        {
            var list = new List<QuickRequest>();
            using (var conn = Database.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand("SELECT * FROM QuickRequests ORDER BY CreatedAt DESC", conn);
                using (var r = cmd.ExecuteReader()) { while (r.Read()) list.Add(Map(r)); }
            }
            return list;
        }


        /// <summary>
        /// Admin list query: optional order-type / date-range / keyword filter, whitelisted sort,
        /// and server-side paging (only the requested page is fetched).
        /// </summary>
        public PagedResult<QuickRequest> Search(string orderType, System.DateTime? from, System.DateTime? to,
                                                string keyword, string sortBy, bool sortDescending,
                                                int pageIndex, int pageSize)
        {
            var where = new List<string>();
            var ps = new List<SqlParameter>();

            if (!string.IsNullOrEmpty(orderType))
            {
                where.Add("OrderType = @ot");
                ps.Add(new SqlParameter("@ot", orderType));
            }
            if (from.HasValue)
            {
                where.Add("CreatedAt >= @from");
                ps.Add(new SqlParameter("@from", from.Value.Date));
            }
            if (to.HasValue)
            {
                where.Add("CreatedAt < @to");
                ps.Add(new SqlParameter("@to", to.Value.Date.AddDays(1)));
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
                case "type": col = "OrderType"; break;
                default: col = "CreatedAt"; break;
            }

            // Id is already unique, so only add it as a tie-breaker when it is not the sort column
            // (SQL Server rejects a column repeated in ORDER BY).
            string order = col + (sortDescending ? " DESC" : " ASC")
                + (col == "Id" ? "" : ", Id DESC");

            if (pageSize < 1) pageSize = 20; else if (pageSize > 200) pageSize = 200;
            if (pageIndex < 0) pageIndex = 0;

            string sql = "SELECT *, COUNT(*) OVER() AS _TotalRows FROM QuickRequests"
                + (where.Count > 0 ? " WHERE " + string.Join(" AND ", where) : "")
                + " ORDER BY " + order
                + " OFFSET @Skip ROWS FETCH NEXT @Take ROWS ONLY";

            ps.Add(new SqlParameter("@Skip", pageIndex * pageSize));
            ps.Add(new SqlParameter("@Take", pageSize));

            var result = new PagedResult<QuickRequest> { PageIndex = pageIndex, PageSize = pageSize };
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
                    return Search(orderType, from, to, keyword, sortBy, sortDescending, last, pageSize);
            }

            return result;
        }

        /// <summary>Distinct order types, for the filter dropdown.</summary>
        public List<string> GetOrderTypes()
        {
            var list = new List<string>();
            using (var conn = Database.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand(
                    "SELECT DISTINCT OrderType FROM QuickRequests WHERE OrderType IS NOT NULL AND LTRIM(RTRIM(OrderType)) <> '' ORDER BY OrderType", conn);
                using (var r = cmd.ExecuteReader()) { while (r.Read()) list.Add(r[0].ToString()); }
            }
            return list;
        }
        public void Insert(QuickRequest q)
        {
            using (var conn = Database.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand(@"INSERT INTO QuickRequests (FullName,ContactNumber,OrderType)
                    VALUES (@fn,@cn,@ot)", conn);
                cmd.Parameters.AddWithValue("@fn", q.FullName ?? "");
                cmd.Parameters.AddWithValue("@cn", q.ContactNumber ?? "");
                cmd.Parameters.AddWithValue("@ot", q.OrderType ?? "");
                cmd.ExecuteNonQuery();
            }
        }

        public void Delete(int id)
        {
            using (var conn = Database.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand("DELETE FROM QuickRequests WHERE Id = @id", conn);
                cmd.Parameters.AddWithValue("@id", id);
                cmd.ExecuteNonQuery();
            }
        }
    }
}

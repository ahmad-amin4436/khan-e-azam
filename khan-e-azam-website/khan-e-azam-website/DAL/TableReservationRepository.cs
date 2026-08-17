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

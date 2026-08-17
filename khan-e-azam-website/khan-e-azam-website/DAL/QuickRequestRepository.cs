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

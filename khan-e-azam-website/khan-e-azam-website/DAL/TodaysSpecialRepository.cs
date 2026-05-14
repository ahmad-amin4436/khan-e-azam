using System.Collections.Generic;
using System.Data.SqlClient;
using KhanEAzam.Models;

namespace KhanEAzam.DAL
{
    public class TodaysSpecialRepository
    {
        private TodaysSpecial Map(SqlDataReader r) => new TodaysSpecial
        {
            Id = (int)r["Id"], Category = r["Category"].ToString(), Weight = r["Weight"].ToString(),
            Name = r["Name"].ToString(), Price = r["Price"].ToString(), Image = r["Image"].ToString(),
            SortOrder = (int)r["SortOrder"], IsActive = (bool)r["IsActive"]
        };

        public List<TodaysSpecial> GetAll()
        {
            var list = new List<TodaysSpecial>();
            using (var conn = Database.GetConnection())
            {
                conn.Open();
                using (var r = new SqlCommand("SELECT * FROM TodaysSpecials ORDER BY SortOrder", conn).ExecuteReader())
                    while (r.Read()) list.Add(Map(r));
            }
            return list;
        }

        public TodaysSpecial GetById(int id)
        {
            using (var conn = Database.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand("SELECT * FROM TodaysSpecials WHERE Id=@id", conn);
                cmd.Parameters.AddWithValue("@id", id);
                using (var r = cmd.ExecuteReader()) { if (r.Read()) return Map(r); }
            }
            return null;
        }

        public void Insert(TodaysSpecial s)
        {
            using (var conn = Database.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand("INSERT INTO TodaysSpecials(Category,Weight,Name,Price,Image,SortOrder,IsActive) VALUES(@c,@w,@n,@p,@img,@so,@ia)", conn);
                cmd.Parameters.AddWithValue("@c", s.Category ?? ""); cmd.Parameters.AddWithValue("@w", s.Weight ?? "");
                cmd.Parameters.AddWithValue("@n", s.Name ?? ""); cmd.Parameters.AddWithValue("@p", s.Price ?? "");
                cmd.Parameters.AddWithValue("@img", s.Image ?? ""); cmd.Parameters.AddWithValue("@so", s.SortOrder);
                cmd.Parameters.AddWithValue("@ia", s.IsActive); cmd.ExecuteNonQuery();
            }
        }

        public void Update(TodaysSpecial s)
        {
            using (var conn = Database.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand("UPDATE TodaysSpecials SET Category=@c,Weight=@w,Name=@n,Price=@p,Image=@img,SortOrder=@so,IsActive=@ia WHERE Id=@id", conn);
                cmd.Parameters.AddWithValue("@c", s.Category ?? ""); cmd.Parameters.AddWithValue("@w", s.Weight ?? "");
                cmd.Parameters.AddWithValue("@n", s.Name ?? ""); cmd.Parameters.AddWithValue("@p", s.Price ?? "");
                cmd.Parameters.AddWithValue("@img", s.Image ?? ""); cmd.Parameters.AddWithValue("@so", s.SortOrder);
                cmd.Parameters.AddWithValue("@ia", s.IsActive); cmd.Parameters.AddWithValue("@id", s.Id);
                cmd.ExecuteNonQuery();
            }
        }

        public void Delete(int id)
        {
            using (var conn = Database.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand("DELETE FROM TodaysSpecials WHERE Id=@id", conn);
                cmd.Parameters.AddWithValue("@id", id); cmd.ExecuteNonQuery();
            }
        }
    }
}

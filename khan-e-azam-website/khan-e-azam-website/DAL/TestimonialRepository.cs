using System.Collections.Generic;
using System.Data.SqlClient;
using KhanEAzam.Models;

namespace KhanEAzam.DAL
{
    public class TestimonialRepository
    {
        private Testimonial Map(SqlDataReader r) => new Testimonial
        {
            Id = (int)r["Id"], ReviewerName = r["ReviewerName"].ToString(),
            ReviewerPosition = r["ReviewerPosition"].ToString(), ReviewText = r["ReviewText"].ToString(),
            Image = r["Image"].ToString(), SortOrder = (int)r["SortOrder"], IsActive = (bool)r["IsActive"]
        };

        public List<Testimonial> GetAll()
        {
            var list = new List<Testimonial>();
            using (var conn = Database.GetConnection())
            {
                conn.Open();
                using (var r = new SqlCommand("SELECT * FROM Testimonials ORDER BY SortOrder", conn).ExecuteReader())
                    while (r.Read()) list.Add(Map(r));
            }
            return list;
        }

        public Testimonial GetById(int id)
        {
            using (var conn = Database.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand("SELECT * FROM Testimonials WHERE Id=@id", conn);
                cmd.Parameters.AddWithValue("@id", id);
                using (var r = cmd.ExecuteReader()) { if (r.Read()) return Map(r); }
            }
            return null;
        }

        public void Insert(Testimonial t)
        {
            using (var conn = Database.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand("INSERT INTO Testimonials(ReviewerName,ReviewerPosition,ReviewText,Image,SortOrder,IsActive) VALUES(@rn,@rp,@rt,@img,@so,@ia)", conn);
                cmd.Parameters.AddWithValue("@rn", t.ReviewerName ?? ""); cmd.Parameters.AddWithValue("@rp", t.ReviewerPosition ?? "");
                cmd.Parameters.AddWithValue("@rt", t.ReviewText ?? ""); cmd.Parameters.AddWithValue("@img", t.Image ?? "");
                cmd.Parameters.AddWithValue("@so", t.SortOrder); cmd.Parameters.AddWithValue("@ia", t.IsActive);
                cmd.ExecuteNonQuery();
            }
        }

        public void Update(Testimonial t)
        {
            using (var conn = Database.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand("UPDATE Testimonials SET ReviewerName=@rn,ReviewerPosition=@rp,ReviewText=@rt,Image=@img,SortOrder=@so,IsActive=@ia WHERE Id=@id", conn);
                cmd.Parameters.AddWithValue("@rn", t.ReviewerName ?? ""); cmd.Parameters.AddWithValue("@rp", t.ReviewerPosition ?? "");
                cmd.Parameters.AddWithValue("@rt", t.ReviewText ?? ""); cmd.Parameters.AddWithValue("@img", t.Image ?? "");
                cmd.Parameters.AddWithValue("@so", t.SortOrder); cmd.Parameters.AddWithValue("@ia", t.IsActive);
                cmd.Parameters.AddWithValue("@id", t.Id); cmd.ExecuteNonQuery();
            }
        }

        public void Delete(int id)
        {
            using (var conn = Database.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand("DELETE FROM Testimonials WHERE Id=@id", conn);
                cmd.Parameters.AddWithValue("@id", id); cmd.ExecuteNonQuery();
            }
        }
    }
}

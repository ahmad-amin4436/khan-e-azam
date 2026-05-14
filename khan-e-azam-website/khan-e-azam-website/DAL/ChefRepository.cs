using System.Collections.Generic;
using System.Data.SqlClient;
using KhanEAzam.Models;

namespace KhanEAzam.DAL
{
    public class ChefRepository
    {
        private Chef Map(SqlDataReader r) => new Chef
        {
            Id = (int)r["Id"], Name = r["Name"].ToString(), Role = r["Role"].ToString(),
            Image = r["Image"].ToString(), FacebookUrl = r["FacebookUrl"].ToString(),
            TwitterUrl = r["TwitterUrl"].ToString(), InstagramUrl = r["InstagramUrl"].ToString(),
            LinkedInUrl = r["LinkedInUrl"].ToString(), SortOrder = (int)r["SortOrder"], IsActive = (bool)r["IsActive"]
        };

        public List<Chef> GetAll()
        {
            var list = new List<Chef>();
            using (var conn = Database.GetConnection())
            {
                conn.Open();
                using (var r = new SqlCommand("SELECT * FROM Chefs ORDER BY SortOrder", conn).ExecuteReader())
                    while (r.Read()) list.Add(Map(r));
            }
            return list;
        }

        public Chef GetById(int id)
        {
            using (var conn = Database.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand("SELECT * FROM Chefs WHERE Id=@id", conn);
                cmd.Parameters.AddWithValue("@id", id);
                using (var r = cmd.ExecuteReader()) { if (r.Read()) return Map(r); }
            }
            return null;
        }

        public void Insert(Chef c)
        {
            using (var conn = Database.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand("INSERT INTO Chefs(Name,Role,Image,FacebookUrl,TwitterUrl,InstagramUrl,LinkedInUrl,SortOrder,IsActive) VALUES(@n,@r,@img,@fb,@tw,@ig,@li,@so,@ia)", conn);
                cmd.Parameters.AddWithValue("@n", c.Name ?? ""); cmd.Parameters.AddWithValue("@r", c.Role ?? "");
                cmd.Parameters.AddWithValue("@img", c.Image ?? ""); cmd.Parameters.AddWithValue("@fb", c.FacebookUrl ?? "");
                cmd.Parameters.AddWithValue("@tw", c.TwitterUrl ?? ""); cmd.Parameters.AddWithValue("@ig", c.InstagramUrl ?? "");
                cmd.Parameters.AddWithValue("@li", c.LinkedInUrl ?? ""); cmd.Parameters.AddWithValue("@so", c.SortOrder);
                cmd.Parameters.AddWithValue("@ia", c.IsActive); cmd.ExecuteNonQuery();
            }
        }

        public void Update(Chef c)
        {
            using (var conn = Database.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand("UPDATE Chefs SET Name=@n,Role=@r,Image=@img,FacebookUrl=@fb,TwitterUrl=@tw,InstagramUrl=@ig,LinkedInUrl=@li,SortOrder=@so,IsActive=@ia WHERE Id=@id", conn);
                cmd.Parameters.AddWithValue("@n", c.Name ?? ""); cmd.Parameters.AddWithValue("@r", c.Role ?? "");
                cmd.Parameters.AddWithValue("@img", c.Image ?? ""); cmd.Parameters.AddWithValue("@fb", c.FacebookUrl ?? "");
                cmd.Parameters.AddWithValue("@tw", c.TwitterUrl ?? ""); cmd.Parameters.AddWithValue("@ig", c.InstagramUrl ?? "");
                cmd.Parameters.AddWithValue("@li", c.LinkedInUrl ?? ""); cmd.Parameters.AddWithValue("@so", c.SortOrder);
                cmd.Parameters.AddWithValue("@ia", c.IsActive); cmd.Parameters.AddWithValue("@id", c.Id);
                cmd.ExecuteNonQuery();
            }
        }

        public void Delete(int id)
        {
            using (var conn = Database.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand("DELETE FROM Chefs WHERE Id=@id", conn);
                cmd.Parameters.AddWithValue("@id", id); cmd.ExecuteNonQuery();
            }
        }
    }
}

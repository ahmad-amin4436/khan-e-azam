using System.Collections.Generic;
using System.Data.SqlClient;
using KhanEAzam.Models;

namespace KhanEAzam.DAL
{
    public class MenuFilterRepository
    {
        private MenuFilterItem Map(SqlDataReader r) => new MenuFilterItem
        {
            Id = (int)r["Id"], Name = r["Name"].ToString(), Description = r["Description"].ToString(),
            Price = r["Price"].ToString(), Image = r["Image"].ToString(), FilterTags = r["FilterTags"].ToString(),
            SortOrder = (int)r["SortOrder"], IsActive = (bool)r["IsActive"]
        };

        public List<MenuFilterItem> GetAll()
        {
            var list = new List<MenuFilterItem>();
            using (var conn = Database.GetConnection())
            {
                conn.Open();
                using (var r = new SqlCommand("SELECT * FROM MenuFilterItems ORDER BY SortOrder", conn).ExecuteReader())
                    while (r.Read()) list.Add(Map(r));
            }
            return list;
        }

        public MenuFilterItem GetById(int id)
        {
            using (var conn = Database.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand("SELECT * FROM MenuFilterItems WHERE Id=@id", conn);
                cmd.Parameters.AddWithValue("@id", id);
                using (var r = cmd.ExecuteReader()) { if (r.Read()) return Map(r); }
            }
            return null;
        }

        public void Insert(MenuFilterItem m)
        {
            using (var conn = Database.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand("INSERT INTO MenuFilterItems(Name,Description,Price,Image,FilterTags,SortOrder,IsActive) VALUES(@n,@d,@p,@img,@ft,@so,@ia)", conn);
                cmd.Parameters.AddWithValue("@n", m.Name ?? ""); cmd.Parameters.AddWithValue("@d", m.Description ?? "");
                cmd.Parameters.AddWithValue("@p", m.Price ?? ""); cmd.Parameters.AddWithValue("@img", m.Image ?? "");
                cmd.Parameters.AddWithValue("@ft", m.FilterTags ?? ""); cmd.Parameters.AddWithValue("@so", m.SortOrder);
                cmd.Parameters.AddWithValue("@ia", m.IsActive); cmd.ExecuteNonQuery();
            }
        }

        public void Update(MenuFilterItem m)
        {
            using (var conn = Database.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand("UPDATE MenuFilterItems SET Name=@n,Description=@d,Price=@p,Image=@img,FilterTags=@ft,SortOrder=@so,IsActive=@ia WHERE Id=@id", conn);
                cmd.Parameters.AddWithValue("@n", m.Name ?? ""); cmd.Parameters.AddWithValue("@d", m.Description ?? "");
                cmd.Parameters.AddWithValue("@p", m.Price ?? ""); cmd.Parameters.AddWithValue("@img", m.Image ?? "");
                cmd.Parameters.AddWithValue("@ft", m.FilterTags ?? ""); cmd.Parameters.AddWithValue("@so", m.SortOrder);
                cmd.Parameters.AddWithValue("@ia", m.IsActive); cmd.Parameters.AddWithValue("@id", m.Id);
                cmd.ExecuteNonQuery();
            }
        }

        public void Delete(int id)
        {
            using (var conn = Database.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand("DELETE FROM MenuFilterItems WHERE Id=@id", conn);
                cmd.Parameters.AddWithValue("@id", id); cmd.ExecuteNonQuery();
            }
        }
    }
}

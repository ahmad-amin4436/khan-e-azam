using System.Collections.Generic;
using System.Data.SqlClient;
using KhanEAzam.Models;

namespace KhanEAzam.DAL
{
    public class IconFeatureRepository
    {
        private IconFeature Map(SqlDataReader r) => new IconFeature
        {
            Id = (int)r["Id"], IconClass = r["IconClass"].ToString(), Title = r["Title"].ToString(),
            Description = r["Description"].ToString(), LinkUrl = r["LinkUrl"].ToString(),
            SortOrder = (int)r["SortOrder"], IsActive = (bool)r["IsActive"]
        };

        public List<IconFeature> GetAll()
        {
            var list = new List<IconFeature>();
            using (var conn = Database.GetConnection())
            {
                conn.Open();
                using (var r = new SqlCommand("SELECT * FROM IconFeatures ORDER BY SortOrder", conn).ExecuteReader())
                    while (r.Read()) list.Add(Map(r));
            }
            return list;
        }

        public IconFeature GetById(int id)
        {
            using (var conn = Database.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand("SELECT * FROM IconFeatures WHERE Id=@id", conn);
                cmd.Parameters.AddWithValue("@id", id);
                using (var r = cmd.ExecuteReader()) { if (r.Read()) return Map(r); }
            }
            return null;
        }

        public void Insert(IconFeature f)
        {
            using (var conn = Database.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand("INSERT INTO IconFeatures(IconClass,Title,Description,LinkUrl,SortOrder,IsActive) VALUES(@ic,@t,@d,@lu,@so,@ia)", conn);
                cmd.Parameters.AddWithValue("@ic", f.IconClass ?? ""); cmd.Parameters.AddWithValue("@t", f.Title ?? "");
                cmd.Parameters.AddWithValue("@d", f.Description ?? ""); cmd.Parameters.AddWithValue("@lu", f.LinkUrl ?? "");
                cmd.Parameters.AddWithValue("@so", f.SortOrder); cmd.Parameters.AddWithValue("@ia", f.IsActive);
                cmd.ExecuteNonQuery();
            }
        }

        public void Update(IconFeature f)
        {
            using (var conn = Database.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand("UPDATE IconFeatures SET IconClass=@ic,Title=@t,Description=@d,LinkUrl=@lu,SortOrder=@so,IsActive=@ia WHERE Id=@id", conn);
                cmd.Parameters.AddWithValue("@ic", f.IconClass ?? ""); cmd.Parameters.AddWithValue("@t", f.Title ?? "");
                cmd.Parameters.AddWithValue("@d", f.Description ?? ""); cmd.Parameters.AddWithValue("@lu", f.LinkUrl ?? "");
                cmd.Parameters.AddWithValue("@so", f.SortOrder); cmd.Parameters.AddWithValue("@ia", f.IsActive);
                cmd.Parameters.AddWithValue("@id", f.Id); cmd.ExecuteNonQuery();
            }
        }

        public void Delete(int id)
        {
            using (var conn = Database.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand("DELETE FROM IconFeatures WHERE Id=@id", conn);
                cmd.Parameters.AddWithValue("@id", id); cmd.ExecuteNonQuery();
            }
        }
    }
}

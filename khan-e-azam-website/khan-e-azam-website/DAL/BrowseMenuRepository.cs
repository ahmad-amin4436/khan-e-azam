using System.Collections.Generic;
using System.Data.SqlClient;
using KhanEAzam.Models;

namespace KhanEAzam.DAL
{
    public class BrowseMenuRepository
    {
        private BrowseMenuItem Map(SqlDataReader r) => new BrowseMenuItem
        {
            Id = (int)r["Id"], Name = r["Name"].ToString(), SubTitle = r["SubTitle"].ToString(),
            Price = r["Price"].ToString(), Image = r["Image"].ToString(),
            SortOrder = (int)r["SortOrder"], IsActive = (bool)r["IsActive"]
        };

        public List<BrowseMenuItem> GetAll()
        {
            var list = new List<BrowseMenuItem>();
            using (var conn = Database.GetConnection())
            {
                conn.Open();
                using (var r = new SqlCommand("SELECT * FROM BrowseMenuItems ORDER BY SortOrder", conn).ExecuteReader())
                    while (r.Read()) list.Add(Map(r));
            }
            return list;
        }

        public BrowseMenuItem GetById(int id)
        {
            using (var conn = Database.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand("SELECT * FROM BrowseMenuItems WHERE Id=@id", conn);
                cmd.Parameters.AddWithValue("@id", id);
                using (var r = cmd.ExecuteReader()) { if (r.Read()) return Map(r); }
            }
            return null;
        }

        public void Insert(BrowseMenuItem m)
        {
            using (var conn = Database.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand("INSERT INTO BrowseMenuItems(Name,SubTitle,Price,Image,SortOrder,IsActive) VALUES(@n,@st,@p,@img,@so,@ia)", conn);
                cmd.Parameters.AddWithValue("@n", m.Name ?? ""); cmd.Parameters.AddWithValue("@st", m.SubTitle ?? "");
                cmd.Parameters.AddWithValue("@p", m.Price ?? ""); cmd.Parameters.AddWithValue("@img", m.Image ?? "");
                cmd.Parameters.AddWithValue("@so", m.SortOrder); cmd.Parameters.AddWithValue("@ia", m.IsActive);
                cmd.ExecuteNonQuery();
            }
        }

        public void Update(BrowseMenuItem m)
        {
            using (var conn = Database.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand("UPDATE BrowseMenuItems SET Name=@n,SubTitle=@st,Price=@p,Image=@img,SortOrder=@so,IsActive=@ia WHERE Id=@id", conn);
                cmd.Parameters.AddWithValue("@n", m.Name ?? ""); cmd.Parameters.AddWithValue("@st", m.SubTitle ?? "");
                cmd.Parameters.AddWithValue("@p", m.Price ?? ""); cmd.Parameters.AddWithValue("@img", m.Image ?? "");
                cmd.Parameters.AddWithValue("@so", m.SortOrder); cmd.Parameters.AddWithValue("@ia", m.IsActive);
                cmd.Parameters.AddWithValue("@id", m.Id);
                cmd.ExecuteNonQuery();
            }
        }

        public void Delete(int id)
        {
            using (var conn = Database.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand("DELETE FROM BrowseMenuItems WHERE Id=@id", conn);
                cmd.Parameters.AddWithValue("@id", id); cmd.ExecuteNonQuery();
            }
        }
    }
}

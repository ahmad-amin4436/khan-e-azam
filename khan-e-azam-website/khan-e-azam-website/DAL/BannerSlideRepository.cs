using System.Collections.Generic;
using System.Data.SqlClient;
using KhanEAzam.Models;

namespace KhanEAzam.DAL
{
    public class BannerSlideRepository
    {
        private BannerSlide Map(SqlDataReader r) => new BannerSlide
        {
            Id = (int)r["Id"],
            TagLine = r["TagLine"].ToString(),
            Heading = r["Heading"].ToString(),
            Description = r["Description"].ToString(),
            BgImage = r["BgImage"].ToString(),
            FoodImage = r["FoodImage"].ToString(),
            FoodCardName = r["FoodCardName"].ToString(),
            ChefName = r["ChefName"].ToString(),
            ChefRole = r["ChefRole"].ToString(),
            ChefImage = r["ChefImage"].ToString(),
            Price = r["Price"].ToString(),
            CardDescription = r["CardDescription"].ToString(),
            SortOrder = (int)r["SortOrder"],
            IsActive = (bool)r["IsActive"]
        };

        public List<BannerSlide> GetAll()
        {
            var list = new List<BannerSlide>();
            using (var conn = Database.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand("SELECT * FROM BannerSlides ORDER BY SortOrder", conn);
                using (var r = cmd.ExecuteReader()) { while (r.Read()) list.Add(Map(r)); }
            }
            return list;
        }

        public BannerSlide GetById(int id)
        {
            using (var conn = Database.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand("SELECT * FROM BannerSlides WHERE Id = @id", conn);
                cmd.Parameters.AddWithValue("@id", id);
                using (var r = cmd.ExecuteReader()) { if (r.Read()) return Map(r); }
            }
            return null;
        }

        public void Insert(BannerSlide s)
        {
            using (var conn = Database.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand(@"INSERT INTO BannerSlides (TagLine,Heading,Description,BgImage,FoodImage,FoodCardName,ChefName,ChefRole,ChefImage,Price,CardDescription,SortOrder,IsActive)
                    VALUES (@tl,@h,@d,@bg,@fi,@fcn,@cn,@cr,@ci,@p,@cd,@so,@ia)", conn);
                cmd.Parameters.AddWithValue("@tl", s.TagLine ?? "");
                cmd.Parameters.AddWithValue("@h", s.Heading ?? "");
                cmd.Parameters.AddWithValue("@d", s.Description ?? "");
                cmd.Parameters.AddWithValue("@bg", s.BgImage ?? "");
                cmd.Parameters.AddWithValue("@fi", s.FoodImage ?? "");
                cmd.Parameters.AddWithValue("@fcn", s.FoodCardName ?? "");
                cmd.Parameters.AddWithValue("@cn", s.ChefName ?? "");
                cmd.Parameters.AddWithValue("@cr", s.ChefRole ?? "");
                cmd.Parameters.AddWithValue("@ci", s.ChefImage ?? "");
                cmd.Parameters.AddWithValue("@p", s.Price ?? "");
                cmd.Parameters.AddWithValue("@cd", s.CardDescription ?? "");
                cmd.Parameters.AddWithValue("@so", s.SortOrder);
                cmd.Parameters.AddWithValue("@ia", s.IsActive);
                cmd.ExecuteNonQuery();
            }
        }

        public void Update(BannerSlide s)
        {
            using (var conn = Database.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand(@"UPDATE BannerSlides SET TagLine=@tl,Heading=@h,Description=@d,BgImage=@bg,FoodImage=@fi,
                    FoodCardName=@fcn,ChefName=@cn,ChefRole=@cr,ChefImage=@ci,Price=@p,CardDescription=@cd,SortOrder=@so,IsActive=@ia
                    WHERE Id=@id", conn);
                cmd.Parameters.AddWithValue("@tl", s.TagLine ?? "");
                cmd.Parameters.AddWithValue("@h", s.Heading ?? "");
                cmd.Parameters.AddWithValue("@d", s.Description ?? "");
                cmd.Parameters.AddWithValue("@bg", s.BgImage ?? "");
                cmd.Parameters.AddWithValue("@fi", s.FoodImage ?? "");
                cmd.Parameters.AddWithValue("@fcn", s.FoodCardName ?? "");
                cmd.Parameters.AddWithValue("@cn", s.ChefName ?? "");
                cmd.Parameters.AddWithValue("@cr", s.ChefRole ?? "");
                cmd.Parameters.AddWithValue("@ci", s.ChefImage ?? "");
                cmd.Parameters.AddWithValue("@p", s.Price ?? "");
                cmd.Parameters.AddWithValue("@cd", s.CardDescription ?? "");
                cmd.Parameters.AddWithValue("@so", s.SortOrder);
                cmd.Parameters.AddWithValue("@ia", s.IsActive);
                cmd.Parameters.AddWithValue("@id", s.Id);
                cmd.ExecuteNonQuery();
            }
        }

        public void Delete(int id)
        {
            using (var conn = Database.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand("DELETE FROM BannerSlides WHERE Id = @id", conn);
                cmd.Parameters.AddWithValue("@id", id);
                cmd.ExecuteNonQuery();
            }
        }
    }
}

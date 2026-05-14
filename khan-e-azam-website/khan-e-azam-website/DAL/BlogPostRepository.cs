using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using KhanEAzam.Models;

namespace KhanEAzam.DAL
{
    public class BlogPostRepository
    {
        private BlogPost Map(SqlDataReader r) => new BlogPost
        {
            Id = (int)r["Id"], Title = r["Title"].ToString(), Author = r["Author"].ToString(),
            PublishedDate = r["PublishedDate"] == DBNull.Value ? (DateTime?)null : (DateTime)r["PublishedDate"],
            Image = r["Image"].ToString(), VideoUrl = r["VideoUrl"].ToString(),
            IsLarge = (bool)r["IsLarge"], CommentCount = (int)r["CommentCount"],
            SortOrder = (int)r["SortOrder"], IsActive = (bool)r["IsActive"]
        };

        public List<BlogPost> GetAll()
        {
            var list = new List<BlogPost>();
            using (var conn = Database.GetConnection())
            {
                conn.Open();
                using (var r = new SqlCommand("SELECT * FROM BlogPosts ORDER BY SortOrder", conn).ExecuteReader())
                    while (r.Read()) list.Add(Map(r));
            }
            return list;
        }

        public BlogPost GetById(int id)
        {
            using (var conn = Database.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand("SELECT * FROM BlogPosts WHERE Id=@id", conn);
                cmd.Parameters.AddWithValue("@id", id);
                using (var r = cmd.ExecuteReader()) { if (r.Read()) return Map(r); }
            }
            return null;
        }

        public void Insert(BlogPost p)
        {
            using (var conn = Database.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand("INSERT INTO BlogPosts(Title,Author,PublishedDate,Image,VideoUrl,IsLarge,CommentCount,SortOrder,IsActive) VALUES(@t,@a,@pd,@img,@vu,@il,@cc,@so,@ia)", conn);
                cmd.Parameters.AddWithValue("@t", p.Title ?? ""); cmd.Parameters.AddWithValue("@a", p.Author ?? "");
                cmd.Parameters.AddWithValue("@pd", (object)p.PublishedDate ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@img", p.Image ?? ""); cmd.Parameters.AddWithValue("@vu", p.VideoUrl ?? "");
                cmd.Parameters.AddWithValue("@il", p.IsLarge); cmd.Parameters.AddWithValue("@cc", p.CommentCount);
                cmd.Parameters.AddWithValue("@so", p.SortOrder); cmd.Parameters.AddWithValue("@ia", p.IsActive);
                cmd.ExecuteNonQuery();
            }
        }

        public void Update(BlogPost p)
        {
            using (var conn = Database.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand("UPDATE BlogPosts SET Title=@t,Author=@a,PublishedDate=@pd,Image=@img,VideoUrl=@vu,IsLarge=@il,CommentCount=@cc,SortOrder=@so,IsActive=@ia WHERE Id=@id", conn);
                cmd.Parameters.AddWithValue("@t", p.Title ?? ""); cmd.Parameters.AddWithValue("@a", p.Author ?? "");
                cmd.Parameters.AddWithValue("@pd", (object)p.PublishedDate ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@img", p.Image ?? ""); cmd.Parameters.AddWithValue("@vu", p.VideoUrl ?? "");
                cmd.Parameters.AddWithValue("@il", p.IsLarge); cmd.Parameters.AddWithValue("@cc", p.CommentCount);
                cmd.Parameters.AddWithValue("@so", p.SortOrder); cmd.Parameters.AddWithValue("@ia", p.IsActive);
                cmd.Parameters.AddWithValue("@id", p.Id); cmd.ExecuteNonQuery();
            }
        }

        public void Delete(int id)
        {
            using (var conn = Database.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand("DELETE FROM BlogPosts WHERE Id=@id", conn);
                cmd.Parameters.AddWithValue("@id", id); cmd.ExecuteNonQuery();
            }
        }
    }
}

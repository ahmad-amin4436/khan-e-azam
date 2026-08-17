using System.Collections.Generic;
using System.Data.SqlClient;
using KhanEAzam.Models;

namespace KhanEAzam.DAL
{
    public class AdminUserRepository
    {
        private AdminUser Map(SqlDataReader r) => new AdminUser
        {
            Id = (int)r["Id"],
            Username = r["Username"].ToString(),
            PasswordHash = r["PasswordHash"].ToString(),
            Email = r["Email"].ToString(),
            Role = r["Role"].ToString(),
            CreatedAt = (System.DateTime)r["CreatedAt"]
        };

        public AdminUser GetByUsername(string username)
        {
            using (var conn = Database.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand("SELECT * FROM AdminUsers WHERE Username = @u", conn);
                cmd.Parameters.AddWithValue("@u", username);
                using (var r = cmd.ExecuteReader()) { if (r.Read()) return Map(r); }
            }
            return null;
        }

        public AdminUser GetById(int id)
        {
            using (var conn = Database.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand("SELECT * FROM AdminUsers WHERE Id = @id", conn);
                cmd.Parameters.AddWithValue("@id", id);
                using (var r = cmd.ExecuteReader()) { if (r.Read()) return Map(r); }
            }
            return null;
        }

        public List<AdminUser> GetAll()
        {
            var list = new List<AdminUser>();
            using (var conn = Database.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand("SELECT * FROM AdminUsers ORDER BY Username", conn);
                using (var r = cmd.ExecuteReader()) { while (r.Read()) list.Add(Map(r)); }
            }
            return list;
        }

        public void UpdatePasswordHash(string username, string newHash)
        {
            using (var conn = Database.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand("UPDATE AdminUsers SET PasswordHash = @h WHERE Username = @u", conn);
                cmd.Parameters.AddWithValue("@h", newHash);
                cmd.Parameters.AddWithValue("@u", username);
                cmd.ExecuteNonQuery();
            }
        }

        public void Insert(AdminUser u)
        {
            using (var conn = Database.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand(@"INSERT INTO AdminUsers (Username,PasswordHash,Email,Role)
                    VALUES (@un,@ph,@em,@rl)", conn);
                cmd.Parameters.AddWithValue("@un", u.Username ?? "");
                cmd.Parameters.AddWithValue("@ph", u.PasswordHash ?? "");
                cmd.Parameters.AddWithValue("@em", u.Email ?? "");
                cmd.Parameters.AddWithValue("@rl", u.Role ?? "Staff");
                cmd.ExecuteNonQuery();
            }
        }

        public void Update(AdminUser u, bool updatePassword)
        {
            using (var conn = Database.GetConnection())
            {
                conn.Open();
                string sql = updatePassword
                    ? "UPDATE AdminUsers SET Username=@un,PasswordHash=@ph,Email=@em,Role=@rl WHERE Id=@id"
                    : "UPDATE AdminUsers SET Username=@un,Email=@em,Role=@rl WHERE Id=@id";
                var cmd = new SqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("@un", u.Username ?? "");
                if (updatePassword) cmd.Parameters.AddWithValue("@ph", u.PasswordHash ?? "");
                cmd.Parameters.AddWithValue("@em", u.Email ?? "");
                cmd.Parameters.AddWithValue("@rl", u.Role ?? "Staff");
                cmd.Parameters.AddWithValue("@id", u.Id);
                cmd.ExecuteNonQuery();
            }
        }

        public void Delete(int id)
        {
            using (var conn = Database.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand("DELETE FROM AdminUsers WHERE Id = @id", conn);
                cmd.Parameters.AddWithValue("@id", id);
                cmd.ExecuteNonQuery();
            }
        }
    }
}

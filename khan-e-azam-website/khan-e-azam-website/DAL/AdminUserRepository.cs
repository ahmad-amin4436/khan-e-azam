using System.Data.SqlClient;
using KhanEAzam.Models;

namespace KhanEAzam.DAL
{
    public class AdminUserRepository
    {
        public AdminUser GetByUsername(string username)
        {
            using (var conn = Database.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand("SELECT Id, Username, PasswordHash, Email FROM AdminUsers WHERE Username = @u", conn);
                cmd.Parameters.AddWithValue("@u", username);
                using (var r = cmd.ExecuteReader())
                {
                    if (r.Read())
                        return new AdminUser
                        {
                            Id = (int)r["Id"],
                            Username = r["Username"].ToString(),
                            PasswordHash = r["PasswordHash"].ToString(),
                            Email = r["Email"].ToString()
                        };
                }
            }
            return null;
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
    }
}

using System.Configuration;
using System.Data.SqlClient;

namespace KhanEAzam.DAL
{
    public static class Database
    {
        public static SqlConnection GetConnection()
        {
            string cs = ConfigurationManager.ConnectionStrings["KhanEAzamDB"].ConnectionString;
            return new SqlConnection(cs);
        }
    }
}

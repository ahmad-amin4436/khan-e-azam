/*
  Run this SQL once in SQL Server Management Studio against KhanEAzamDB:

  CREATE TABLE Orders (
      Id           INT PRIMARY KEY IDENTITY(1,1),
      CustomerName    NVARCHAR(100) NOT NULL,
      CustomerPhone   NVARCHAR(20)  NOT NULL,
      CustomerAddress NVARCHAR(500) NOT NULL,
      PaymentMethod   NVARCHAR(50)  NOT NULL,
      Status          NVARCHAR(50)  NOT NULL DEFAULT 'Pending',
      Notes           NVARCHAR(1000) NULL,
      TotalAmount     DECIMAL(10,2) NOT NULL DEFAULT 0,
      CreatedAt       DATETIME NOT NULL DEFAULT GETDATE(),
      UpdatedAt       DATETIME NOT NULL DEFAULT GETDATE()
  );

  CREATE TABLE OrderItems (
      Id        INT PRIMARY KEY IDENTITY(1,1),
      OrderId   INT NOT NULL REFERENCES Orders(Id) ON DELETE CASCADE,
      ItemName  NVARCHAR(200) NOT NULL,
      ItemPrice DECIMAL(10,2) NOT NULL,
      Quantity  INT NOT NULL DEFAULT 1,
      Image     NVARCHAR(500) NULL,
      ItemType  NVARCHAR(50)  NULL
  );
*/

using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using KhanEAzam.Models;

namespace KhanEAzam.DAL
{
    public class OrderRepository
    {
        public int CreateOrder(Order order)
        {
            using (var cn = Database.GetConnection())
            {
                cn.Open();
                using (var tx = cn.BeginTransaction())
                {
                    try
                    {
                        const string sql = @"
                            INSERT INTO Orders (CustomerName,CustomerPhone,CustomerAddress,PaymentMethod,Status,Notes,TotalAmount,CreatedAt,UpdatedAt)
                            VALUES (@Name,@Phone,@Address,@Payment,'Pending',@Notes,@Total,GETDATE(),GETDATE());
                            SELECT SCOPE_IDENTITY();";

                        int orderId;
                        using (var cmd = new SqlCommand(sql, cn, tx))
                        {
                            cmd.Parameters.AddWithValue("@Name", order.CustomerName);
                            cmd.Parameters.AddWithValue("@Phone", order.CustomerPhone);
                            cmd.Parameters.AddWithValue("@Address", order.CustomerAddress);
                            cmd.Parameters.AddWithValue("@Payment", order.PaymentMethod);
                            cmd.Parameters.AddWithValue("@Notes", (object)order.Notes ?? DBNull.Value);
                            cmd.Parameters.AddWithValue("@Total", order.TotalAmount);
                            orderId = Convert.ToInt32(cmd.ExecuteScalar());
                        }

                        const string itemSql = @"
                            INSERT INTO OrderItems (OrderId,ItemName,ItemPrice,Quantity,Image,ItemType)
                            VALUES (@OId,@IName,@IPrice,@Qty,@Img,@Type)";

                        foreach (var item in order.Items)
                        {
                            using (var cmd = new SqlCommand(itemSql, cn, tx))
                            {
                                cmd.Parameters.AddWithValue("@OId", orderId);
                                cmd.Parameters.AddWithValue("@IName", item.ItemName);
                                cmd.Parameters.AddWithValue("@IPrice", item.ItemPrice);
                                cmd.Parameters.AddWithValue("@Qty", item.Quantity);
                                cmd.Parameters.AddWithValue("@Img", (object)item.Image ?? DBNull.Value);
                                cmd.Parameters.AddWithValue("@Type", (object)item.ItemType ?? DBNull.Value);
                                cmd.ExecuteNonQuery();
                            }
                        }

                        tx.Commit();
                        return orderId;
                    }
                    catch
                    {
                        tx.Rollback();
                        throw;
                    }
                }
            }
        }

        public Order GetById(int id)
        {
            using (var cn = Database.GetConnection())
            {
                cn.Open();
                var order = FetchOrder(cn, "SELECT * FROM Orders WHERE Id=@Id", new SqlParameter("@Id", id));
                if (order != null) order.Items = FetchItems(cn, id);
                return order;
            }
        }

        public Order GetByIdAndPhone(int id, string phone)
        {
            using (var cn = Database.GetConnection())
            {
                cn.Open();
                var order = FetchOrder(cn,
                    "SELECT * FROM Orders WHERE Id=@Id AND CustomerPhone=@Phone",
                    new SqlParameter("@Id", id),
                    new SqlParameter("@Phone", phone.Trim()));
                if (order != null) order.Items = FetchItems(cn, id);
                return order;
            }
        }

        public List<Order> GetAll()
        {
            var list = new List<Order>();
            using (var cn = Database.GetConnection())
            {
                cn.Open();
                using (var cmd = new SqlCommand("SELECT * FROM Orders ORDER BY CreatedAt DESC", cn))
                using (var dr = cmd.ExecuteReader())
                    while (dr.Read()) list.Add(MapOrder(dr));
            }
            return list;
        }

        public List<Order> GetByStatus(string status)
        {
            var list = new List<Order>();
            using (var cn = Database.GetConnection())
            {
                cn.Open();
                using (var cmd = new SqlCommand("SELECT * FROM Orders WHERE Status=@S ORDER BY CreatedAt DESC", cn))
                {
                    cmd.Parameters.AddWithValue("@S", status);
                    using (var dr = cmd.ExecuteReader())
                        while (dr.Read()) list.Add(MapOrder(dr));
                }
            }
            return list;
        }

        public bool UpdateStatus(int id, string status)
        {
            using (var cn = Database.GetConnection())
            {
                cn.Open();
                using (var cmd = new SqlCommand("UPDATE Orders SET Status=@S,UpdatedAt=GETDATE() WHERE Id=@Id", cn))
                {
                    cmd.Parameters.AddWithValue("@S", status);
                    cmd.Parameters.AddWithValue("@Id", id);
                    return cmd.ExecuteNonQuery() > 0;
                }
            }
        }

        private Order FetchOrder(SqlConnection cn, string sql, params SqlParameter[] parms)
        {
            using (var cmd = new SqlCommand(sql, cn))
            {
                cmd.Parameters.AddRange(parms);
                using (var dr = cmd.ExecuteReader())
                    return dr.Read() ? MapOrder(dr) : null;
            }
        }

        private List<OrderItem> FetchItems(SqlConnection cn, int orderId)
        {
            var items = new List<OrderItem>();
            using (var cmd = new SqlCommand("SELECT * FROM OrderItems WHERE OrderId=@OId", cn))
            {
                cmd.Parameters.AddWithValue("@OId", orderId);
                using (var dr = cmd.ExecuteReader())
                    while (dr.Read())
                        items.Add(new OrderItem
                        {
                            Id = (int)dr["Id"],
                            OrderId = (int)dr["OrderId"],
                            ItemName = dr["ItemName"].ToString(),
                            ItemPrice = (decimal)dr["ItemPrice"],
                            Quantity = (int)dr["Quantity"],
                            Image = dr["Image"] == DBNull.Value ? null : dr["Image"].ToString(),
                            ItemType = dr["ItemType"] == DBNull.Value ? null : dr["ItemType"].ToString()
                        });
            }
            return items;
        }

        private static Order MapOrder(SqlDataReader dr) => new Order
        {
            Id = (int)dr["Id"],
            CustomerName = dr["CustomerName"].ToString(),
            CustomerPhone = dr["CustomerPhone"].ToString(),
            CustomerAddress = dr["CustomerAddress"].ToString(),
            PaymentMethod = dr["PaymentMethod"].ToString(),
            Status = dr["Status"].ToString(),
            Notes = dr["Notes"] == DBNull.Value ? null : dr["Notes"].ToString(),
            TotalAmount = (decimal)dr["TotalAmount"],
            CreatedAt = (DateTime)dr["CreatedAt"],
            UpdatedAt = (DateTime)dr["UpdatedAt"]
        };
    }
}

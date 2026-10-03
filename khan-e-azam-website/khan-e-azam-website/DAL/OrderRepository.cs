/*
  Run this SQL once in SQL Server Management Studio against KhanEAzamDB:

  CREATE TABLE Orders (
      Id           INT PRIMARY KEY IDENTITY(1,1),
      CustomerName    NVARCHAR(100) NOT NULL,
      CustomerPhone   NVARCHAR(20)  NOT NULL,
      CustomerAddress NVARCHAR(500) NOT NULL,
      OrderType       NVARCHAR(30)  NOT NULL DEFAULT 'Fast Delivery',
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
                            INSERT INTO Orders (CustomerName,CustomerPhone,CustomerAddress,OrderType,PaymentMethod,Status,Notes,TotalAmount,CreatedAt,UpdatedAt)
                            VALUES (@Name,@Phone,@Address,@OrderType,@Payment,'Pending',@Notes,@Total,GETDATE(),GETDATE());
                            SELECT SCOPE_IDENTITY();";

                        int orderId;
                        using (var cmd = new SqlCommand(sql, cn, tx))
                        {
                            cmd.Parameters.AddWithValue("@Name", order.CustomerName);
                            cmd.Parameters.AddWithValue("@Phone", order.CustomerPhone);
                            cmd.Parameters.AddWithValue("@Address", order.CustomerAddress);
                            cmd.Parameters.AddWithValue("@OrderType", string.IsNullOrEmpty(order.OrderType) ? "Fast Delivery" : order.OrderType);
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

        /// <summary>
        /// Admin list query: optional status / order-type / payment / date-range / keyword filters,
        /// a whitelisted sort column and direction, and server-side paging.
        ///
        /// Only the requested page is fetched (OFFSET/FETCH). COUNT(*) OVER() returns the
        /// total matching row count in the same round trip, so the pager and the row-range
        /// readout stay consistent with the rows actually returned.
        /// </summary>
        public PagedResult<Order> Search(OrderFilter f)
        {
            if (f == null) f = new OrderFilter();

            var where = new List<string>();
            var ps = new List<SqlParameter>();

            if (!string.IsNullOrEmpty(f.Status))
            {
                where.Add("Status = @Status");
                ps.Add(new SqlParameter("@Status", f.Status));
            }
            if (!string.IsNullOrEmpty(f.OrderType))
            {
                where.Add("OrderType = @OrderType");
                ps.Add(new SqlParameter("@OrderType", f.OrderType));
            }
            if (!string.IsNullOrEmpty(f.PaymentMethod))
            {
                where.Add("PaymentMethod = @Payment");
                ps.Add(new SqlParameter("@Payment", f.PaymentMethod));
            }
            if (f.FromDate.HasValue)
            {
                where.Add("CreatedAt >= @From");
                ps.Add(new SqlParameter("@From", f.FromDate.Value.Date));
            }
            if (f.ToDate.HasValue)
            {
                // Inclusive of the whole "to" day.
                where.Add("CreatedAt < @To");
                ps.Add(new SqlParameter("@To", f.ToDate.Value.Date.AddDays(1)));
            }
            if (!string.IsNullOrWhiteSpace(f.Keyword))
            {
                where.Add("(CustomerName LIKE @Kw OR CustomerPhone LIKE @Kw OR CAST(Id AS NVARCHAR(20)) LIKE @Kw)");
                ps.Add(new SqlParameter("@Kw", "%" + f.Keyword.Trim() + "%"));
            }

            string sortCol = SortColumn(f.SortBy);
            // Id is already unique, so only add it as a tie-breaker when it is not the sort column
            // (SQL Server rejects a column repeated in ORDER BY).
            string order = sortCol + (f.SortDescending ? " DESC" : " ASC")
                + (sortCol == "Id" ? "" : ", Id DESC");

            int pageSize = f.PageSize < 1 ? 20 : (f.PageSize > 200 ? 200 : f.PageSize);
            int pageIndex = f.PageIndex < 0 ? 0 : f.PageIndex;

            string sql = "SELECT *, COUNT(*) OVER() AS _TotalRows FROM Orders"
                + (where.Count > 0 ? " WHERE " + string.Join(" AND ", where) : "")
                + " ORDER BY " + order
                + " OFFSET @Skip ROWS FETCH NEXT @Take ROWS ONLY";

            ps.Add(new SqlParameter("@Skip", pageIndex * pageSize));
            ps.Add(new SqlParameter("@Take", pageSize));

            var result = new PagedResult<Order> { PageIndex = pageIndex, PageSize = pageSize };
            using (var cn = Database.GetConnection())
            {
                cn.Open();
                using (var cmd = new SqlCommand(sql, cn))
                {
                    cmd.Parameters.AddRange(ps.ToArray());
                    using (var dr = cmd.ExecuteReader())
                        while (dr.Read())
                        {
                            result.Items.Add(MapOrder(dr));
                            result.TotalRows = (int)dr["_TotalRows"];
                        }
                }
            }

            // Deleting or filtering can leave the requested page past the end; re-run on the
            // last real page so the user sees rows rather than an empty grid.
            if (result.Items.Count == 0 && result.TotalRows > 0 && pageIndex > 0)
            {
                f.PageIndex = Math.Max(0, (int)Math.Ceiling(result.TotalRows / (double)pageSize) - 1);
                if (f.PageIndex != pageIndex) return Search(f);
            }

            return result;
        }

        /// <summary>Maps a sort key to a literal column name so nothing user-supplied reaches the SQL.</summary>
        private static string SortColumn(string sortBy)
        {
            switch ((sortBy ?? "").ToLowerInvariant())
            {
                case "id": return "Id";
                case "customer": return "CustomerName";
                case "type": return "OrderType";
                case "payment": return "PaymentMethod";
                case "total": return "TotalAmount";
                case "status": return "Status";
                default: return "CreatedAt";
            }
        }

        /// <summary>Distinct values used to populate the admin filter dropdowns.</summary>
        public List<string> GetDistinct(string column)
        {
            string col;
            switch ((column ?? "").ToLowerInvariant())
            {
                case "ordertype": col = "OrderType"; break;
                case "paymentmethod": col = "PaymentMethod"; break;
                case "status": col = "Status"; break;
                default: return new List<string>();
            }

            var list = new List<string>();
            using (var cn = Database.GetConnection())
            {
                cn.Open();
                using (var cmd = new SqlCommand(
                    "SELECT DISTINCT " + col + " FROM Orders WHERE " + col + " IS NOT NULL AND LTRIM(RTRIM(" + col + ")) <> '' ORDER BY " + col, cn))
                using (var dr = cmd.ExecuteReader())
                    while (dr.Read()) list.Add(dr[0].ToString());
            }
            return list;
        }

        /// <summary>
        /// Changes an order's status and records the transition in OrderStatusHistory.
        /// The update and the audit row share one transaction, so a status can never
        /// change without leaving a trace.
        ///
        /// This is the single entry point for every status change, cancellations
        /// included — cancelling is just a transition to OrderStatus.Cancelled.
        /// </summary>
        /// <param name="changedBy">Admin username, or null when not an admin action.</param>
        /// <param name="changedByRole">Admin role, recorded alongside the username.</param>
        /// <param name="reason">Why the change was made. Required by the UI for cancellations.</param>
        /// <returns>False when the order does not exist or already has that status.</returns>
        public bool UpdateStatus(int id, string status, string changedBy = null,
                                 string changedByRole = null, string reason = null)
        {
            using (var cn = Database.GetConnection())
            {
                cn.Open();
                using (var tx = cn.BeginTransaction())
                {
                    try
                    {
                        // Read the current status under the transaction so the recorded
                        // "from" value is the one actually being replaced.
                        string oldStatus;
                        using (var cmd = new SqlCommand(
                            "SELECT Status FROM Orders WITH (UPDLOCK, ROWLOCK) WHERE Id=@Id", cn, tx))
                        {
                            cmd.Parameters.AddWithValue("@Id", id);
                            oldStatus = cmd.ExecuteScalar() as string;
                        }

                        if (oldStatus == null)
                        {
                            tx.Rollback();
                            return false;   // no such order
                        }

                        // Nothing to record when the status is unchanged.
                        if (string.Equals(oldStatus, status, StringComparison.OrdinalIgnoreCase))
                        {
                            tx.Rollback();
                            return false;
                        }

                        using (var cmd = new SqlCommand(
                            "UPDATE Orders SET Status=@S,UpdatedAt=GETDATE() WHERE Id=@Id", cn, tx))
                        {
                            cmd.Parameters.AddWithValue("@S", status);
                            cmd.Parameters.AddWithValue("@Id", id);
                            if (cmd.ExecuteNonQuery() == 0)
                            {
                                tx.Rollback();
                                return false;
                            }
                        }

                        using (var cmd = new SqlCommand(
                            @"INSERT INTO OrderStatusHistory
                                  (OrderId, OldStatus, NewStatus, ChangedBy, ChangedByRole, Reason, ChangedAt)
                              VALUES (@OId, @Old, @New, @By, @Role, @Reason, GETDATE())", cn, tx))
                        {
                            cmd.Parameters.AddWithValue("@OId", id);
                            cmd.Parameters.AddWithValue("@Old", (object)oldStatus ?? DBNull.Value);
                            cmd.Parameters.AddWithValue("@New", status);
                            cmd.Parameters.AddWithValue("@By", string.IsNullOrWhiteSpace(changedBy) ? (object)DBNull.Value : changedBy.Trim());
                            cmd.Parameters.AddWithValue("@Role", string.IsNullOrWhiteSpace(changedByRole) ? (object)DBNull.Value : changedByRole.Trim());
                            cmd.Parameters.AddWithValue("@Reason", string.IsNullOrWhiteSpace(reason) ? (object)DBNull.Value : reason.Trim());
                            cmd.ExecuteNonQuery();
                        }

                        tx.Commit();
                        return true;
                    }
                    catch
                    {
                        tx.Rollback();
                        throw;
                    }
                }
            }
        }

        /// <summary>The audit trail for one order, oldest change first.</summary>
        public List<OrderStatusHistoryEntry> GetStatusHistory(int orderId)
        {
            var list = new List<OrderStatusHistoryEntry>();
            using (var cn = Database.GetConnection())
            {
                cn.Open();
                using (var cmd = new SqlCommand(
                    @"SELECT Id, OrderId, OldStatus, NewStatus, ChangedBy, ChangedByRole, Reason, ChangedAt
                      FROM OrderStatusHistory WHERE OrderId=@OId ORDER BY ChangedAt, Id", cn))
                {
                    cmd.Parameters.AddWithValue("@OId", orderId);
                    using (var dr = cmd.ExecuteReader())
                        while (dr.Read())
                            list.Add(new OrderStatusHistoryEntry
                            {
                                Id = (int)dr["Id"],
                                OrderId = (int)dr["OrderId"],
                                OldStatus = dr["OldStatus"] == DBNull.Value ? null : dr["OldStatus"].ToString(),
                                NewStatus = dr["NewStatus"].ToString(),
                                ChangedBy = dr["ChangedBy"] == DBNull.Value ? null : dr["ChangedBy"].ToString(),
                                ChangedByRole = dr["ChangedByRole"] == DBNull.Value ? null : dr["ChangedByRole"].ToString(),
                                Reason = dr["Reason"] == DBNull.Value ? null : dr["Reason"].ToString(),
                                ChangedAt = (DateTime)dr["ChangedAt"]
                            });
                }
            }
            return list;
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
            OrderType = dr["OrderType"].ToString(),
            PaymentMethod = dr["PaymentMethod"].ToString(),
            Status = dr["Status"].ToString(),
            Notes = dr["Notes"] == DBNull.Value ? null : dr["Notes"].ToString(),
            TotalAmount = (decimal)dr["TotalAmount"],
            CreatedAt = (DateTime)dr["CreatedAt"],
            UpdatedAt = (DateTime)dr["UpdatedAt"]
        };
    }
}

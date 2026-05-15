using System;
using System.Collections.Generic;
using System.Text.RegularExpressions;
using System.Web.UI;
using KhanEAzam.DAL;
using KhanEAzam.Models;
using Newtonsoft.Json;

namespace khan_e_azam_website.Pages
{
    public partial class Checkout : Page
    {
        protected void Page_Load(object sender, EventArgs e) { }

        protected void btnPlaceOrder_Click(object sender, EventArgs e)
        {
            string name = txtName.Text.Trim();
            string phone = txtPhone.Text.Trim();
            string address = txtAddress.Text.Trim();
            string notes = txtNotes.Text.Trim();
            string payMethod = Request.Form["payMethod"] ?? "Cash on Delivery";
            string cartJson = hfCartJson.Value;

            if (string.IsNullOrEmpty(name) || string.IsNullOrEmpty(phone) || string.IsNullOrEmpty(address))
            {
                ShowError("Please fill in your Name, Phone Number, and Delivery Address.");
                return;
            }

            List<CartItemDto> cartItems;
            try
            {
                cartItems = JsonConvert.DeserializeObject<List<CartItemDto>>(cartJson);
            }
            catch
            {
                cartItems = null;
            }

            if (cartItems == null || cartItems.Count == 0)
            {
                ShowError("Your cart is empty. Please add items before checking out.");
                return;
            }

            var order = new Order
            {
                CustomerName = name,
                CustomerPhone = phone,
                CustomerAddress = address,
                PaymentMethod = payMethod,
                Notes = string.IsNullOrEmpty(notes) ? null : notes
            };

            decimal total = 0;
            foreach (var dto in cartItems)
            {
                var priceStr = Regex.Replace((dto.price ?? "0").Replace(",", ""), @"[^0-9.]", "");
                decimal.TryParse(priceStr, out decimal price);
                int qty = dto.qty < 1 ? 1 : dto.qty;
                total += price * qty;

                order.Items.Add(new OrderItem
                {
                    ItemName = dto.name ?? "",
                    ItemPrice = price,
                    Quantity = qty,
                    Image = dto.image,
                    ItemType = dto.id
                });
            }

            order.TotalAmount = total;

            try
            {
                int orderId = new OrderRepository().CreateOrder(order);
                Response.Redirect("~/Pages/OrderTracking.aspx?id=" + orderId, false);
                Context.ApplicationInstance.CompleteRequest();
            }
            catch (Exception ex)
            {
                ShowError("Unable to place your order. Please try again. (" + ex.Message + ")");
            }
        }

        private void ShowError(string msg)
        {
            lblError.Text = msg;
            lblError.Visible = true;
        }

        private class CartItemDto
        {
            public string id { get; set; }
            public string name { get; set; }
            public string price { get; set; }
            public string image { get; set; }
            public int qty { get; set; }
        }
    }
}

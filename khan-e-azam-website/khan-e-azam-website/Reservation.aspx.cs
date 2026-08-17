using System;
using System.Globalization;
using System.Web.UI.WebControls;
using KhanEAzam.DAL;
using KhanEAzam.Models;

namespace khan_e_azam_website
{
    public partial class Reservation : System.Web.UI.Page
    {
        protected TextBox txtReserveName, txtReservePhone, txtReserveDate, txtReserveTime, txtReservePartySize, txtReserveNotes;
        protected Button btnReserveSubmit;
        protected Label lblReserveMsg;

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnReserveSubmit_Click(object sender, EventArgs e)
        {
            string name = txtReserveName.Text.Trim();
            string phone = txtReservePhone.Text.Trim();
            string dateText = txtReserveDate.Text.Trim();
            string timeText = txtReserveTime.Text.Trim();

            if (string.IsNullOrEmpty(name) || string.IsNullOrEmpty(phone) || string.IsNullOrEmpty(dateText) || string.IsNullOrEmpty(timeText))
            {
                ShowReserveMessage("Please fill in your name, phone, date and time.", false);
                return;
            }

            if (!DateTime.TryParseExact(dateText, "yyyy-MM-dd", CultureInfo.InvariantCulture, DateTimeStyles.None, out DateTime reservationDate))
            {
                ShowReserveMessage("Please enter a valid date.", false);
                return;
            }

            new TableReservationRepository().Insert(new TableReservation
            {
                FullName = name,
                ContactNumber = phone,
                ReservationDate = reservationDate,
                ReservationTime = timeText,
                PartySize = int.TryParse(txtReservePartySize.Text.Trim(), out int size) && size > 0 ? size : 1,
                SpecialRequests = string.IsNullOrWhiteSpace(txtReserveNotes.Text) ? null : txtReserveNotes.Text.Trim()
            });

            txtReserveName.Text = "";
            txtReservePhone.Text = "";
            txtReserveDate.Text = "";
            txtReserveTime.Text = "";
            txtReserveNotes.Text = "";
            txtReservePartySize.Text = "4";

            ShowReserveMessage("Thanks! Your reservation request has been received — we'll call you back to confirm.", true);
        }

        private void ShowReserveMessage(string message, bool success)
        {
            lblReserveMsg.CssClass = success ? "kea-reserve-alert alert alert-success" : "kea-reserve-alert alert alert-danger";
            lblReserveMsg.Text = message;
            lblReserveMsg.Visible = true;
        }
    }
}

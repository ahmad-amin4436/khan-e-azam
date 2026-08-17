using System;

namespace KhanEAzam.Models
{
    public class TableReservation
    {
        public int Id { get; set; }
        public string FullName { get; set; }
        public string ContactNumber { get; set; }
        public DateTime ReservationDate { get; set; }
        public string ReservationTime { get; set; }
        public int PartySize { get; set; }
        public string SpecialRequests { get; set; }
        public DateTime CreatedAt { get; set; }
    }
}

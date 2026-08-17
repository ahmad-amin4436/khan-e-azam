using System;

namespace KhanEAzam.Models
{
    public class QuickRequest
    {
        public int Id { get; set; }
        public string FullName { get; set; }
        public string ContactNumber { get; set; }
        public string OrderType { get; set; }
        public DateTime CreatedAt { get; set; }
    }
}

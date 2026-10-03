using System;

namespace KhanEAzam.Models
{
    /// <summary>Filter + sort criteria for the admin Manage Orders list.</summary>
    public class OrderFilter
    {
        public string Status { get; set; }
        public string OrderType { get; set; }
        public string PaymentMethod { get; set; }
        public DateTime? FromDate { get; set; }
        public DateTime? ToDate { get; set; }

        /// <summary>Matches customer name, phone, or order number.</summary>
        public string Keyword { get; set; }

        /// <summary>One of: id, customer, type, payment, total, status, date (default).</summary>
        public string SortBy { get; set; }

        public bool SortDescending { get; set; } = true;

        /// <summary>Zero-based page index for server-side paging.</summary>
        public int PageIndex { get; set; }

        /// <summary>Rows per page. The repository clamps this to a sane range.</summary>
        public int PageSize { get; set; } = 20;
    }
}

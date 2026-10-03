using System;

namespace KhanEAzam.Models
{
    /// <summary>
    /// One recorded status transition for an order. Written by
    /// OrderRepository.UpdateStatus so cancellations and every other change
    /// keep a permanent record of what changed, when, by whom and why.
    /// </summary>
    public class OrderStatusHistoryEntry
    {
        public int Id { get; set; }
        public int OrderId { get; set; }

        /// <summary>Null for the baseline entry of an order that predates the audit trail.</summary>
        public string OldStatus { get; set; }

        public string NewStatus { get; set; }

        /// <summary>Admin username, or null when the change did not come from a signed-in admin.</summary>
        public string ChangedBy { get; set; }

        public string ChangedByRole { get; set; }

        /// <summary>Free-text reason. The UI requires one for a cancellation.</summary>
        public string Reason { get; set; }

        public DateTime ChangedAt { get; set; }

        /// <summary>"Ahmad (SuperAdmin)", or "System" when no admin was attached.</summary>
        public string ChangedByDisplay
        {
            get
            {
                if (string.IsNullOrEmpty(ChangedBy)) return "System";
                return string.IsNullOrEmpty(ChangedByRole)
                    ? ChangedBy
                    : ChangedBy + " (" + ChangedByRole + ")";
            }
        }
    }
}

using System;

namespace KhanEAzam.Models
{
    /// <summary>
    /// The order status vocabulary and the rules around cancellation, in one place
    /// so the pages and the repository agree rather than each re-deciding.
    ///
    /// Cancelling is not a separate mechanism: it is a transition to
    /// <see cref="Cancelled"/> through the normal status-update path.
    /// </summary>
    public static class OrderStatus
    {
        public const string Pending = "Pending";
        public const string Confirmed = "Confirmed";
        public const string Preparing = "Preparing";
        public const string Ready = "Ready";
        public const string OutForDelivery = "Out for Delivery";
        public const string Delivered = "Delivered";
        public const string Cancelled = "Cancelled";

        /// <summary>Role permitted to cancel an order, and to reopen a cancelled one.</summary>
        public const string CancelRole = "SuperAdmin";

        public static bool IsCancelled(string status)
        {
            return string.Equals(status, Cancelled, StringComparison.OrdinalIgnoreCase);
        }

        public static bool IsDelivered(string status)
        {
            return string.Equals(status, Delivered, StringComparison.OrdinalIgnoreCase);
        }

        /// <summary>Only a SuperAdmin may cancel, or reopen something already cancelled.</summary>
        public static bool CanCancel(string role)
        {
            return string.Equals(role, CancelRole, StringComparison.Ordinal);
        }

        /// <summary>
        /// Whether <paramref name="role"/> may move an order from its current status to
        /// <paramref name="newStatus"/>. Cancelled is terminal: only a SuperAdmin can
        /// move an order out of it, which is how a mistaken cancellation gets undone.
        /// </summary>
        public static bool CanTransition(string role, string currentStatus, string newStatus, out string reasonRefused)
        {
            reasonRefused = null;

            if (string.Equals(currentStatus, newStatus, StringComparison.OrdinalIgnoreCase))
            {
                reasonRefused = "The order already has that status.";
                return false;
            }

            // Cancelling, in either direction, is a SuperAdmin action.
            if (IsCancelled(newStatus) && !CanCancel(role))
            {
                reasonRefused = "Only a Super Admin can cancel an order.";
                return false;
            }

            if (IsCancelled(currentStatus) && !CanCancel(role))
            {
                reasonRefused = "This order is cancelled. Only a Super Admin can reopen it.";
                return false;
            }

            return true;
        }

        /// <summary>
        /// A delivered order being cancelled is unusual enough to warn about, since the
        /// food has already reached the customer and money may need returning.
        /// </summary>
        public static bool IsRefundSensitiveCancellation(string currentStatus)
        {
            return IsDelivered(currentStatus) || string.Equals(currentStatus, OutForDelivery, StringComparison.OrdinalIgnoreCase);
        }
    }
}

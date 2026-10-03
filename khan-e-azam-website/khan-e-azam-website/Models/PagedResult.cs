using System;
using System.Collections.Generic;

namespace KhanEAzam.Models
{
    /// <summary>
    /// One page of rows plus the total row count of the full (filtered) result set.
    /// The count comes from the same query as the rows, so the pager and the
    /// "Showing X to Y of Z" range stay consistent with what is on screen.
    /// </summary>
    public class PagedResult<T>
    {
        public List<T> Items { get; set; }

        /// <summary>Total matching rows across all pages, before paging is applied.</summary>
        public int TotalRows { get; set; }

        /// <summary>Zero-based index of the page these items came from.</summary>
        public int PageIndex { get; set; }

        public int PageSize { get; set; }

        public PagedResult()
        {
            Items = new List<T>();
        }

        public int TotalPages
        {
            get { return PageSize <= 0 ? 0 : (int)Math.Ceiling(TotalRows / (double)PageSize); }
        }

        /// <summary>1-based number of the first row on this page, or 0 when empty.</summary>
        public int FirstRowOnPage
        {
            get { return TotalRows == 0 ? 0 : (PageIndex * PageSize) + 1; }
        }

        /// <summary>1-based number of the last row on this page, or 0 when empty.</summary>
        public int LastRowOnPage
        {
            get { return TotalRows == 0 ? 0 : FirstRowOnPage + Items.Count - 1; }
        }

        /// <summary>e.g. "Showing 1 to 20 of 137 orders" — the row-range readout.</summary>
        public string RangeText(string noun, string nounPlural)
        {
            if (TotalRows == 0) return "No " + nounPlural;

            return string.Format("Showing {0} to {1} of {2} {3}",
                FirstRowOnPage, LastRowOnPage, TotalRows,
                TotalRows == 1 ? noun : nounPlural);
        }
    }
}

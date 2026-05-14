using System;

namespace KhanEAzam.Models
{
    public class BlogPost
    {
        public int Id { get; set; }
        public string Title { get; set; }
        public string Author { get; set; }
        public DateTime? PublishedDate { get; set; }
        public string Image { get; set; }
        public string VideoUrl { get; set; }
        public bool IsLarge { get; set; }
        public int CommentCount { get; set; }
        public int SortOrder { get; set; }
        public bool IsActive { get; set; }
    }
}

namespace KhanEAzam.Models
{
    public class Testimonial
    {
        public int Id { get; set; }
        public string ReviewerName { get; set; }
        public string ReviewerPosition { get; set; }
        public string ReviewText { get; set; }
        public string Image { get; set; }
        public int SortOrder { get; set; }
        public bool IsActive { get; set; }
    }
}

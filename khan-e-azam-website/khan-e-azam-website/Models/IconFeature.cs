namespace KhanEAzam.Models
{
    public class IconFeature
    {
        public int Id { get; set; }
        public string IconClass { get; set; }
        public string Title { get; set; }
        public string Description { get; set; }
        public string LinkUrl { get; set; }
        public int SortOrder { get; set; }
        public bool IsActive { get; set; }
    }
}

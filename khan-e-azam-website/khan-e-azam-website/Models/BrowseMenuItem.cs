namespace KhanEAzam.Models
{
    public class BrowseMenuItem
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string SubTitle { get; set; }
        public string Price { get; set; }
        public string Image { get; set; }
        public int SortOrder { get; set; }
        public bool IsActive { get; set; }
    }
}

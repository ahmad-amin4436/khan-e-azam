namespace KhanEAzam.Models
{
    public class TodaysSpecial
    {
        public int Id { get; set; }
        public string Category { get; set; }
        public string Weight { get; set; }
        public string Name { get; set; }
        public string Price { get; set; }
        public string Image { get; set; }
        public int SortOrder { get; set; }
        public bool IsActive { get; set; }
    }
}

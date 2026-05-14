namespace KhanEAzam.Models
{
    public class Chef
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Role { get; set; }
        public string Image { get; set; }
        public string FacebookUrl { get; set; }
        public string TwitterUrl { get; set; }
        public string InstagramUrl { get; set; }
        public string LinkedInUrl { get; set; }
        public int SortOrder { get; set; }
        public bool IsActive { get; set; }
    }
}

namespace KhanEAzam.Models
{
    public class BannerSlide
    {
        public int Id { get; set; }
        public string TagLine { get; set; }
        public string Heading { get; set; }
        public string Description { get; set; }
        public string BgImage { get; set; }
        public string FoodImage { get; set; }
        public string FoodCardName { get; set; }
        public string ChefName { get; set; }
        public string ChefRole { get; set; }
        public string ChefImage { get; set; }
        public string Price { get; set; }
        public string CardDescription { get; set; }
        public int SortOrder { get; set; }
        public bool IsActive { get; set; }
    }
}

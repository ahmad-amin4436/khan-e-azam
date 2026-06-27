<%@ Page Title="About Us | Khan-e-Azam" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="about.aspx.cs" Inherits="khan_e_azam_website.about" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="h-20"></div>
<section class="relative w-full h-[80vh] flex items-center justify-center overflow-hidden">
    <!-- Blurred Background Image -->
    <img src="https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=1600&q=80" 
         class="absolute inset-0 w-full h-full object-cover z-0 blur-[6px] scale-105" />
    
    <!-- Dark tint overlay -->
    <div class="absolute inset-0 bg-black/40 z-0"></div>
    
    <!-- Glassmorphism Content Box -->
    <div class="relative z-10 w-[90%] max-w-[1200px] px-8 py-16 bg-black/40 backdrop-blur-md border border-white/10 rounded-3xl text-center shadow-2xl">
        <!-- Heading with Lobster Font -->
        <h1 class="font-lobster font-normal mb-6 text-[clamp(3rem,6vw,5rem)] leading-[1.2] text-white">
            The Story Behind<br />
            <span class="text-[#C89B3C]">Khan-e-Azam</span>
        </h1>
        
        <!-- Adjusted Paragraph for better flow -->
        <p class="text-white/80 mx-auto text-[18px] leading-[1.8] max-w-[700px] font-sans">
            From the royal kitchens of Mughal heritage to your table — every dish we serve carries a story of passion, tradition, and the finest ingredients Lahore has to offer.
        </p>
    </div>
</section>

    <div class="h-20"></div>

    <!-- Our Story Section -->
    <section class="py-20 bg-[#FDFBF7]">
        <div class="container mx-auto max-w-[1200px] px-6">
            <div class="flex flex-col lg:flex-row items-center gap-10">
                
                <!-- Image Column -->
                <div class="w-full lg:w-1/2">
                    <div class="relative rounded-[20px] overflow-hidden shadow-lg">
                        <img src="https://images.unsplash.com/photo-1414235077428-338989a2e8c0?w=800&q=80" class="w-full h-auto" alt="Culinary Heritage">
                    </div>
                </div>

                <!-- Text Column -->
                <div class="w-full lg:w-1/2 lg:pl-10">
                    <h5 class="uppercase text-[#C89B3C] tracking-[3px] font-sans text-[0.8rem] mb-3">Our Story</h5>
                    <h2 class="font-serif font-bold mb-6 text-[#1A1208] text-[2.3rem] leading-tight">
                        A Legacy Crafted With<br />
                        <span class="text-[#C89B3C]">Royalty & Passion</span>
                    </h2>
                    <p class="text-gray-500 mb-6 leading-[1.9] font-sans">
                        Khan-e-Azam was born from a dream to bring the grandeur of Mughal culinary traditions to the modern table. 
                        What began as a humble family kitchen in the heart of Lahore has grown into a celebrated institution.
                    </p>
                    
                   <div class="w-full mt-[50px]">
    <a href="Pages/Menu.aspx" 
       class="btn btn-md btn-primary btn-hover-1 transition-all duration-500 hover:bg-transparent hover:border-[#C89B3C] hover:text-[#C89B3C] hover:-translate-y-1">
        <span>EXPLORE OUR MENU</span>
    </a>
</div>
                    
                    <hr class="my-8 border-[#E0D8C3]">

                    <div class="flex items-center text-center">
                        <div class="flex-1 border-r border-[#E0D8C3]">
                            <div class="font-serif text-[2rem] font-bold text-[#C89B3C] mb-1">35+</div>
                            <div class="uppercase text-[0.7rem] text-[#555] tracking-[2px] font-sans">Years of Legacy</div>
                        </div>
                        <div class="flex-1 border-r border-[#E0D8C3]">
                            <div class="font-serif text-[2rem] font-bold text-[#C89B3C] mb-1">120+</div>
                            <div class="uppercase text-[0.7rem] text-[#555] tracking-[2px] font-sans">Signature Dishes</div>
                        </div>
                        <div class="flex-1">
                            <div class="font-serif text-[2rem] font-bold text-[#C89B3C] mb-1">50K+</div>
                            <div class="uppercase text-[0.7rem] text-[#555] tracking-[2px] font-sans">Happy Guests</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

 <!-- Standard Section -->
<section class="relative bg-black py-20 overflow-hidden">
    <!-- Background Elements -->
    <img src="https://images.unsplash.com/photo-1544025162-d76694265947?w=1600&q=80" class="absolute inset-0 w-full h-full object-cover opacity-70">
    <div class="absolute inset-0 bg-gradient-to-b from-black/80 to-[#1A1208]/95"></div>

    <!-- Content Container -->
    <div class="container mx-auto text-center relative z-10 px-6">
        <h6 class="uppercase text-[#C89B3C] tracking-[4px] text-[0.8rem] mb-3">The Standard</h6>
        <h2 class="text-white font-serif text-[2rem] mb-12">Culinary Excellence</h2>
        
        <!-- Grid Wrapper -->
        <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
            <!-- Card 1 -->
            <a href="#" class="block bg-white/5 border border-[#C89B3C]/30 p-8 rounded-[20px] shadow-xl transition-all duration-500 hover:bg-[#C89B3C]/10 hover:border-[#C89B3C] hover:-translate-y-2 group">
                <div class="text-[2rem] text-[#C89B3C] mb-4 transition-colors duration-500 group-hover:text-white">✦</div>
                <h5 class="text-white mb-3 text-[1.3rem]">Authentic Heritage</h5>
                <p class="text-white/50 text-[0.85rem] leading-7">Preserving ancient Mughal techniques and traditions.</p>
            </a>

            <!-- Card 2 -->
            <a href="#" class="block bg-white/5 border border-[#C89B3C]/30 p-8 rounded-[20px] shadow-xl transition-all duration-500 hover:bg-[#C89B3C]/10 hover:border-[#C89B3C] hover:-translate-y-2 group">
                <div class="text-[2rem] text-[#C89B3C] mb-4 transition-colors duration-500 group-hover:text-white">✦</div>
                <h5 class="text-white mb-3 text-[1.3rem]">Finest Ingredients</h5>
                <p class="text-white/50 text-[0.85rem] leading-7">Sourcing rare spices and fresh local produce daily.</p>
            </a>

            <!-- Card 3 -->
            <a href="#" class="block bg-white/5 border border-[#C89B3C]/30 p-8 rounded-[20px] shadow-xl transition-all duration-500 hover:bg-[#C89B3C]/10 hover:border-[#C89B3C] hover:-translate-y-2 group">
                <div class="text-[2rem] text-[#C89B3C] mb-4 transition-colors duration-500 group-hover:text-white">✦</div>
                <h5 class="text-white mb-3 text-[1.3rem]">Royal Hospitality</h5>
                <p class="text-white/50 text-[0.85rem] leading-7">Service with the grace of a true Mughal court.</p>
            </a>
        </div>
    </div>
</section>

    <section class="py-20 bg-[#FDFBF7]">
    <div class="container mx-auto text-center mb-16 px-6">
        <h6 class="text-[#C89B3C] tracking-[3px] uppercase text-[12px] mb-2">Our Journey</h6>
        <h2 class="font-serif text-[2.5rem] text-[#1A1208]">Milestones That <span class="text-[#C89B3C]">Shaped Us</span></h2>
    </div>

    <div class="container mx-auto relative px-6 max-w-4xl">
        
        <div class="absolute left-[20px] md:left-1/2 top-0 bottom-0 w-[2px] bg-[#E5E5E5] -translate-x-1/2"></div>

        <div class="space-y-12">
            
            <div class="relative pl-12 md:pl-0">
                <div class="absolute left-[20px] md:left-1/2 top-1 w-4 h-4 bg-[#C89B3C] rounded-full border-[4px] border-[#FDFBF7] -translate-x-1/2"></div>
                
                <div class="md:w-5/12 md:ml-auto">
                    <div class="bg-white p-8 rounded-[15px] shadow-sm border border-gray-100 transition-all duration-500 hover:shadow-xl hover:-translate-y-1 group hover:border-[#C89B3C]">
                        <h4 class="text-[#C89B3C] font-serif font-bold group-hover:text-orange-500">1987</h4>
                        <h6 class="font-bold my-2 group-hover:text-[#C89B3C]">A Dream Takes Shape</h6>
                        <p class="text-[14px] text-[#666]">Our founder, Ustad Rahim Khan, opens the first Khan-e-Azam dhaba in the walled city of Lahore.</p>
                    </div>
                </div>
            </div>

            <div class="relative pl-12 md:pl-0">
                <div class="absolute left-[20px] md:left-1/2 top-1 w-4 h-4 bg-[#C89B3C] rounded-full border-[4px] border-[#FDFBF7] -translate-x-1/2"></div>
                
                <div class="md:w-5/12 md:mr-auto">
                    <div class="bg-white p-8 rounded-[15px] shadow-sm border border-gray-100 transition-all duration-500 hover:shadow-xl hover:-translate-y-1 group hover:border-[#C89B3C]">
                        <h4 class="text-[#C89B3C] font-serif font-bold group-hover:text-orange-500">1998</h4>
                        <h6 class="font-bold my-2 group-hover:text-[#C89B3C]">The First Restaurant</h6>
                        <p class="text-[14px] text-[#666]">After a decade of acclaim, the first full-service restaurant opens in Gulberg, bringing tradition indoors.</p>
                    </div>
                </div>
            </div>

            <div class="relative pl-12 md:pl-0">
                <div class="absolute left-[20px] md:left-1/2 top-1 w-4 h-4 bg-[#C89B3C] rounded-full border-[4px] border-[#FDFBF7] -translate-x-1/2"></div>
                
                <div class="md:w-5/12 md:ml-auto">
                    <div class="bg-white p-8 rounded-[15px] shadow-sm border border-gray-100 transition-all duration-500 hover:shadow-xl hover:-translate-y-1 group hover:border-[#C89B3C]">
                        <h4 class="text-[#C89B3C] font-serif font-bold group-hover:text-orange-500">2008</h4>
                        <h6 class="font-bold my-2 group-hover:text-[#C89B3C]">Award & Recognition</h6>
                        <p class="text-[14px] text-[#666]">Recognised as Lahore's Best Traditional Restaurant by the Punjab Food Authority.</p>
                    </div>
                </div>
            </div>

        </div>
    </div>
</section>

    <!-- Footer Quote -->
    <section class="py-20 bg-[#FDFBF7]">
        <div class="container mx-auto max-w-[700px] text-center px-6">
            <div class="text-[1.5rem] mb-4 text-[#C89B3C]">✦ ✦ ✦</div>
            <h3 class="italic mb-6 font-serif text-[#1A1208] text-[1.75rem]">
                "A meal at Khan-e-Azam is more than just dining; it is a celebration of heritage."
            </h3>
            <p class="uppercase text-gray-400 tracking-[2px] text-[0.9rem] mb-8">We invite you to be part of our story.</p>
            <div class="w-full mt-[30px]">
    <a href="Contact.aspx" 
       class="btn btn-md btn-primary btn-hover-1 transition-all duration-500 hover:bg-transparent hover:border-[#C89B3C] hover:text-[#C89B3C] hover:-translate-y-1">
        <span>Visit Us</span>
    </a>
</div>
  
        </div>
    </section>

</asp:Content>

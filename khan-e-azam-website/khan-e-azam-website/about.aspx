<%@ Page Title="About Us | Khan-e-Azam" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="about.aspx.cs" Inherits="khan_e_azam_website.about" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
  <style>
      @media (max-width: 640px) {
    .glass-hero-box {
        /* This ensures internal vertical spacing */
        padding-top: 40px !important;
        padding-bottom: 40px !important;
        margin-top: 20px;
        margin-bottom: 20px;
    }
}
  </style>
    <div style="height: 80px;"></div>

  <section class="relative w-full flex items-center justify-center overflow-hidden" style="height: 80vh;">
    <!-- Background remains the same -->
    <img src="https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=1600&q=80" 
         class="absolute w-full h-full object-cover z-0" style="top: 0; left: 0; filter: blur(6px); transform: scale(1.05);" alt="" />
    <div class="absolute w-full h-full z-0" style="top: 0; left: 0; background-color: rgba(0,0,0,0.4);"></div>

    <!-- Glassmorphism Content Box -->
    <!-- Added 'py-12' and 'my-auto' to ensure vertical spacing -->
    <div class="relative z-10 text-center glass-hero-box" style="width: 90%; max-width: 1200px; padding: 40px 20px; background-color: rgba(0,0,0,0.4); backdrop-filter: blur(8px); border: 1px solid rgba(255,255,255,0.1); border-radius: 24px; box-shadow: 0 25px 50px -12px rgba(0,0,0,0.5);">
        
        <h1 class="font-lobster font-normal mb-4 text-white hero-title" style="font-size: clamp(2rem, 5vw, 5rem); line-height: 1.1;">
            The Story Behind<br />
            <span style="color: #C89B3C;">Khan-e-Azam</span>
        </h1>

        <p class="mx-auto" style="color: rgba(255,255,255,0.8); font-size: 16px; line-height: 1.6; max-width: 700px; margin-top: 20px;">
            From the royal kitchens of Mughal heritage to your table &mdash; every dish we serve carries a story of passion, tradition, and the finest ingredients Lahore has to offer.
        </p>
    </div>
</section>

    <div style="height: 80px;"></div>

    <!-- Our Story Section -->
    <section style="padding: 80px 0; background-color: #FDFBF7;">
        <div class="container mx-auto px-6" style="max-width: 1200px;">
            <div class="flex flex-col lg:flex-row items-center" style="gap: 40px;">

                <!-- Image Column -->
                <div class="w-full lg:w-1/2">
                    <div class="relative overflow-hidden shadow-lg" style="border-radius: 20px;">
                        <img src="https://images.unsplash.com/photo-1414235077428-338989a2e8c0?w=800&q=80" class="w-full h-auto" alt="Culinary Heritage">
                    </div>
                </div>

                <!-- Text Column -->
                <div class="w-full lg:w-1/2">
                    <h5 class="uppercase mb-3" style="color: #C89B3C; letter-spacing: 3px; font-size: 0.8rem;">Our Story</h5>
                    <h2 class="font-lobster font-bold mb-6" style="color: #1A1208; font-size: 2.3rem; line-height: 1.2;">
                        A Legacy Crafted With<br />
                        <span style="color: #C89B3C;">Royalty &amp; Passion</span>
                    </h2>
                    <p class="mb-6" style="color: #777; line-height: 1.9;">
                        Khan-e-Azam was born from a dream to bring the grandeur of Mughal culinary traditions to the modern table.
                        What began as a humble family kitchen in the heart of Lahore has grown into a celebrated institution.
                    </p>

                    <div class="w-full" style="margin-top: 50px;">
                        <a href="/Pages/Menu.aspx" class="btn btn-md btn-hover-1" style="background-color: #C89B3C; color: #fff; border: 1px solid #C89B3C;">
                            <span>EXPLORE OUR MENU</span>
                        </a>
                    </div>

                    <hr style="border: none; border-top: 1px solid #E0D8C3; margin: 32px 0;">

                    <div class="flex items-center text-center">
                        <div class="flex-1" style="border-right: 1px solid #E0D8C3;">
                            <div class="font-lobster text-[2rem] font-bold mb-1" style="color: #C89B3C;">35+</div>
                            <div class="uppercase tracking-[2px]" style="font-size: 0.7rem; color: #555;">Years of Legacy</div>
                        </div>
                        <div class="flex-1" style="border-right: 1px solid #E0D8C3;">
                            <div class="font-lobster text-[2rem] font-bold mb-1" style="color: #C89B3C;">120+</div>
                            <div class="uppercase tracking-[2px]" style="font-size: 0.7rem; color: #555;">Signature Dishes</div>
                        </div>
                        <div class="flex-1">
                            <div class="font-lobster text-[2rem] font-bold mb-1" style="color: #C89B3C;">50K+</div>
                            <div class="uppercase tracking-[2px]" style="font-size: 0.7rem; color: #555;">Happy Guests</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Standard Section -->
    <section class="relative bg-black overflow-hidden" style="padding: 80px 0;">
        <!-- Background Elements -->
        <img src="/assets/images/about/standard-bg.jpg" class="absolute w-full h-full object-cover" style="top: 0; left: 0; opacity: 0.7;" alt="">
        <div class="absolute w-full h-full" style="top: 0; left: 0; background: linear-gradient(to bottom, rgba(0,0,0,0.8), rgba(26,18,8,0.95));"></div>

        <!-- Content Container -->
        <div class="container mx-auto text-center relative z-10 px-6">
            <h6 class="uppercase mb-3" style="color: #C89B3C; letter-spacing: 4px; font-size: 0.8rem;">The Standard</h6>
            <h2 class="text-white font-lobster" style="font-size: 2rem; margin-bottom: 48px;">Culinary Excellence</h2>

            <!-- Grid Wrapper -->
            <div class="flex flex-wrap" style="gap: 24px;">
                <!-- Card 1 -->
                <a href="#" class="block" style="flex: 1 1 280px; text-decoration: none; background: rgba(255,255,255,0.05); border: 1px solid rgba(200,155,60,0.3); padding: 32px; border-radius: 20px; box-shadow: 0 20px 25px -5px rgba(0,0,0,0.3); transition: all 0.5s ease;"
                   onmouseover="this.style.background='rgba(200,155,60,0.1)'; this.style.borderColor='#C89B3C'; this.style.transform='translateY(-8px)'; this.querySelector('.std-icon').style.color='#fff';"
                   onmouseout="this.style.background='rgba(255,255,255,0.05)'; this.style.borderColor='rgba(200,155,60,0.3)'; this.style.transform='translateY(0)'; this.querySelector('.std-icon').style.color='#C89B3C';">
                    <div class="std-icon mb-4" style="font-size: 2rem; color: #C89B3C; transition: color 0.5s ease;"><i class="fas fa-feather-alt"></i></div>
                    <h5 class="text-white mb-3" style="font-size: 1.3rem;">Authentic Heritage</h5>
                    <p class="leading-7" style="color: rgba(255,255,255,0.5); font-size: 0.85rem; margin: 0;">Preserving ancient Mughal techniques and traditions.</p>
                </a>

                <!-- Card 2 -->
                <a href="#" class="block" style="flex: 1 1 280px; text-decoration: none; background: rgba(255,255,255,0.05); border: 1px solid rgba(200,155,60,0.3); padding: 32px; border-radius: 20px; box-shadow: 0 20px 25px -5px rgba(0,0,0,0.3); transition: all 0.5s ease;"
                   onmouseover="this.style.background='rgba(200,155,60,0.1)'; this.style.borderColor='#C89B3C'; this.style.transform='translateY(-8px)'; this.querySelector('.std-icon').style.color='#fff';"
                   onmouseout="this.style.background='rgba(255,255,255,0.05)'; this.style.borderColor='rgba(200,155,60,0.3)'; this.style.transform='translateY(0)'; this.querySelector('.std-icon').style.color='#C89B3C';">
                    <div class="std-icon mb-4" style="font-size: 2rem; color: #C89B3C; transition: color 0.5s ease;"><i class="fas fa-leaf"></i></div>
                    <h5 class="text-white mb-3" style="font-size: 1.3rem;">Finest Ingredients</h5>
                    <p class="leading-7" style="color: rgba(255,255,255,0.5); font-size: 0.85rem; margin: 0;">Sourcing rare spices and fresh local produce daily.</p>
                </a>

                <!-- Card 3 -->
                <a href="#" class="block" style="flex: 1 1 280px; text-decoration: none; background: rgba(255,255,255,0.05); border: 1px solid rgba(200,155,60,0.3); padding: 32px; border-radius: 20px; box-shadow: 0 20px 25px -5px rgba(0,0,0,0.3); transition: all 0.5s ease;"
                   onmouseover="this.style.background='rgba(200,155,60,0.1)'; this.style.borderColor='#C89B3C'; this.style.transform='translateY(-8px)'; this.querySelector('.std-icon').style.color='#fff';"
                   onmouseout="this.style.background='rgba(255,255,255,0.05)'; this.style.borderColor='rgba(200,155,60,0.3)'; this.style.transform='translateY(0)'; this.querySelector('.std-icon').style.color='#C89B3C';">
                    <div class="std-icon mb-4" style="font-size: 2rem; color: #C89B3C; transition: color 0.5s ease;"><i class="fas fa-crown"></i></div>
                    <h5 class="text-white mb-3" style="font-size: 1.3rem;">Royal Hospitality</h5>
                    <p class="leading-7" style="color: rgba(255,255,255,0.5); font-size: 0.85rem; margin: 0;">Service with the grace of a true Mughal court.</p>
                </a>
            </div>
        </div>
    </section>

    <!-- Milestones / Journey Section -->
    <section style="padding: 80px 0; background-color: #FDFBF7;">
        <div class="container mx-auto text-center px-6" style="margin-bottom: 64px;">
            <h6 class="uppercase mb-2" style="color: #C89B3C; letter-spacing: 3px; font-size: 12px;">Our Journey</h6>
            <h2 class="font-lobster" style="font-size: 2.5rem; color: #1A1208;">Milestones That <span style="color: #C89B3C;">Shaped Us</span></h2>
        </div>

        <div class="container mx-auto relative px-6" style="max-width: 900px;">

            <!-- Vertical line -->
            <div class="absolute" style="left: 20px; top: 0; bottom: 0; width: 2px; background-color: #E5E5E5;"></div>

            <div style="display: flex; flex-direction: column; gap: 48px;">

                <!-- 1987 -->
                <div class="relative" style="padding-left: 48px;">
                    <div class="absolute top-1 rounded-full" style="left: 12px; width: 16px; height: 16px; background-color: #C89B3C; border: 4px solid #FDFBF7; transform: translateX(-50%);"></div>

                    <div class="bg-white" style="border-radius: 15px; padding: 32px; border: 1px solid #f0f0f0; box-shadow: 0 1px 2px rgba(0,0,0,0.05); transition: all 0.5s ease;"
                         onmouseover="this.style.boxShadow='0 20px 25px -5px rgba(0,0,0,0.15)'; this.style.transform='translateY(-4px)'; this.style.borderColor='#C89B3C';"
                         onmouseout="this.style.boxShadow='0 1px 2px rgba(0,0,0,0.05)'; this.style.transform='translateY(0)'; this.style.borderColor='#f0f0f0';">
                        <h4 class="font-lobster font-bold" style="color: #C89B3C;">1987</h4>
                        <h6 class="font-bold" style="margin: 8px 0;">A Dream Takes Shape</h6>
                        <p style="font-size: 14px; color: #666; margin: 0;">Our founder, Ustad Rahim Khan, opens the first Khan-e-Azam dhaba in the walled city of Lahore.</p>
                    </div>
                </div>

                <!-- 1998 -->
                <div class="relative" style="padding-left: 48px;">
                    <div class="absolute top-1 rounded-full" style="left: 12px; width: 16px; height: 16px; background-color: #C89B3C; border: 4px solid #FDFBF7; transform: translateX(-50%);"></div>

                    <div class="bg-white" style="border-radius: 15px; padding: 32px; border: 1px solid #f0f0f0; box-shadow: 0 1px 2px rgba(0,0,0,0.05); transition: all 0.5s ease;"
                         onmouseover="this.style.boxShadow='0 20px 25px -5px rgba(0,0,0,0.15)'; this.style.transform='translateY(-4px)'; this.style.borderColor='#C89B3C';"
                         onmouseout="this.style.boxShadow='0 1px 2px rgba(0,0,0,0.05)'; this.style.transform='translateY(0)'; this.style.borderColor='#f0f0f0';">
                        <h4 class="font-lobster font-bold" style="color: #C89B3C;">1998</h4>
                        <h6 class="font-bold" style="margin: 8px 0;">The First Restaurant</h6>
                        <p style="font-size: 14px; color: #666; margin: 0;">After a decade of acclaim, the first full-service restaurant opens in Gulberg, bringing tradition indoors.</p>
                    </div>
                </div>

                <!-- 2008 -->
                <div class="relative" style="padding-left: 48px;">
                    <div class="absolute top-1 rounded-full" style="left: 12px; width: 16px; height: 16px; background-color: #C89B3C; border: 4px solid #FDFBF7; transform: translateX(-50%);"></div>

                    <div class="bg-white" style="border-radius: 15px; padding: 32px; border: 1px solid #f0f0f0; box-shadow: 0 1px 2px rgba(0,0,0,0.05); transition: all 0.5s ease;"
                         onmouseover="this.style.boxShadow='0 20px 25px -5px rgba(0,0,0,0.15)'; this.style.transform='translateY(-4px)'; this.style.borderColor='#C89B3C';"
                         onmouseout="this.style.boxShadow='0 1px 2px rgba(0,0,0,0.05)'; this.style.transform='translateY(0)'; this.style.borderColor='#f0f0f0';">
                        <h4 class="font-lobster font-bold" style="color: #C89B3C;">2008</h4>
                        <h6 class="font-bold" style="margin: 8px 0;">Award &amp; Recognition</h6>
                        <p style="font-size: 14px; color: #666; margin: 0;">Recognised as Lahore's Best Traditional Restaurant by the Punjab Food Authority.</p>
                    </div>
                </div>

            </div>
        </div>
    </section>

    <!-- Footer Quote -->
    <section style="padding: 80px 0; background-color: #FDFBF7;">
        <div class="container mx-auto text-center px-6" style="max-width: 700px;">
            <div class="mb-4" style="font-size: 1.5rem; color: #C89B3C;">
                <i class="fas fa-star"></i> <i class="fas fa-star"></i> <i class="fas fa-star"></i>
            </div>
            <h3 class="italic mb-6 font-lobster text-[1.75rem]" style="color: #1A1208;">
                "A meal at Khan-e-Azam is more than just dining; it is a celebration of heritage."
            </h3>
            <p class="uppercase" style="letter-spacing: 2px; font-size: 0.9rem; color: #999; margin-bottom: 32px;">We invite you to be part of our story.</p>
            <div class="w-full" style="margin-top: 30px;">
                <a href="/Contact.aspx" class="btn btn-md btn-hover-1" style="background-color: #C89B3C; color: #fff; border: 1px solid #C89B3C;">
                    <span>Visit Us</span>
                </a>
            </div>
        </div>
    </section>

</asp:Content>


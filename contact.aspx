<%@ Page Title="Contact Us" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="contact.aspx.cs" Inherits="khan_e_azam_website.contact" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="bg-white" style="width: 100%;">


        <!-- Hero Section -->
        <section class="content-inner text-center" style="background-image: url('/assets/images/banner/bnr1.jpg'); background-size: cover; background-position: center; background-color: #000;">
            <div class="container">
                <div>
                    <span class="text-primary font-medium uppercase block mb-4" style="letter-spacing: 0.2em;">Get In Touch</span>
                    <h1 class="font-lobster text-white mb-6">We'd Love to<br/><span class="text-primary">Hear From You</span></h1>
                   <div class="text-primary text-3xl" style="animation: kePulse 1.6s ease-in-out infinite; display: inline-block;">
    <i class="fas fa-heart"></i>
</div>
                </div>
            </div>
        </section>

       <div class="bg-primary py-[60px] px-[20px]">
    <div class="container">
        <div class="row flex-wrap" style="justify-content: center;">

            <div class="lg:w-1/3 w-full" style="padding: 0 40px; margin-bottom: 30px;">
                <div class="text-center">
                    <a href="#booking" class="inline-block" style="font-size: 3rem; color: #000000; transition: color 0.3s ease;" onmouseover="this.style.color='#C89B3C'" onmouseout="this.style.color='#000000'">
                        <i class="fas fa-calendar-alt" style="color: #000000 !important; "></i>
                    </a>
                    <span class="block uppercase font-bold mb-4" style="font-size: 10px; letter-spacing: 2px; opacity: 0.7; margin-top: 12px;">Book a Table</span>
                    <a href="#booking" class="btn btn-primary" style="background: transparent; border: 1px solid #1A1208; color: #1A1208; transition: transform 0.3s ease;" onmouseover="this.style.transform='scale(1.1)'" onmouseout="this.style.transform='scale(1)'">Reserve Now</a>
                </div>
            </div>

            <div class="lg:w-1/3 w-full" style="padding: 0 40px; margin-bottom: 30px;">
                <div class="text-center">
                    <a href="#location" class="inline-block" style="font-size: 3rem; color: #000000; transition: color 0.3s ease;" onmouseover="this.style.color='#C89B3C'" onmouseout="this.style.color='#000000'">
                        <i class="flaticon-placeholder" style="color: #000000 !important;"></i>
                    </a>
                    <span class="block uppercase font-bold mb-4" style="font-size: 10px; letter-spacing: 2px; opacity: 0.7; margin-top: 12px;">Find Us</span>
                    <a href="#location" class="btn btn-primary" style="background: transparent; border: 1px solid #1A1208; color: #1A1208; transition: transform 0.3s ease;" onmouseover="this.style.transform='scale(1.1)'" onmouseout="this.style.transform='scale(1)'">Open Maps</a>
                </div>
            </div>

            <div class="lg:w-1/3 w-full" style="padding: 0 40px; margin-bottom: 30px;">
                <div class="text-center">
                    <a href="/Menu" class="inline-block" style="font-size: 3rem; color: #000000; transition: color 0.3s ease;" onmouseover="this.style.color='#C89B3C'" onmouseout="this.style.color='#000000'">
                        <i class="flaticon-shopping-cart" style="color: #000000 !important;"></i>
                    </a>
                    <span class="block uppercase font-bold mb-4" style="font-size: 10px; letter-spacing: 2px; opacity: 0.7; margin-top: 12px;">Order Online</span>
                    <a href="/Menu" class="btn btn-primary" style="background: transparent; border: 1px solid #1A1208; color: #1A1208; transition: transform 0.3s ease;" onmouseover="this.style.transform='scale(1.1)'" onmouseout="this.style.transform='scale(1)'">View Menu</a>
                </div>
            </div>

        </div>
    </div>
</div>

        <section class="content-inner">
            <div class="container">
                <div class="flex flex-wrap items-start lg:gap-[60px]">

                  <div class="lg:w-5/12 w-full px-[15px] mb-[30px]">
    <div class="contact-info-bx border border-[#eee] shadow-sm" style="padding: 50px !important;">
        <h3 class="font-lobster" style="margin-bottom: 30px !important;">Contact Information</h3>
        <div class="widget_getintuch">
            <ul style="list-style: none; padding: 0; margin: 0;">
                <!-- Location -->
                <li style="margin-bottom: 30px; display: flex; align-items: flex-start;">
                    <a href="https://maps.google.com/?q=880+N+Poonch+Rd,+Samnabad+Town,+Lahore,+Pakistan" target="_blank" rel="noopener" class="text-2xl text-primary hover:text-[#C89B3C] transition-colors duration-300" style="margin-right: 20px; margin-top: 2px;" aria-label="Open location in Google Maps">
                        <i class="fas fa-map-marker-alt"></i>
                    </a>
                    <span>880 N Poonch Rd, Samnabad Town, Lahore, Punjab 54000 Pakistan</span>
                </li>
               <li style="margin-bottom: 30px; display: flex; align-items: flex-start;">
    <div class="text-2xl text-primary" style="margin-right: 20px; margin-top: -2px;">
        <i class="fas fa-phone-alt"></i>
    </div>
    
    <div style="display: flex; flex-direction: column; gap: 8px;">
        <a href="tel:+924237571100" style="color: inherit; text-decoration: none;">+92 42 3757 1100</a>
        <a href="tel:+923099406789" style="color: inherit; text-decoration: none;">+92 309 9406789 (Hotel, Event)</a>
        <a href="tel:+923089406789" style="color: inherit; text-decoration: none;">+92 308 9406789 (Restaurant)</a>
    </div>
</li>
               
                <!-- Email -->
                <li style="margin-bottom: 30px; display: flex; align-items: flex-start;">
    <div class="text-2xl text-primary" style="margin-right: 20px; margin-top: -2px;">
        <i class="fas fa-envelope"></i>
    </div>
    
    <div style="display: flex; flex-direction: column; gap: 8px;">
        <a href="mailto:khaneazamresturant@gmail.com" style="color: inherit; text-decoration: none;">khaneazamresturant@gmail.com</a>
        <a href="mailto:khaneazamhotelevents@gmail.com" style="color: inherit; text-decoration: none;">khaneazamhotelevents@gmail.com</a>
    </div>
</li>
                <!-- Clock -->
                <li style="margin-bottom: 50px; display: flex; align-items: flex-start;">
                    <span class="text-2xl text-primary" style="margin-right: 20px; margin-top: 2px;" aria-hidden="true">
                        <i class="fas fa-clock"></i>
                    </span>
                    <span>Open Daily: 12:00 PM &ndash; 12:00 AM</span>
                </li>
               
                <!-- Social Media Icons (Aligned under the clock text) -->
               <li style="margin-top: 20px;margin-bottom: 0px; display: block; padding-left: 4px;">
    <a href="#" class="text-primary hover:text-[#C89B3C] transition-colors duration-300" aria-label="Facebook" style="display: inline-block; margin-right: 25px;">
        <svg width="26" height="24" viewBox="0 0 24 24" fill="currentColor"><path d="M22.676 0H1.324C.593 0 0 .593 0 1.324v21.352C0 23.407.593 24 1.324 24h11.494v-9.294H9.692v-3.622h3.126V8.413c0-3.1 1.893-4.788 4.659-4.788 1.325 0 2.463.099 2.795.143v3.24l-1.918.001c-1.504 0-1.795.715-1.795 1.763v2.31h3.587l-.467 3.622h-3.12V24h6.116c.73 0 1.323-.593 1.323-1.324V1.324C24 .593 23.407 0 22.676 0z"/></svg>
    </a>
    
    <a href="#" class="text-primary hover:text-[#C89B3C] transition-colors duration-300" aria-label="Instagram" style="display: inline-block; margin-right: 25px;">
        <svg width="26" height="24" viewBox="0 0 24 24" fill="currentColor"><path d="M12 2.163c3.204 0 3.584.012 4.85.07 1.13.053 1.758.247 2.17.408.55.213.943.467 1.355.88.414.413.667.805.88 1.355.16.412.355 1.04.408 2.17.058 1.266.07 1.646.07 4.85s-.012 3.584-.07 4.85c-.053 1.13-.247 1.758-.408 2.17-.213.55-.467.943-.88 1.355-.413.414-.805.667-1.355.88-.412.16-1.04.355-2.17.408-1.266.058-1.646.07-4.85.07s-3.584-.012-4.85-.07c-1.13-.053-1.758-.247-2.17-.408-.55-.213-.943-.467-1.355-.88-.414-.413-.667-.805-.88-1.355-.16-.412-.355-1.04-.408-2.17-.058-1.266-.07-1.646-.07-4.85s.012-3.584.07-4.85c.053-1.13.247-1.758.408-2.17.213-.55.467-.943.88-1.355.413-.414.805-.667 1.355-.88.412-.16 1.04-.355 2.17-.408 1.266-.058 1.646-.07 4.85-.07zm0-2.163c-3.259 0-3.667.014-4.947.072-1.277.058-2.15.258-2.915.556-.79.306-1.458.718-2.126 1.386-.668.668-1.08 1.336-1.386 2.126-.298.765-.498 1.638-.556 2.915-.058 1.28-.072 1.688-.072 4.947s.014 3.667.072 4.947c.058 1.277.258 2.15.556 2.915.306.79.718 1.458 1.386 2.126.668.668 1.336 1.08 2.126 1.386.765.298 1.638.498 2.915.556 1.28.058 1.688.072 4.947.072s3.667-.014 4.947-.072c1.277-.058 2.15-.258 2.915-.556.79-.306 1.458-.718 2.126-1.386.668-.668 1.08-1.336 1.386-2.126.298-.765.498-1.638.556-2.915.058-1.28.072-1.688.072-4.947s-.014-3.667-.072-4.947c-.058-1.277-.258-2.15-.556-2.915-.306-.79-.718-1.458-1.386-2.126-.668-.668-1.336-1.08-2.126-1.386-.765-.298-1.638-.498-2.915-.556-1.28-.058-1.688-.072-4.947-.072z"/><path d="M12 5.838c-3.403 0-6.162 2.759-6.162 6.162s2.759 6.163 6.162 6.163 6.162-2.759 6.162-6.163c0-3.403-2.759-6.162-6.162-6.162zm0 10.162c-2.209 0-4-1.791-4-4s1.791-4 4-4 4 1.791 4 4-1.791 4-4 4zm6.406-11.845c-.796 0-1.441.645-1.441 1.44s.645 1.44 1.441 1.44c.795 0 1.439-.645 1.439-1.44s-.644-1.44-1.439-1.44z"/></svg>
    </a>
    
    <a href="#" class="text-primary hover:text-[#C89B3C] transition-colors duration-300" aria-label="TikTok" style="display: inline-block;">
        <svg width="26" height="24" viewBox="0 0 24 24" fill="currentColor"><path d="M19.59 6.69a4.83 4.83 0 0 1-3.77-4.25V2h-3.45v13.67a2.89 2.89 0 0 1-5.77 0 2.89 2.89 0 0 1 2.5-2.87v-3.45a6.34 6.34 0 1 0 5.48 6.32V8.92a7.25 7.25 0 0 0 4.97 1.94V6.69z"/></svg>
    </a>
</li>
            </ul>
        </div>
    </div>
</div>

                    <div class="lg:w-7/12 w-full px-[15px]">
                        <div class="contact-form bg-[#f8f8f8] shadow-sm border border-[#eee]" style="padding: 50px !important;">
                            <h3 class="font-lobster mb-8 text-2xl">Send Us a Message</h3>
                            <br>
                            <div class="flex flex-wrap -mx-[10px]">
                                <div class="w-1/2 px-[10px] mb-[25px]">
                                    <label for="txtName" class="sr-only">Full Name</label>
                                    <asp:TextBox ID="txtName" runat="server" placeholder="Full Name" CssClass="w-full p-[15px] border border-[#ddd] transition-colors duration-300 hover:border-[#C89B3C] focus:border-[#C89B3C] focus:outline-none"
                                        onmouseover="this.style.borderColor='#C89B3C'" onmouseout="if(document.activeElement!==this){this.style.borderColor='#ddd';}" onfocus="this.style.borderColor='#C89B3C'" onblur="this.style.borderColor='#ddd'" />
                                </div>
                                <div class="w-1/2 px-[10px] mb-[25px]">
                                    <label for="txtPhone" class="sr-only">Phone Number</label>
                                    <asp:TextBox ID="txtPhone" runat="server" placeholder="Phone Number" CssClass="w-full p-[15px] border border-[#ddd] transition-colors duration-300 hover:border-[#C89B3C] focus:border-[#C89B3C] focus:outline-none"
                                        onmouseover="this.style.borderColor='#C89B3C'" onmouseout="if(document.activeElement!==this){this.style.borderColor='#ddd';}" onfocus="this.style.borderColor='#C89B3C'" onblur="this.style.borderColor='#ddd'" />
                                </div>
                                <div class="w-full px-[10px] mb-[25px]">
                                    <label for="txtEmail" class="sr-only">Email Address</label>
                                    <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" placeholder="Email Address" CssClass="w-full p-[15px] border border-[#ddd] transition-colors duration-300 hover:border-[#C89B3C] focus:border-[#C89B3C] focus:outline-none"
                                        onmouseover="this.style.borderColor='#C89B3C'" onmouseout="if(document.activeElement!==this){this.style.borderColor='#ddd';}" onfocus="this.style.borderColor='#C89B3C'" onblur="this.style.borderColor='#ddd'" />
                                </div>
                                <div class="w-full px-[10px] mb-[25px]">
                                    <label for="txtMessage" class="sr-only">Your Message</label>
                                    <asp:TextBox ID="txtMessage" runat="server" TextMode="MultiLine" Rows="5" CssClass="w-full p-[15px] border border-[#ddd] transition-colors duration-300 hover:border-[#C89B3C] focus:border-[#C89B3C] focus:outline-none" placeholder="Your Message"
                                        onmouseover="this.style.borderColor='#C89B3C'" onmouseout="if(document.activeElement!==this){this.style.borderColor='#ddd';}" onfocus="this.style.borderColor='#C89B3C'" onblur="this.style.borderColor='#ddd'" />
                                </div>
                                <div class="w-full text-center mt-[30px]">
				<a href="Pages/Menu.aspx" class="btn btn-md btn-primary btn-hover-1"><span>Send Message</span></a>
			</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Location / Map Section -->
        <section id="location" class="content-inner-1 pt-0">
            <div class="container">
                <div class="text-center mb-[40px]">
                    <span class="text-primary font-medium tracking-[0.2em] uppercase block mb-4">Visit Us</span>
                    <h3 class="font-lobster">Find Us On The Map</h3>
                </div>
            </div>
            <div class="contact-map">
                <iframe
                    src="https://www.google.com/maps?q=880+N+Poonch+Rd,+Samnabad+Town,+Lahore,+Pakistan&output=embed"
                    width="100%"
                    height="450"
                    frameborder="0"
                    loading="lazy"
                    allowfullscreen
                    referrerpolicy="no-referrer-when-downgrade"
                    title="Khan-e-Azam Restaurant Location"
                    class="block w-full">
                </iframe>
            </div>
        </section>

    </div>
    <br />
    
</asp:Content>
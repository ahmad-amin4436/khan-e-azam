<%@ Page Title="Contact Us" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="contact.aspx.cs" Inherits="khan_e_azam_website.contact" %>



<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        /* Responsive Overrides */
        @media (max-width: 1024px) {
            .contact-info-bx, .contact-form {
                padding: 30px !important;
            }
        }
    @media (max-width: 767px) {
        /* Force the columns to 1/3 width to stay horizontal */
        .mobile-row-fix > div {
            width: 33.33% !important;
            padding: 0 5px !important; /* Reduced padding for mobile fit */
        }
        
        /* Reduce font/icon sizes slightly for small screens */
        .mobile-row-fix .text-3xl {
            font-size: 0.5rem !important;
        }
        
        /* Hide text labels or buttons if they are too cramped, 
           or make text smaller */
        .mobile-row-fix span {
            font-size: 7px !important;
        }
        
        .mobile-row-fix .btn {
            font-size: 10px !important;
            padding: 5px 10px !important;
        }
    }
     @keyframes kePulse {
        0% {
            transform: scale(1);
            opacity: 1;
        }
        50% {
            transform: scale(1.2);
            opacity: 0.7;
        }
        100% {
            transform: scale(1);
            opacity: 1;
        }
    }

    </style>
     <div style="height: 80px;"></div>

    <div class="bg-white" style="width: 100%;">

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
                <div class="row flex-wrap mobile-row-fix" style="justify-content: center;">

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

                </div> </div>
        </div>

        <section class="content-inner">
            <div class="container">
                <div class="flex flex-wrap flex-col lg:flex-row items-start lg:gap-[60px]">

                    <div class="w-full lg:w-5/12 px-[15px] mb-[30px]">
                        <div class="contact-info-bx border border-[#eee] shadow-sm" style="padding: 50px;">
                            <h3 class="font-lobster" style="margin-bottom: 30px;">Contact Information</h3>
                            <ul style="list-style: none; padding: 0;">
                                <li style="margin-bottom: 25px; display: flex; align-items: flex-start;">
                                    <div class="text-xl text-primary" style="margin-right: 20px; width: 20px;"><i class="fas fa-map-marker-alt"></i></div>
                                    <span>880 N Poonch Rd, Samnabad Town, Lahore, Punjab 54000 Pakistan</span>
                                </li>
                               <li style="margin-bottom: 25px; display: flex; align-items: flex-start;">
    <div class="text-xl text-primary" style="margin-right: 20px; width: 20px;"><i class="fas fa-phone-alt"></i></div>
    <div style="display: flex; flex-direction: column; gap: 5px; color: #000;">
        <span>+92 42 3757 1100</span>
        <span>+92 309 9406789 (Hotel, Event)</span>
        <span>+92 308 9406789 (Restaurant)</span>
    </div>
</li>
                               <li style="margin-bottom: 25px; display: flex; align-items: flex-start;">
    <div class="text-xl text-primary" style="margin-right: 20px; width: 20px; flex-shrink: 0;"><i class="fas fa-envelope"></i></div>
    <div style="display: flex; flex-direction: column; gap: 5px; color: #000; width: 100%; overflow: hidden;">
        <span style="word-break: break-all;">khaneazamrestaurant@gmail.com</span>
        <span style="word-break: break-all;">khaneazamhotelevents@gmail.com</span>
    </div>
</li>
                                <li style="margin-bottom: 25px; display: flex; align-items: flex-start;">
                                    <div class="text-xl text-primary" style="margin-right: 20px; width: 20px;"><i class="fas fa-clock"></i></div>
                                    <div>
                                        <strong>Opening Hours:</strong><br/>
                                        Daily: 12:00 PM - 12:00 AM
                                    </div>
                                </li>
                            </ul>

                            <div style="margin-top: 30px; border-top: 1px solid #eee; padding-top: 20px;">
                                <h4 class="font-lobster mb-4">Follow Us</h4>
                                <div style="display: flex; gap: 15px;">
                                    <a href="#" style="font-size: 20px; color: #3b5998;"><i class="fab fa-facebook-f"></i></a>
                                    
                                    <a href="#" style="font-size: 20px; color: #e1306c;"><i class="fab fa-instagram"></i></a>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="w-full lg:w-7/12 px-[15px]">
                        <div class="contact-form bg-[#f8f8f8] shadow-sm border border-[#eee]" style="padding: 50px;">
                            <h3 class="font-lobster mb-8 text-2xl">Send Us a Message</h3>
                            <br />
                            <div class="flex flex-wrap -mx-[10px]">
                                <div class="w-full lg:w-1/2 px-[10px] mb-[25px]">
                                    <asp:TextBox ID="txtName" runat="server" placeholder="Full Name" 
                                        CssClass="w-full p-[15px] border border-[#ddd] transition-colors duration-300 focus:outline-none"
                                        onmouseover="this.style.borderColor='#C89B3C'" 
                                        onmouseout="if(document.activeElement!==this){this.style.borderColor='#ddd';}" 
                                        onfocus="this.style.borderColor='#C89B3C'" 
                                        onblur="this.style.borderColor='#ddd'" />
                                </div>
                                <div class="w-full lg:w-1/2 px-[10px] mb-[25px]">
                                    <asp:TextBox ID="txtPhone" runat="server" placeholder="Phone Number" 
                                        CssClass="w-full p-[15px] border border-[#ddd] transition-colors duration-300 focus:outline-none"
                                        onmouseover="this.style.borderColor='#C89B3C'" 
                                        onmouseout="if(document.activeElement!==this){this.style.borderColor='#ddd';}" 
                                        onfocus="this.style.borderColor='#C89B3C'" 
                                        onblur="this.style.borderColor='#ddd'" />
                                </div>
                                <div class="w-full px-[10px] mb-[25px]">
                                    <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" placeholder="Email Address" 
                                        CssClass="w-full p-[15px] border border-[#ddd] transition-colors duration-300 focus:outline-none"
                                        onmouseover="this.style.borderColor='#C89B3C'" 
                                        onmouseout="if(document.activeElement!==this){this.style.borderColor='#ddd';}" 
                                        onfocus="this.style.borderColor='#C89B3C'" 
                                        onblur="this.style.borderColor='#ddd'" />
                                </div>
                                <div class="w-full px-[10px] mb-[25px]">
                                    <asp:TextBox ID="txtMessage" runat="server" TextMode="MultiLine" Rows="5" placeholder="Your Message"
                                        CssClass="w-full p-[15px] border border-[#ddd] transition-colors duration-300 focus:outline-none"
                                        onmouseover="this.style.borderColor='#C89B3C'" 
                                        onmouseout="if(document.activeElement!==this){this.style.borderColor='#ddd';}" 
                                        onfocus="this.style.borderColor='#C89B3C'" 
                                        onblur="this.style.borderColor='#ddd'" />
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

        <!-- Visit Us Heading -->
<div class="text-center" style="padding-bottom: 40px; padding-top: 20px;">
    <span class="text-primary font-medium uppercase block mb-2" style="letter-spacing: 0.2em; font-size: 12px;">Visit Us</span>
    <h2 class="font-lobster" style="font-size: 2.5rem; color: #1A1208;">Our Location</h2>
</div>

<!-- Map Section -->
<section id="location" class="content-inner-1 pt-0">
    <div class="contact-map">
        <iframe 
            src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3401.3789452336694!2d74.30138237532392!3d31.51261384752538!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x391904a081525043%3A0xe54d31846b95764d!2s880%20N%20Poonch%20Rd%2C%20Samanabad%20Town%2C%20Lahore%2C%20Punjab%2054000%2C%20Pakistan!5e0!3m2!1sen!2s!4v1719570000000!5m2!1sen!2s" 
            width="100%" 
            height="450" 
            style="border:0;" 
            allowfullscreen="" 
            loading="lazy" 
            referrerpolicy="no-referrer-when-downgrade" 
            class="block w-full">
        </iframe>
    </div>
</section>
    </div>
     <div style="height: 80px;"></div>
</asp:Content>
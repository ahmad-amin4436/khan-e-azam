<%@ Page Title="Contact Us" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="contact.aspx.cs" Inherits="khan_e_azam_website.contact" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<div class="h-20"></div>
<!-- Hero Contact Section -->
<section class="relative py-24 px-6 text-center bg-black">
    <!-- Subtle Orange Glow at the bottom -->
    <div class="absolute inset-x-0 bottom-0 h-[2px] bg-gradient-to-r from-transparent via-[#2D220A] to-transparent"></div>

    <div class="mb-4 text-sm tracking-[0.2em] uppercase text-[#C89B3C]/70 font-bold">Get In Touch</div>
    
    <!-- Heading with Lobster Font and White Text -->
    <h1 class="font-['Lobster'] text-5xl md:text-6xl text-white mb-6">
        We'd Love to<br/>
        <span class="text-[#C89B3C]">Hear From You</span>
    </h1>
    <!-- Heart placed under all text -->
    <div class="text-[#C89B3C] text-3xl animate-pulse">
        ❤
    </div>
  
</section>

<!-- Action Strip -->
<div class="bg-[#C89B3C] py-16 px-6">
    <div class="max-w-6xl mx-auto">
    

        <div class="grid grid-cols-1 md:grid-cols-3 gap-8 text-center text-[#1A1208]">
            <!-- Action 1: Instant Reservation -->
            <div class="flex flex-col items-center gap-4">
                <span class="text-4xl">📅</span>
                <span class="text-[10px] uppercase tracking-widest font-bold opacity-70">Book a Table</span>
                <a href="#booking" class="px-6 py-2 border-2 border-[#1A1208] rounded-full font-bold transition-colors duration-300 hover:bg-[#1A1208] hover:text-white">Reserve Now</a>
            </div>
            
            <!-- Action 2: Direct Navigation -->
            <div class="flex flex-col items-center gap-4">
                <span class="text-4xl">📍</span>
                <span class="text-[10px] uppercase tracking-widest font-bold opacity-70">Find Us</span>
                <a href="https://maps.google.com" target="_blank" class="px-6 py-2 border-2 border-[#1A1208] rounded-full font-bold transition-colors duration-300 hover:bg-[#1A1208] hover:text-white">Open Maps</a>
            </div>
            
            <!-- Action 3: Order Online -->
            <div class="flex flex-col items-center gap-4">
                <span class="text-4xl">⚡</span>
                <span class="text-[10px] uppercase tracking-widest font-bold opacity-70">Order Online</span>
                <a href="/Menu" class="px-6 py-2 border-2 border-[#1A1208] rounded-full font-bold transition-colors duration-300 hover:bg-[#1A1208] hover:text-white">View Menu</a>
            </div>
        </div>
    </div>
</div>

    <!-- Contact Section -->
    <section class="py-20 px-6 bg-[#F8F5F0]">
        <div class="max-w-6xl mx-auto grid grid-cols-1 lg:grid-cols-2 gap-12 items-start">
            
            <!-- LEFT COLUMN: Info Card + Hours Card -->
            <div class="space-y-8">
                <!-- Contact Info Card -->
                <div class="bg-white p-10 rounded-[20px] shadow-sm border border-gray-100">
                    <h3 class="font-serif text-2xl text-[#1A1208] mb-8">Contact <span class="text-[#C89B3C]">Information</span></h3>
                    <div class="space-y-6">
                        <div class="flex gap-4 items-start">
                            <div class="w-12 h-12 flex items-center justify-center bg-[#FDFBF7] border border-amber-100 rounded-xl text-xl">📍</div>
                            <div>
                                <span class="text-[10px] uppercase font-bold tracking-widest text-gray-400">Address</span>
                                <p class="text-[#1A1208] font-medium">880 N Poonch Rd, Samnabad Town, Lahore, Punjab 54000 Pakistan</p>
                            </div>
                        </div>
                        <div class="flex gap-4 items-start">
                            <div class="w-12 h-12 flex items-center justify-center bg-[#FDFBF7] border border-amber-100 rounded-xl text-xl">📞</div>
                            <div>
                                <span class="text-[10px] uppercase font-bold tracking-widest text-gray-400">Phone</span>
                                <a href="tel:+924237571100" class="block text-[#1A1208] font-medium hover:text-[#C89B3C]">+92 42 3757 1100</a>
                                <a href="tel:+923089406789" class="block text-[#1A1208] font-medium hover:text-[#C89B3C]">+92 308 9406789 (Resturant)</a>
                                <a href="tel:+923099406789" class="block text-[#1A1208] font-medium hover:text-[#C89B3C]">+92 309 9406789 (Hotel , Event)</a>
                            </div>
                        </div>
                        <div class="flex gap-4 items-start">
                            <div class="w-12 h-12 flex items-center justify-center bg-[#FDFBF7] border border-amber-100 rounded-xl text-xl">✉️</div>
                            <div>
                                <span class="text-[10px] uppercase font-bold tracking-widest text-gray-400">Email</span>
                                <a href="mailto:hello@khaneazam.pk" class="block text-[#1A1208] font-medium hover:text-[#C89B3C]">khaneazamresturant@gmail.com</a>
                                 <a href="mailto:hello@khaneazam.pk" class="block text-[#1A1208] font-medium hover:text-[#C89B3C]">khaneazamhotelevents@gmail.com</a>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Hours Card -->
                <div class="bg-[#1A1208] p-10 rounded-[20px] shadow-sm text-white">
                    <h3 class="font-serif text-2xl mb-6">Opening <span class="text-[#C89B3C]">Hours</span></h3>
                    <div class="space-y-4 text-sm">
                        <div class="flex justify-between border-b border-gray-800 pb-2"><span>Monday – Thursday</span><span class="text-[#C89B3C]">12:00 PM – 1:00 AM</span></div>
                        <div class="flex justify-between border-b border-gray-800 pb-2"><span>Friday – Saturday</span><span class="text-[#C89B3C]">12:00 PM – 2:00 AM</span></div>
                        <div class="flex justify-between border-b border-gray-800 pb-2"><span>Sunday</span><span class="text-[#C89B3C]">1:00 PM – 1:00 AM</span></div>
                    </div>
                </div>
            </div>

            <!-- RIGHT COLUMN: Form -->
            <div class="bg-white p-10 rounded-[20px] shadow-lg border border-gray-100">
                <h3 class="font-serif text-2xl text-[#1A1208] mb-2">Send Us a <span class="text-[#C89B3C]">Message</span></h3>
                <p class="text-sm text-gray-500 mb-8">Fill in the form below and our team will respond within 24 hours.</p>
                
                <div class="grid grid-cols-1 md:grid-cols-2 gap-4 mb-4">
                    <input type="text" placeholder="Full Name" class="w-full p-4 bg-[#FDFBF7] border border-amber-100 rounded-xl focus:border-[#C89B3C] outline-none" />
                    <input type="tel" placeholder="Phone Number" class="w-full p-4 bg-[#FDFBF7] border border-amber-100 rounded-xl focus:border-[#C89B3C] outline-none" />
                </div>
                <input type="email" placeholder="Email Address" class="w-full p-4 bg-[#FDFBF7] border border-amber-100 rounded-xl mb-4 focus:border-[#C89B3C] outline-none" />
                <textarea rows="5" class="w-full p-4 bg-[#FDFBF7] border border-amber-100 rounded-xl mb-6 focus:border-[#C89B3C] outline-none" placeholder="Write your message here..."></textarea>
                <button class="w-full py-4 bg-[#1A1208] text-white rounded-full font-bold uppercase tracking-widest hover:bg-[#C89B3C] transition">
                    Send Message
                </button>
            </div>
        </div>
    </section>

    <!-- Map Section -->
    <section class="py-20 px-6 bg-[#FDFBF7]">
        <div class="max-w-6xl mx-auto">
            <h3 class="font-serif text-3xl text-[#1A1208] mb-8 text-center">Visit Our <span class="text-[#C89B3C]">Location</span></h3>
            <div class="w-full h-[400px] rounded-[20px] overflow-hidden shadow-lg">
                <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d54396.27395428604!2d74.28564735!3d31.5203696!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x391904d0b9f29c67%3A0x2c2a2f5b1bf9bf6f!2sGulberg%2C%20Lahore%2C%20Punjab%2C%20Pakistan!5e0!3m2!1sen!2sus!4v1700000000000" class="w-full h-full border-0" allowfullscreen="" loading="lazy"></iframe>
            </div>
        </div>
    </section>

</asp:Content>

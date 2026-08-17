<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Blank.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="khan_e_azam_website.Home" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
    <link rel="stylesheet" href="<%= ResolveUrl("~/assets/css/home.css") %>" />
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="home-page">
        <section id="home" class="hero-section">
            <div class="hero-media">
                <video class="hero-video kenburns" src="<%= ResolveUrl("~/assets/video/background.mp4") %>" poster="<%= ResolveUrl("~/assets/hero-1.jpg") %>" autoplay muted loop playsinline aria-hidden="true"></video>
              <%--  <div class="hero-images" aria-hidden="true">
                    <div class="hero-slide is-active">
                        <img class="hero-slide-img" src="<%= ResolveUrl("~/assets/hero-1.jpg") %>" alt="Flames rising inside a wood-fired oven" width="1920" height="1080" fetchpriority="high" />
                    </div>
                    <div class="hero-slide">
                        <img class="hero-slide-img" src="<%= ResolveUrl("~/assets/hero-2.jpg") %>" alt="A burger silhouetted in warm low light" width="1920" height="1080" loading="lazy" />
                    </div>
                    <div class="hero-slide">
                        <img class="hero-slide-img" src="<%= ResolveUrl("~/assets/hero-3.jpg") %>" alt="Steam and flour drifting above hand-made pasta" width="1920" height="1080" loading="lazy" />
                    </div>
                </div>--%>
            </div>
            <div class="hero-overlay"></div>
            <div class="hero-overlay-radial"></div>
            <div class="hero-copy">
                <p class="eyebrow hero-animate hero-animate--1">Est. 2026 - Dining</p>
                <h1 class="hero-title hero-animate hero-animate--2">
                    Something <span class="gradient-text gradient-text--italic">Extraordinary</span><br />
                    is Cooking
                </h1>
               
               <%-- <div class="hero-slide-dots" aria-label="Hero slides">
                    <button type="button" class="hero-slide-dot is-active" aria-label="Show slide 1" aria-current="true"></button>
                    <button type="button" class="hero-slide-dot" aria-label="Show slide 2" aria-current="false"></button>
                    <button type="button" class="hero-slide-dot" aria-label="Show slide 3" aria-current="false"></button>
                </div>--%>
            </div>
          <div class="hero-actions hero-animate hero-animate--4">

    <div class="hero-buttons">
        <a href="#launch" class="button button-primary">Notify Me</a>
        <a href="#experience" class="button button-secondary">
            Explore the Experience
        </a>
    </div>

    <p class="hero-description hero-animate hero-animate--3">
        An unforgettable dining experience arrives on 25 August.
    </p>

</div>
</div>
        
        </section>
           
        <section class="marquee-bar" aria-label="Launch announcements">
            <div class="marquee-track">
                <div class="marquee-line" aria-hidden="true">
                    <span>🔥 Launching on 25 August</span>
                    <span>A New Culinary Experience is Coming</span>
                    <span>Stay Tuned</span>
                    <span>Grand Opening Soon</span>
                </div>
                <div class="marquee-line" aria-hidden="true">
                    <span>🔥 Launching on 25 August</span>
                    <span>A New Culinary Experience is Coming</span>
                    <span>Stay Tuned</span>
                    <span>Grand Opening Soon</span>
                </div>
            </div>
        </section>

        <section id="experience" class="experience-section">
            <div class="experience-grid">
                <div class="experience-copy">
                    <div class="reveal">
                        <span class="eyebrow eyebrow--wide">The Anticipation</span>
                        <h2>An Experience Worth Waiting For</h2>
                    </div>
                    <div class="reveal reveal--delay-1 experience-text">
                        <p>Behind closed doors, a room is being built for slow evenings and long conversations. Low light. Warm stone. A kitchen that runs on fire rather than hurry.</p>
                        <p>Our kitchen team has spent a year refining a handful of dishes — each one shaped by patience, sourced with intention, and finished only when it is worth serving.</p>
                        <p>We are not ready to show you everything. Not yet. But on <span class="highlight">25 August</span>, the doors open.</p>
                    </div>
                    <div class="reveal reveal--delay-2 experience-divider" aria-hidden="true"></div>
                </div>
                <div class="reveal reveal--delay-1 experience-visual">
                    <video class="experience-video" src="<%= ResolveUrl("~/assets/video/side.mp4") %>" poster="<%= ResolveUrl("~/assets/experience.jpg") %>" autoplay muted loop playsinline aria-label="Candlelit dining atmosphere"></video>
                    <div class="experience-visual-gradient"></div>
                    <div class="experience-card">
                        <p class="experience-card-label">Reservations open soon</p>
                    </div>
                </div>
            </div>
        </section>

        <section class="collection-section">
            <div class="section-heading">
                <span class="eyebrow">Signature Collection</span>
                <h2>What's Waiting For You</h2>
                <p>From hand-stretched pasta to curated tasting experiences, every dish is designed to invite you in.</p>
            </div>
            <div class="collection-grid">
                <article class="collection-card">
                    <div class="collection-card-media">
                        <img src="<%= ResolveUrl("~/assets/card-pizza.jpg") %>" alt="Pizza" />
                        <div class="collection-card-media-gradient"></div>
                    </div>
                    <div class="collection-content">
                        <h3>Pizza</h3>
                        <p>Stone baked perfection... almost ready.</p>
                    </div>
                </article>
                <article class="collection-card">
                    <div class="collection-card-media">
                        <img src="<%= ResolveUrl("~/assets/card-burger.jpg") %>" alt="Burger" />
                        <div class="collection-card-media-gradient"></div>
                    </div>
                    <div class="collection-content">
                        <h3>Burger</h3>
                        <p>Layers of flavor waiting to be discovered.</p>
                    </div>
                </article>
                <article class="collection-card">
                    <div class="collection-card-media">
                        <img src="<%= ResolveUrl("~/assets/card-sandwich.jpg") %>" alt="Sandwich" />
                        <div class="collection-card-media-gradient"></div>
                    </div>
                    <div class="collection-content">
                        <h3>Sandwich</h3>
                        <p>Crafted with ingredients worth the wait.</p>
                    </div>
                </article>
                <article class="collection-card">
                    <div class="collection-card-media">
                        <img src="<%= ResolveUrl("~/assets/card-pasta.jpg") %>" alt="Pasta" />
                        <div class="collection-card-media-gradient"></div>
                    </div>
                    <div class="collection-content">
                        <h3>Pasta</h3>
                        <p>Premium oven baked pasta, golden and bubbling.</p>
                    </div>
                </article>
                <article class="collection-card">
                    <div class="collection-card-media">
                        <img src="<%= ResolveUrl("~/assets/card-more.jpg") %>" alt="And many more" />
                        <div class="collection-card-media-gradient"></div>
                    </div>
                    <div class="collection-content">
                        <h3>And many more</h3>
                        <p>A full menu of surprises yet to be revealed.</p>
                    </div>
                </article>
            </div>
        </section>

        <section id="launch" class="countdown-section">
            <div class="countdown-inner">
                <div class="reveal countdown-header">
                    <span class="eyebrow eyebrow--wide">The Countdown</span>
                    <h2>Doors Open 25 August</h2>
                </div>
                <ul class="reveal reveal--delay-1 countdown-grid">
                    <li class="countdown-card pulse-glow">
                        <span class="countdown-value" data-countdown="days" aria-hidden="true">00</span>
                        <span class="countdown-label">Days</span>
                    </li>
                    <li class="countdown-card pulse-glow">
                        <span class="countdown-value" data-countdown="hours" aria-hidden="true">00</span>
                        <span class="countdown-label">Hours</span>
                    </li>
                    <li class="countdown-card pulse-glow">
                        <span class="countdown-value" data-countdown="minutes" aria-hidden="true">00</span>
                        <span class="countdown-label">Minutes</span>
                    </li>
                    <li class="countdown-card pulse-glow">
                        <span class="countdown-value" data-countdown="seconds" aria-hidden="true">00</span>
                        <span class="countdown-label">Seconds</span>
                    </li>
                </ul>
            </div>
            <div class="countdown-cta reveal reveal--delay-2">
            </div>
        </section>

        <section id="notify" class="notify-section">
            <div class="notify-content">
                <span class="eyebrow">Join the guest list</span>
                <h2>Be the first to know when reservations open.</h2>

                            <a href="#launch" class="button button-primary">Notify Me</a>

                <asp:Label ID="lblNotifyMessage" runat="server" CssClass="notify-message" />
            </div>
        </section>
    </div>

    <script src="<%= ResolveUrl("~/assets/js/home-teaser.js") %>"></script>
</asp:Content>

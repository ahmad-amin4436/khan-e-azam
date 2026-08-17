import { createFileRoute } from "@tanstack/react-router";

import { Ambience } from "@/components/teaser/Ambience";
import { Collection } from "@/components/teaser/Collection";
import { Countdown } from "@/components/teaser/Countdown";
import { Experience } from "@/components/teaser/Experience";
import { Footer } from "@/components/teaser/Footer";
import { Header } from "@/components/teaser/Header";
import { Hero } from "@/components/teaser/Hero";
import { Marquee } from "@/components/teaser/Marquee";
import { Notify } from "@/components/teaser/Notify";

const title = "Maison — Something Extraordinary is Cooking";
const description =
  "A new fine dining destination opens 25 August. Join the guest list for exclusive launch updates from Maison.";

export const Route = createFileRoute("/")({
  head: () => ({
    meta: [
      { title },
      { name: "description", content: description },
      { property: "og:title", content: title },
      { property: "og:description", content: description },
      { property: "og:type", content: "website" },
      { name: "twitter:card", content: "summary_large_image" },
    ],
  }),
  component: Index,
});

function Index() {
  return (
    <div className="relative min-h-screen overflow-x-hidden bg-background noise">
      <Ambience />
      <Header />
      <main className="relative z-10">
        <Hero />
        <Marquee />
        <Experience />
        <Collection />
        <Countdown />
        <Notify />
      </main>
      <Footer />
    </div>
  );
}

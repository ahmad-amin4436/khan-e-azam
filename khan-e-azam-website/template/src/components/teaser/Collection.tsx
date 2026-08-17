import burger from "@/assets/card-burger.jpg";
import more from "@/assets/card-more.jpg";
import pasta from "@/assets/card-pasta.jpg";
import pizza from "@/assets/card-pizza.jpg";
import sandwich from "@/assets/card-sandwich.jpg";
import { Reveal } from "./Reveal";

const CARDS = [
  { title: "Pizza", src: pizza, copy: "Stone baked perfection... almost ready." },
  { title: "Burger", src: burger, copy: "Layers of flavor waiting to be discovered." },
  { title: "Sandwich", src: sandwich, copy: "Crafted with ingredients worth the wait." },
  { title: "Pasta", src: pasta, copy: "Premium oven baked pasta, golden and bubbling." },
  { title: "And many more", src: more, copy: "A full menu of surprises yet to be revealed." },
];

export function Collection() {

  return (
    <section className="relative z-10 px-6 py-28 md:px-10 md:py-40">
      <div className="mx-auto max-w-6xl">
        <Reveal>
          <div className="text-center">
            <p className="text-[0.65rem] tracking-[0.45em] text-gold uppercase">
              Signature Collection
            </p>
            <h2 className="mt-6 font-display text-[clamp(2rem,5vw,3.75rem)] font-light">
              What's Waiting For You
            </h2>
          </div>
        </Reveal>

        <ul className="mt-16 grid gap-6 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-5">
          {CARDS.map((card, i) => (
            <li key={card.title}>
              <Reveal delay={i * 0.12}>
                <article className="group relative overflow-hidden rounded-md border border-gold/15 glass shadow-luxe transition-all duration-700 hover:-translate-y-2 hover:border-gold/45 hover:shadow-[var(--glow-gold-strong)]">
                  <div className="relative aspect-4/5 overflow-hidden">
                    <img
                      src={card.src}
                      alt={`${card.title}, shot in low light`}
                      width={900}
                      height={1100}
                      loading="lazy"
                      className="h-full w-full object-cover transition-transform duration-[1200ms] ease-out group-hover:scale-110"
                    />
                    <div className="absolute inset-0 bg-[linear-gradient(to_top,color-mix(in_oklab,var(--background)_88%,transparent),transparent_60%)]" />
                  </div>
                  <div className="relative px-6 pt-5 pb-7">
                    <h3 className="font-display text-2xl font-light text-foreground">
                      {card.title}
                    </h3>
                    <p className="mt-2 text-xs leading-relaxed text-muted-foreground">
                      {card.copy}
                    </p>
                  </div>
                </article>
              </Reveal>
            </li>
          ))}
        </ul>
      </div>
    </section>
  );
}

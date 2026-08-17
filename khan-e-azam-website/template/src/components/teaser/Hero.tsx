import { AnimatePresence, motion, useReducedMotion } from "motion/react";
import { useEffect, useState } from "react";

import hero1 from "@/assets/hero-1.jpg";
import hero2 from "@/assets/hero-2.jpg";
import hero3 from "@/assets/hero-3.jpg";

const SLIDES = [
  { src: hero1, alt: "Flames rising inside a wood-fired oven" },
  { src: hero2, alt: "A burger silhouetted in warm low light" },
  { src: hero3, alt: "Steam and flour drifting above hand-made pasta" },
];

export function Hero() {
  const [index, setIndex] = useState(0);
  const reduce = useReducedMotion();

  useEffect(() => {
    const id = window.setInterval(
      () => setIndex((i) => (i + 1) % SLIDES.length),
      6500,
    );
    return () => window.clearInterval(id);
  }, []);

  return (
    <section
      id="home"
      className="relative flex min-h-[100svh] items-center overflow-hidden noise"
    >
      <div className="absolute inset-0">
        <AnimatePresence initial={false}>
          <motion.div
            key={index}
            className="absolute inset-0"
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            exit={{ opacity: 0 }}
            transition={{ duration: 1.6, ease: "easeInOut" }}
          >
            <img
              src={SLIDES[index]!.src}
              alt={SLIDES[index]!.alt}
              width={1920}
              height={1080}
              fetchPriority={index === 0 ? "high" : "low"}
              className={`h-full w-full object-cover ${reduce ? "" : "kenburns"}`}
            />
          </motion.div>
        </AnimatePresence>
        <div className="absolute inset-0 bg-[linear-gradient(to_top,var(--background)_2%,transparent_55%)]" />
        <div className="absolute inset-0 bg-[radial-gradient(ellipse_at_center,transparent_10%,color-mix(in_oklab,var(--background)_88%,transparent)_85%)]" />
      </div>

      <div className="relative z-10 mx-auto w-full max-w-5xl px-6 pt-32 pb-24 text-center md:pt-40">
        <motion.p
          initial={{ opacity: 0, y: 14 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 1, delay: 0.2 }}
          className="text-[0.65rem] tracking-[0.5em] text-gold uppercase"
        >
          Est. 2026 — Fine Dining
        </motion.p>

        <motion.h1
          initial={{ opacity: 0, y: 26 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 1.2, delay: 0.4, ease: [0.22, 1, 0.36, 1] }}
          className="mt-8 font-display text-[clamp(2.75rem,8vw,6.5rem)] leading-[1.02] font-light tracking-tight text-balance"
        >
          Something <span className="text-gradient-gold italic">Extraordinary</span>
          <br />
          is Cooking
        </motion.h1>

        <motion.p
          initial={{ opacity: 0, y: 18 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 1, delay: 0.7 }}
          className="mx-auto mt-8 max-w-xl text-sm leading-relaxed text-muted-foreground sm:text-base"
        >
          An unforgettable dining experience arrives on 25 August.
        </motion.p>

        <motion.div
          initial={{ opacity: 0, y: 18 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 1, delay: 0.9 }}
          className="mt-12 flex flex-col items-center justify-center gap-4 sm:flex-row"
        >
          <a
            href="#launch"
            className="rounded-full bg-gold px-9 py-3.5 text-[0.7rem] tracking-[0.28em] text-primary-foreground uppercase transition-all duration-500 hover:shadow-[var(--glow-gold-strong)]"
          >
            Notify Me
          </a>
          <a
            href="#experience"
            className="rounded-full border border-border px-9 py-3.5 text-[0.7rem] tracking-[0.28em] text-foreground uppercase transition-all duration-500 hover:border-gold/60 hover:text-gold"
          >
            Explore the Experience
          </a>
        </motion.div>

        <div className="mt-16 flex items-center justify-center gap-2">
          {SLIDES.map((s, i) => (
            <button
              key={s.alt}
              type="button"
              aria-label={`Show slide ${i + 1}`}
              onClick={() => setIndex(i)}
              className={`h-px transition-all duration-500 ${
                i === index ? "w-12 bg-gold" : "w-6 bg-border hover:bg-gold/50"
              }`}
            />
          ))}
        </div>
      </div>
    </section>
  );
}

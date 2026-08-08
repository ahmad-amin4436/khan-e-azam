import { motion, useScroll, useTransform } from "motion/react";
import { useRef } from "react";

import experienceImg from "@/assets/experience.jpg";
import { Reveal } from "./Reveal";

export function Experience() {
  const ref = useRef<HTMLDivElement>(null);
  const { scrollYProgress } = useScroll({
    target: ref,
    offset: ["start end", "end start"],
  });
  const y = useTransform(scrollYProgress, [0, 1], ["-8%", "8%"]);

  return (
    <section id="experience" className="relative z-10 px-6 py-28 md:px-10 md:py-40">
      <div className="mx-auto grid max-w-6xl items-center gap-14 md:grid-cols-2 md:gap-20">
        <div>
          <Reveal>
            <p className="text-[0.65rem] tracking-[0.45em] text-gold uppercase">
              The Anticipation
            </p>
            <h2 className="mt-6 font-display text-[clamp(2rem,5vw,3.75rem)] leading-[1.1] font-light">
              An Experience Worth Waiting For
            </h2>
          </Reveal>

          <Reveal delay={0.15}>
            <div className="mt-8 space-y-6 text-sm leading-loose text-muted-foreground sm:text-base">
              <p>
                Behind closed doors, a room is being built for slow evenings and
                long conversations. Low light. Warm stone. A kitchen that runs on
                fire rather than hurry.
              </p>
              <p>
                Our kitchen team has spent a year refining a handful of dishes —
                each one shaped by patience, sourced with intention, and finished
                only when it is worth serving.
              </p>
              <p>
                We are not ready to show you everything. Not yet. But on
                <span className="text-gold"> 25 August</span>, the doors open.
              </p>
            </div>
          </Reveal>

          <Reveal delay={0.25}>
            <div className="mt-10 h-px w-24 bg-gradient-to-r from-gold to-transparent" />
          </Reveal>
        </div>

        <Reveal delay={0.1}>
          <div
            ref={ref}
            className="relative aspect-4/5 overflow-hidden rounded-sm border border-border shadow-luxe"
          >
            <motion.img
              src={experienceImg}
              alt="Candlelit table setting in a darkened dining room"
              width={1200}
              height={1500}
              loading="lazy"
              style={{ y }}
              className="h-[116%] w-full object-cover"
            />
            <div className="absolute inset-0 bg-[linear-gradient(to_top,color-mix(in_oklab,var(--background)_75%,transparent),transparent_55%)]" />
            <div className="absolute right-5 bottom-5 left-5 glass rounded-sm px-5 py-4">
              <p className="font-display text-lg text-foreground">
                Twenty-four seats. One seating a night.
              </p>
              <p className="mt-1 text-[0.65rem] tracking-[0.3em] text-gold uppercase">
                Reservations open soon
              </p>
            </div>
          </div>
        </Reveal>
      </div>
    </section>
  );
}

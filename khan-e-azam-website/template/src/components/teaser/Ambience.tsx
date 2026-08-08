import { motion, useReducedMotion } from "motion/react";
import { useMemo } from "react";

const SEEDS: Array<[number, number, number, number]> = [
  [8, 82, 15, 0], [21, 34, 19, 3], [33, 68, 13, 6], [45, 12, 21, 2],
  [57, 91, 16, 8], [64, 45, 23, 1], [72, 24, 14, 5], [81, 74, 18, 4],
  [88, 38, 20, 7], [94, 60, 15, 2], [14, 55, 17, 9], [39, 88, 22, 5],
];

/** Floating gold particles + ambient orbs behind the page content. */
export function Ambience() {
  const reduce = useReducedMotion();
  const particles = useMemo(() => SEEDS, []);

  return (
    <div aria-hidden className="pointer-events-none fixed inset-0 z-0 overflow-hidden">
      <div className="absolute -top-40 left-1/2 h-[46rem] w-[46rem] -translate-x-1/2 rounded-full bg-[radial-gradient(circle,color-mix(in_oklab,var(--gold)_16%,transparent),transparent_65%)] blur-3xl" />
      <div className="absolute top-1/3 -left-40 h-[34rem] w-[34rem] rounded-full bg-[radial-gradient(circle,color-mix(in_oklab,var(--amber-warm)_12%,transparent),transparent_68%)] blur-3xl" />
      <div className="absolute bottom-0 -right-32 h-[38rem] w-[38rem] rounded-full bg-[radial-gradient(circle,color-mix(in_oklab,var(--gold)_10%,transparent),transparent_68%)] blur-3xl" />

      {!reduce &&
        particles.map(([x, y, dur, delay], i) => (
          <motion.span
            key={i}
            className="absolute h-[3px] w-[3px] rounded-full bg-gold/50"
            style={{ left: `${x}%`, top: `${y}%` }}
            animate={{ y: [0, -90, 0], opacity: [0, 0.7, 0] }}
            transition={{
              duration: dur,
              delay,
              repeat: Infinity,
              ease: "easeInOut",
            }}
          />
        ))}
    </div>
  );
}

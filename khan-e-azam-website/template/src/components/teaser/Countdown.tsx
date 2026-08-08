import { useEffect, useState } from "react";

import { Reveal } from "./Reveal";

const TARGET = new Date("2026-08-25T19:00:00Z").getTime();

function remaining() {
  const diff = Math.max(0, TARGET - Date.now());
  return {
    Days: Math.floor(diff / 86400000),
    Hours: Math.floor((diff / 3600000) % 24),
    Minutes: Math.floor((diff / 60000) % 60),
    Seconds: Math.floor((diff / 1000) % 60),
  };
}

export function Countdown() {
  const [time, setTime] = useState(remaining);

  useEffect(() => {
    const id = window.setInterval(() => setTime(remaining()), 1000);
    return () => window.clearInterval(id);
  }, []);

  return (
    <section className="relative z-10 px-6 py-28 md:px-10 md:py-36">
      <div className="mx-auto max-w-5xl text-center">
        <Reveal>
          <p className="text-[0.65rem] tracking-[0.45em] text-gold uppercase">
            The Countdown
          </p>
          <h2 className="mt-6 font-display text-[clamp(1.9rem,4.5vw,3.25rem)] font-light">
            Doors Open 25 August
          </h2>
        </Reveal>

        <Reveal delay={0.15}>
          <ul className="mt-14 grid grid-cols-2 gap-4 sm:grid-cols-4 sm:gap-6">
            {Object.entries(time).map(([label, value]) => (
              <li
                key={label}
                className="glass pulse-glow rounded-md px-4 py-8 sm:py-10"
              >
                <span
                  className="block font-display text-[clamp(2.25rem,6vw,3.75rem)] leading-none text-gradient-gold tabular-nums"
                  aria-hidden
                >
                  {String(value).padStart(2, "0")}
                </span>
                <span className="mt-4 block text-[0.6rem] tracking-[0.35em] text-muted-foreground uppercase">
                  {label}
                </span>
                <span className="sr-only">{`${value} ${label.toLowerCase()} remaining`}</span>
              </li>
            ))}
          </ul>
        </Reveal>
      </div>
    </section>
  );
}

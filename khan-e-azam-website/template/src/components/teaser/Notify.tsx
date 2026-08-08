import { useState, type FormEvent } from "react";

import { Reveal } from "./Reveal";

export function Notify() {
  const [email, setEmail] = useState("");
  const [done, setDone] = useState(false);

  function onSubmit(e: FormEvent) {
    e.preventDefault();
    if (!email) return;
    setDone(true);
    setEmail("");
  }

  return (
    <section id="launch" className="relative z-10 px-6 py-28 md:px-10 md:py-44">
      <div className="mx-auto max-w-2xl text-center">
        <Reveal>
          <h2 className="font-display text-[clamp(2rem,5.5vw,4rem)] leading-tight font-light">
            Be First Through the Door
          </h2>
          <p className="mt-6 text-sm text-muted-foreground sm:text-base">
            Join our guest list for exclusive launch updates.
          </p>
        </Reveal>

        <Reveal delay={0.15}>
          <form
            onSubmit={onSubmit}
            className="mx-auto mt-14 flex max-w-lg flex-col gap-3 sm:flex-row"
          >
            <label htmlFor="notify-email" className="sr-only">
              Email address
            </label>
            <input
              id="notify-email"
              type="email"
              required
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              placeholder="your@email.com"
              className="min-w-0 flex-1 rounded-full border border-border bg-surface px-6 py-4 text-sm text-foreground placeholder:text-muted-foreground/60 transition-colors focus:border-gold/60 focus:outline-none"
            />
            <button
              type="submit"
              className="shrink-0 rounded-full bg-gold px-8 py-4 text-[0.7rem] tracking-[0.28em] text-primary-foreground uppercase transition-all duration-500 hover:shadow-[var(--glow-gold-strong)]"
            >
              Notify Me
            </button>
          </form>

          <p
            role="status"
            className={`mt-6 text-xs tracking-[0.2em] text-gold uppercase transition-opacity duration-500 ${
              done ? "opacity-100" : "opacity-0"
            }`}
          >
            You're on the list. We'll be in touch.
          </p>
        </Reveal>
      </div>
    </section>
  );
}

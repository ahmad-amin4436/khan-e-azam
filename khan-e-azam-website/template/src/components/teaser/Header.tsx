import { AnimatePresence, motion } from "motion/react";
import { useEffect, useState } from "react";

const NAV = [
  { label: "Home", href: "#home" },
  { label: "Experience", href: "#experience" },
  { label: "Launch", href: "#launch" },
];

export function Header() {
  const [scrolled, setScrolled] = useState(false);
  const [open, setOpen] = useState(false);

  useEffect(() => {
    const onScroll = () => setScrolled(window.scrollY > 24);
    onScroll();
    window.addEventListener("scroll", onScroll, { passive: true });
    return () => window.removeEventListener("scroll", onScroll);
  }, []);

  return (
    <header
      className={`fixed inset-x-0 top-0 z-50 transition-all duration-500 ${
        scrolled
          ? "border-b border-border bg-background/70 backdrop-blur-xl"
          : "border-b border-transparent bg-transparent"
      }`}
    >
      <div className="mx-auto grid max-w-7xl grid-cols-[minmax(0,1fr)_auto] items-center gap-4 px-5 py-4 md:grid-cols-3 md:px-10 md:py-5">
        <a href="#home" className="flex min-w-0 items-center gap-3">
          <span className="grid h-9 w-9 shrink-0 place-items-center rounded-full border border-gold/40 font-display text-base text-gold">
            M
          </span>
          <span className="truncate font-display text-xl tracking-[0.32em] text-foreground uppercase">
            Maison
          </span>
        </a>

        <nav aria-label="Primary" className="hidden justify-center md:flex">
          <ul className="flex items-center gap-10">
            {NAV.map((item) => (
              <li key={item.href}>
                <a
                  href={item.href}
                  className="text-[0.7rem] tracking-[0.28em] text-muted-foreground uppercase transition-colors hover:text-gold"
                >
                  {item.label}
                </a>
              </li>
            ))}
          </ul>
        </nav>

        <div className="flex items-center justify-end gap-3">
          <a
            href="#launch"
            className="hidden rounded-full border border-gold/50 px-6 py-2.5 text-[0.68rem] tracking-[0.26em] text-gold uppercase transition-all duration-500 hover:border-gold hover:bg-gold/10 hover:shadow-[var(--glow-gold-strong)] glow-gold sm:inline-block"
          >
            Coming Soon
          </a>
          <button
            type="button"
            aria-label={open ? "Close menu" : "Open menu"}
            aria-expanded={open}
            onClick={() => setOpen((v) => !v)}
            className="grid h-10 w-10 shrink-0 place-items-center rounded-full border border-border md:hidden"
          >
            <span className="relative block h-3 w-4">
              <motion.span
                className="absolute left-0 block h-px w-full bg-gold"
                animate={open ? { rotate: 45, top: 6 } : { rotate: 0, top: 0 }}
                transition={{ duration: 0.3 }}
              />
              <motion.span
                className="absolute left-0 block h-px w-full bg-gold"
                animate={open ? { rotate: -45, top: 6 } : { rotate: 0, top: 12 }}
                transition={{ duration: 0.3 }}
              />
            </span>
          </button>
        </div>
      </div>

      <AnimatePresence>
        {open && (
          <motion.nav
            aria-label="Mobile"
            initial={{ height: 0, opacity: 0 }}
            animate={{ height: "auto", opacity: 1 }}
            exit={{ height: 0, opacity: 0 }}
            transition={{ duration: 0.4, ease: [0.22, 1, 0.36, 1] }}
            className="overflow-hidden border-t border-border bg-background/95 backdrop-blur-xl md:hidden"
          >
            <ul className="flex flex-col gap-6 px-6 py-8">
              {NAV.map((item) => (
                <li key={item.href}>
                  <a
                    href={item.href}
                    onClick={() => setOpen(false)}
                    className="font-display text-2xl tracking-wide text-foreground"
                  >
                    {item.label}
                  </a>
                </li>
              ))}
              <li>
                <a
                  href="#launch"
                  onClick={() => setOpen(false)}
                  className="inline-block rounded-full border border-gold/50 px-6 py-2.5 text-[0.68rem] tracking-[0.26em] text-gold uppercase"
                >
                  Coming Soon
                </a>
              </li>
            </ul>
          </motion.nav>
        )}
      </AnimatePresence>
    </header>
  );
}

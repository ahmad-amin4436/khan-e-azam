import { Facebook, Instagram, Twitter } from "lucide-react";

const SOCIALS = [
  { label: "Instagram", Icon: Instagram },
  { label: "Facebook", Icon: Facebook },
  { label: "X", Icon: Twitter },
];

export function Footer() {
  return (
    <footer className="relative z-10 border-t border-gold/20 bg-[#050505] px-6 py-14 md:px-10">
      <div className="mx-auto flex max-w-6xl flex-col items-center gap-8 text-center md:flex-row md:justify-between md:text-left">
        <div className="flex items-center gap-3">
          <span className="grid h-9 w-9 shrink-0 place-items-center rounded-full border border-gold/40 font-display text-base text-gold">
            M
          </span>
          <div>
            <p className="font-display text-lg tracking-[0.3em] uppercase">Maison</p>
            <p className="text-[0.62rem] tracking-[0.3em] text-gold uppercase">
              Launching on 25 August
            </p>
          </div>
        </div>

        <ul className="flex items-center gap-3">
          {SOCIALS.map(({ label, Icon }) => (
            <li key={label}>
              <a
                href="#launch"
                aria-label={label}
                className="grid h-10 w-10 place-items-center rounded-full border border-border text-muted-foreground transition-all duration-500 hover:border-gold/60 hover:text-gold"
              >
                <Icon className="h-4 w-4" aria-hidden />
              </a>
            </li>
          ))}
        </ul>

        <p className="text-[0.65rem] tracking-[0.2em] text-muted-foreground/70 uppercase">
          © {new Date().getFullYear()} Maison. All rights reserved.
        </p>
      </div>
    </footer>
  );
}

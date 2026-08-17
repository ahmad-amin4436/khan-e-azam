const ITEMS = [
  "🔥 Launching on 25 August",
  "A New Culinary Experience is Coming",
  "Stay Tuned",
  "Grand Opening Soon",
];

export function Marquee() {
  const line = [...ITEMS, ...ITEMS, ...ITEMS];

  return (
    <div className="group relative overflow-hidden border-y border-border bg-[#101010]/80 py-3 backdrop-blur-md">
      <div className="marquee-track flex w-max gap-12 group-hover:[animation-play-state:paused]">
        {[0, 1].map((dup) => (
          <div key={dup} className="flex shrink-0 gap-12" aria-hidden={dup === 1}>
            {line.map((item, i) => (
              <span
                key={`${dup}-${i}`}
                className="flex items-center gap-12 text-[0.68rem] tracking-[0.3em] text-gold uppercase whitespace-nowrap"
              >
                {item}
                <span className="text-gold/40">•</span>
              </span>
            ))}
          </div>
        ))}
      </div>
    </div>
  );
}

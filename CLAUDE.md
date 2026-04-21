# CLAUDE.md — SumiDay

> Brand name locked 2026-04-16. Domain: sumi.day. Bundle: com.sumiday.sumi.
> Prior working title "Sages" is retired — do not use.

> This is the project's master working-memory document. Any Claude session working on this project MUST read this file first. Update it whenever a major decision changes.

Last updated: 2026-04-16
Chairman: Mr. Han (hanzewei@gmail.com)
General Manager: Claude (this conversation is the strategic hub)

---

## 1. North Star

**SumiDay** is a premium iOS app that helps globally-distributed seekers engage seriously with classical wisdom traditions (Zen, Taoism, Confucianism, Buddhism) through AI-native daily practice. Positioned as the East-Asian-canon-first counterpart to Sam Harris's *Waking Up*.

**Brand metaphor**: Sumi (墨) is the ink used in Zen calligraphy and ink-wash painting — made one stroke at a time, unrepeatable, contemplative. SumiDay = **one stroke a day**. Each daily practice leaves a mark on who you are becoming.

**One-line pitch**: *Waking Up for the Eastern classics, with Eastern wisdom — an AI-native daily wisdom practice.*

---

## 2. Why this, why now (strategic thesis)

The AI era is creating a mass "meaning vacuum" — white-collar professionals whose identity was tied to codifiable cognitive work find that work eroding. They are turning to wisdom traditions, therapy, short video, and wellness. The supply side of "meaning" is fragmented, low-trust, and under-served by premium digital products. Calm / Headspace / Waking Up dominate meditation; none offers rigorous, AI-personalized engagement with classical texts. 2024-2025 LLM quality finally makes personalized Socratic dialogue with classics deliverable at scale.

We are **selling shovels** to this gold rush — a structured daily practice product, not a content marketplace, not a service. Chairman is a mainland-China-licensed lawyer with AI engineering skills. That combination is a moat for: (a) global compliance positioning of a wisdom app (away from therapy/medical claims), (b) AI-native product velocity.

---

## 3. Non-negotiable constraints

1. **Global market first**. English primary, Spanish parallel launch, Chinese later.
2. **iOS native Swift only**. No React Native, no cross-platform hacks. UI must feel premium and ceremonial.
3. **Chairman does decisions + coding; Claude does everything else**. Marketing, content, copy, research, spec documentation, legal templates — all AI-executed. Only decisions and Swift coding consume chairman's time.
4. **Operations must be auto-runnable**. Use only platforms with official APIs for auto-posting (X, Instagram, TikTok, YouTube, Threads). Chinese social platforms are **excluded** from automation — if we do Chinese marketing later, it's manual or delegated.
5. **Apple in-app subscription is the sole payment rail at MVP**. Zero Stripe, zero payment integration work.
6. **No outsourcing**. Chairman writes Swift in Antigravity / Claude Code pointed at this workspace.
7. **Short-term cashflow orientation**. Target: first paying subscribers within 6 months of project start. Break-even at ~500-800 paid users.

---

## 4. Target user

**Primary persona — "The Reflective Professional"**
- 28-50 years old, English-speaking (US / UK / Canada / AU / EU expat / India tier-1)
- White-collar or creative professional, income $60k+ USD
- Already reads Ryan Holiday / Tim Ferriss / Sam Harris / The Daily Stoic
- Follows stoicism / zen / philosophy accounts on X and Instagram
- Owns an iPhone, has paid for at least one wellness or productivity subscription
- Core tension: intellectually curious about wisdom traditions but lacks a structured daily practice; finds meditation apps too thin and academic books too heavy

**Secondary persona — "El Buscador Hispanohablante"**
- Spanish-speaking Latin America (Mexico, Argentina, Colombia, Chile, Spain)
- Stoicism is already mainstream in Latin Spanish content ecosystems (huge Séneca / Marco Aurelio audience)
- Severely under-served by premium wisdom apps
- Willing to pay $5-8/month; price-sensitivity means regional pricing

**Non-targets**: Gen-Z wellness/aesthetic seekers (TikTok-native, won't pay subscription), hardcore Buddhists (want temple not app), academic philosophers (want books not app).

---

## 5. Product scope — MVP v1

**In scope**:
- Daily ~10-minute practice session: passage → AI audio intro → Socratic prompt → user reflection (text or voice) → logged.
- 4 curated 30-day paths: **Zen (launch), Tao (v1.1), Analects (v1.2), Stoic (v1.3 — "East meets West" positioning)**. Each path is a standalone marketing event.
- MVP ships with Zen path only: 7-day intro "Beginner's Mind" + 30-day "The Gateless Gate." Source texts: Platform Sutra, Blue Cliff Record, Gateless Gate.
- AI dialogue with a **Zen master persona** — spare, direct, paradoxical, never preachy. Constrained strictly to Zen source texts.
- Reflection journal, streak, light stats.
- Apple subscription: $9.99/mo or $79/yr (global tiered pricing via Apple).
- EN + ES localization at launch.

**Out of scope (v1)**:
- User-to-user social features / community.
- Teacher marketplace (this is v2 once paid MAU > 10k).
- Android, Web, iPad (iPhone only).
- Meditation audio library (we are NOT a meditation app; stay focused).
- Free tier beyond a 7-day trial — we are premium.

---

## 6. Content architecture

- **Source texts**: all public domain (Analects, Mencius, Tao Te Ching, Zhuangzi, Platform Sutra, Dhammapada, Meditations, Letters from a Stoic, Enchiridion). Zero licensing cost.
- **Translation layer**: For Zen texts — original Classical Chinese is public domain; English translations vary by copyright. Strategy: use pre-1928 translations where available; otherwise AI-assisted fresh translation from Classical Chinese, QA'd by chairman. This is a moat (proprietary translations), not a liability.
- **Curation**: 30 passages per path × 4 paths = 120 curated units at MVP.
- **Production pipeline**: Claude generates draft commentary + prompts; chairman final-QAs 30 minutes per path (~2 hours total for MVP content).
- **ES localization**: AI translation of EN content + native speaker review (hire per-task via Upwork if needed; small spend).

---

## 7. Tech stack

| Layer | Choice |
|---|---|
| Client | iOS native, Swift, SwiftUI |
| Min iOS version | iOS 17 |
| Backend | **Supabase** (Postgres + Auth + Storage, Swift SDK official). Aliyun HK box reserved for CDN origin, static landing, and future AI API gateway proxy. |
| AI | Claude API (primary), OpenAI fallback |
| Audio TTS | ElevenLabs (premium voice quality) |
| Analytics | TelemetryDeck (privacy-first, Apple-friendly) |
| Subscription | StoreKit 2 + RevenueCat (for receipt/entitlement management) |
| Content CMS | This workspace folder + markdown files, versioned in git |

---

## 8. Go-to-market (auto-run stack)

| Channel | Purpose | Automation |
|---|---|---|
| X (Twitter) | Daily wisdom quote + threaded reflections | Buffer / Typefully API, daily auto-post |
| Instagram | Aesthetic quote cards + 30-second reels | Meta Graph API via Make.com |
| TikTok | 30-60s "stoic vs zen" / "ask Zhuangzi" reels | TikTok for Developers API |
| YouTube Shorts | Same reels cross-posted | YouTube Data API |
| Threads | Mirror of X | Meta API |
| Landing page | Email capture pre-launch | Framer or Carrd + ConvertKit |
| Blog / SEO | Long-form "What Marcus Aurelius said about X" articles | Claude-generated, auto-published to Ghost/Webflow |
| Paid (later) | Apple Search Ads for App Store | Manual, post-launch |

Spanish parallel: separate handles (@sages_es etc.) with translated content from same source queue.

---

## 9. Chairman ↔ GM working agreement

- **This conversation** = strategic hub. Product decisions, brand decisions, GTM strategy, escalations.
- **Separate windows** (when GM instructs) = execution jobs that need a fresh context (e.g., drafting a full content calendar, writing marketing copy batch, producing competitive research, generating content library).
- **All files** live in `/sessions/focused-sweet-brahmagupta/mnt/4-TDW/`. When Swift coding begins, open Antigravity pointed at a subfolder like `/ios-app/`.
- **Chairman's weekly time budget**: 3-5 hours of decisions + review; Swift coding scales to whatever he wants.
- **GM will never**: outsource, spend money without approval, deploy anything to production, or make brand decisions unilaterally.
- **GM will always**: do research, draft, spec, QA, and present options with a clear recommendation.

---

## 10. Workspace folder structure

```
/mnt/4-TDW/
├── CLAUDE.md                    ← this file
├── DECISIONS.md                 ← log of every material decision + date
├── product/
│   ├── prd-v1.md                ← MVP product requirements
│   ├── user-flows.md            ← key flows (onboarding, daily practice, dialogue)
│   └── data-model.md            ← entities + schema
├── brand/
│   ├── name-candidates.md
│   ├── tonality-options.md      ← 3 directions for chairman to pick
│   ├── visual-system.md         ← colors, type, motion principles
│   └── voice-and-copy.md        ← brand voice doc
├── marketing/
│   ├── competitive-brief.md     ← Waking Up / Stoic / Calm / Insight Timer
│   ├── gtm-plan.md              ← 90-day GTM
│   ├── content-calendar/        ← weekly posts per channel
│   └── landing-page-copy.md
├── content-library/
│   ├── stoic/
│   ├── zen/
│   ├── tao/
│   ├── analects/
│   └── _localization/           ← EN/ES/ZH versions
├── legal/
│   ├── terms-of-service.md
│   ├── privacy-policy.md
│   ├── not-medical-advice.md
│   └── app-store-compliance.md
├── research/
│   ├── user-personas.md
│   ├── market-sizing.md
│   └── keyword-research.md
└── ios-app/                     ← chairman's Swift code (Antigravity window)
```

---

## 11. Phased roadmap

**Phase 0 — Foundation (weeks 1-2)**
Competitive brief, brand tonality options, MVP PRD, brand name + domain, legal foundation. Chairman picks brand direction at end of week 2.

**Phase 1 — Content + Design (weeks 3-5)**
Content library v1 (120 passages × EN), visual system, landing page live, email list capture starts, pre-launch content on X begins. Chairman starts Swift project scaffold.

**Phase 2 — MVP Build (weeks 6-10)**
Chairman builds iOS MVP in Antigravity. GM produces all non-code assets: ES localization, additional content, App Store listing copy, screenshots, trailer, ASO keyword research, onboarding flow copy.

**Phase 3 — Soft Launch (weeks 11-12)**
TestFlight with 50-100 early users from email list. Bug bash, pricing test, conversion funnel calibration.

**Phase 4 — Public Launch (week 13+)**
App Store release, Product Hunt launch, Apple Editorial pitch, content auto-posting stack goes fully live.

**Milestone targets**:
- Day 90: Public launch
- Day 180: 500 paid subs (~$3k MRR)
- Day 365: 3,000 paid subs (~$18k MRR)

---

## 12. Open decisions (awaiting chairman)

1. **Tagline final wording**: Working candidates: "One stroke a day." / "Leave a mark. Every day." Chairman to confirm after seeing visual-system.md with both options rendered.
2. **Chinese name**: deferred to v3 ZH launch. Candidates: 墨日 / 一墨 / 今日墨 / 日课.

### Resolved
- ~~Legal entity~~: HK company (existing), Apple Developer account already under it.
- ~~Backend~~: Supabase.
- ~~Brand name~~: **SumiDay**. Domain sumi.day purchased. Bundle com.sumiday.sumi registered.
- ~~Brand tonality~~: **Option C — Shodo（东方禅意派）**. 2026-04-16. Colors: Sumi Ink `#1A1614` / Washi `#F2EDE4` / Matcha `#6B8F71` / Persimmon `#C65D2A`. Voice: Ceremonial · Contemplative · Grounded · Generous · Unhurried. Execution standard: MUJI/Aesop/Kinfolk 精度，拒绝廉价东方装饰风。详见 brand/tonality-options.md。

---

## 13. Glossary

- **修身 (xiushen)** — "self-cultivation," the Confucian-Taoist concept of ongoing personal refinement. Core product metaphor.
- **Sage persona** — AI-prompted character (e.g., Zhuangzi, Marcus Aurelius) that dialogues with the user in-tradition.
- **Path** — a curated 30-day sequence within one tradition.
- **Practice session** — the daily ~10-minute interactive unit. This is the product's atomic behavior.

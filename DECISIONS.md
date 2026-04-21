# Decisions Log

Every material decision gets one line here with date + context. This is the audit trail for "why did we do X."

## 2026-04-16 — Zen-first pivot (PRD v1.2)

- **MVP first path: Zen, not Stoic.** Rationale: SumiDay is "East-Asian-canon-first" — starting with Stoicism inverted the brand USP and made us indistinguishable from The Stoic App / Daily Stoic. Zen is the correct launch tradition: "zen" is already an English word (low cognitive barrier), koan tradition matches Socratic dialogue mechanic perfectly, and Sumi ink is a Zen calligraphy symbol — brand narrative is coherent end-to-end.
- **Path launch order**: Zen (MVP) → Tao (v1.1) → Analects (v1.2) → Stoic (v1.3, repositioned as "East meets West" — Marcus Aurelius and Zhuangzi arriving at the same truth).
- **Each tradition is a pure, unmixed path.** No cross-tradition blending within a single path. Clarity = professionalism = trust.
- **Zen content**: 7-day intro "Beginner's Mind" + 30-day "The Gateless Gate." Sources: Platform Sutra (六祖坛经), Blue Cliff Record (碧岩录), Gateless Gate (无门关). Translation strategy: pre-1928 EN translations or fresh AI-assisted translations from Classical Chinese, QA'd by chairman.
- **Zen master persona**: Unnamed, timeless, direct, spare, occasionally paradoxical. Constrained strictly to Zen source texts.

## 2026-04-16 — PRD v1.1 revisions (chairman feedback)

- **Multi-LLM backend**: AI gateway must support multiple LLM providers (Claude, OpenAI, Gemini, DeepSeek, etc.) with admin-switchable config in Supabase `ai_config` table. iOS client calls one unified endpoint, never LLM APIs directly. Chairman can switch models from management dashboard without app update.
- **SSE streaming**: AI dialogue delivered via Server-Sent Events to prevent HTTP timeout failures on long-running LLM calls. Non-streaming fallback endpoint for degraded connectivity.
- **Offline reading mode (P1)**: Text content + cached audio available offline. AI dialogue unavailable offline with graceful message. Local cache syncs journal entries when online.
- **Replay shows old reflections**: During path replay, user sees prior reflection(s) alongside new Socratic prompt. Multiple replay layers shown chronologically. Tangible progress indicator.
- **Intro price confirmed**: $0.99 USD (Apple minimum). Q2 closed.

---

## 2026-04-16 — Project kicked off

- **Direction**: Premium iOS app for classical wisdom practice, global market, EN+ES at launch, ZH later.
- **Business model**: Apple subscription ($9.99/mo, $79/yr target).
- **Team**: Chairman writes Swift himself (no outsourcing). Claude is GM for all non-code work.
- **Brand tonality**: Deferred — to be decided after competitive brief + tonality options memo.
- **Brand name**: "Sages" is working title only; final name pending trademark + domain check.

## 2026-04-16 — Three foundational decisions locked

- **Legal entity**: Existing Hong Kong company is the operating entity. Apple Developer account already registered under this HK entity.
- **Backend stack**: **Supabase** (Postgres + Auth + Storage + Swift SDK). Aliyun HK server reserved for: content CDN origin, static landing page, future AI API gateway proxy. Not used as primary backend.
- **Brand name criteria (from chairman)**: short, memorable, easy to spread; thematic tie is bonus, not required. Must work in EN and ES. 6 candidates presented: Stoa / Opus / Koan / Mitra / Ember / Lumen. Awaiting chairman pick.
- **Competitive brief**: chairman has opened a separate window to run marketing:competitive-brief; output lands at /marketing/competitive-brief.md

## 2026-04-16 — Brand name locked: SumiDay

- **Final brand name**: **SumiDay**
- **Domain**: sumi.day (purchased by chairman)
- **iOS Bundle ID**: com.sumiday.sumi (registered)
- **Name etymology**: Sumi (墨, Japanese sumi ink used in Zen calligraphy) + Day (daily practice). "每日一墨" — one stroke a day, one reflection a day. Ceremonial × daily practice double entendre.
- **Conflict check results**:
  - ❌ Dead: Stoa (direct competitor, same price), Koan (AI reflection journal, too close), Ember (6+ wellness apps), Pneuma (existing AI+AR meditation app)
  - ⚠️ Muddy: Opus, Mitra, Lumen (neighbors in space, ASO interference)
  - ✅ Clear shortlist: Arete, Sumi, Kairos, Canto
  - Chairman picked Sumi but found iOS conflict, resolved by appending "Day" to create unique brand word.
- **Chinese name**: deferred to v3 ZH launch. Candidates to revisit later: 墨日、一墨、今日墨、日课 (日課).
- **Working title "Sages"**: retired. Project is now called SumiDay across all docs going forward.

## 2026-04-16 — Five MVP product decisions locked (pre-PRD)

1. **MVP scope: Stoic path only**. Launch with 1 tradition (Stoicism), 30-day path + 7-day paid intro. Zen/Tao/Analects come as v1.1/v1.2 updates — each update = marketing event.
2. **Retention: path replay + leveling system**. "温故而知新" — same path, deeper AI questions on replay. Multi-tier practitioner levels (修行等级). AI-generated daily content allowed BUT must cite source texts, zero hallucination. Community features deferred.
3. **No free tier. Paid entry from $0.1 USD**. 7-day intro path is a standalone paid mini-journey, not a truncated trial. Premium positioning: even the door costs money.
4. **Monetization: subscription + path buyout**. Apple subscription ($9.99/mo or $79/yr) is primary. Individual path buyout (one-time purchase) is secondary option for subscription-averse users. Both via StoreKit 2.
5. **JTBD reframed: morning ritual**. Product designed around "the first 10 minutes of your day." UX, notifications, content scheduling all optimized for morning usage.
6. **i18n architecture from day 1**. English first, but all UI strings via Swift String Catalogs / NSLocalizedString. Zero hardcoded copy. Spanish v1.1 (6 weeks post-launch).

## 2026-04-16 — Brand tonality locked: Option C Shodo（东方禅意派）

- **Decision**: Brand tonality direction is **Option C — Shodo**（东方禅意派）
- **Color palette**:
  - Primary: Sumi Ink `#1A1614`
  - Background: Washi `#F2EDE4` / Mulberry Paper `#EAE0D5`
  - Accent A: Matcha `#6B8F71` (主 CTA)
  - Accent B: Persimmon `#C65D2A` (引文高亮)
  - Stone `#A09A90` / Pale Moon `#D6CFC4`
- **Typography direction**: Humanist serif for display (New York or Cormorant-class); SF Pro Text for UI; PingFang SC for Chinese; NO decorative brush/calligraphy fonts in UI
- **Voice tone**: Ceremonial · Contemplative · Grounded · Generous · Unhurried
- **Hero tagline direction**: "One stroke a day." (tagline final wording deferred — see open decisions)
- **Execution mandate**: Shodo 调性 + Forma 级别的设计精度。不做廉价东方装饰风，参考 MUJI / Aesop / Kinfolk 的克制标准
- **Rejected options**:
  - Option A (Intellectus): Too close to Waking Up's territory, low growth ceiling
  - Option B (Forma): Disconnected from SumiDay brand etymology, cultural advantage diluted
- **Next deliverables unlocked**: visual-system.md, voice-and-copy.md, landing-page-copy.md

---

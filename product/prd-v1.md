# SumiDay MVP — Product Requirements Document v1

**Author**: GM (Claude)
**Date**: 2026-04-16
**Status**: v1.1 — revised per chairman feedback (2026-04-16)
**References**: CLAUDE.md, DECISIONS.md, marketing/competitive-brief.md, brand/tonality-options.md

---

## 1. Problem Statement

White-collar professionals aged 28–50 are experiencing a growing "meaning vacuum" as AI erodes the cognitive work that once anchored their identity. They turn to wisdom traditions for grounding but find **meditation apps too shallow** (Calm, Headspace focus on relaxation, not depth), **philosophy books too heavy** (Marcus Aurelius untranslated is a slog), and **no product that combines structured daily practice with classical texts and personalized dialogue**.

Waking Up (Sam Harris) proved this audience will pay $120+/year for philosophy-meets-practice, but its content is 95% Western/secular and offers zero AI interaction. The Stoic app captured the keyword but delivers only template journaling — no textual depth, no dialogue, no ceremony.

**The gap**: No premium iOS app exists that offers rigorous, AI-native daily engagement with classical wisdom texts (starting with Stoicism) in a ritualized, beautiful experience designed for the first 10 minutes of your morning.

**Cost of not solving**: This audience will continue bouncing between podcast snippets, book excerpts, and shallow wellness apps — never building a sustained practice. The window for a new entrant is 12–18 months before incumbents (especially Waking Up) add AI dialogue layers.

---

## 2. Goals

| # | Goal | Metric | Target |
|---|------|--------|--------|
| G1 | **Paying users within 6 months of project start** | Paid subscriber count | 500 paid users by Day 180 |
| G2 | **Users complete 7-day intro path** | Intro path completion rate | ≥ 60% of purchasers |
| G3 | **Users convert from intro to subscription or path buyout** | Conversion rate (intro → paid) | ≥ 25% |
| G4 | **Users return every morning** | D7 retention (daily active) | ≥ 40% |
| G5 | **Users perceive intellectual depth, not gimmick** | App Store review sentiment | ≥ 4.7 stars, "deep" / "thoughtful" in top 10 review keywords |

---

## 3. Non-Goals (v1)

| # | Non-Goal | Rationale |
|---|----------|-----------|
| NG1 | **No free tier** | Premium positioning. Even the 7-day intro costs ≥ $0.99. Paid gate filters for serious users and validates willingness to pay from day one. |
| NG2 | **No Stoic / Tao / Analects paths at launch** | Zen leads. It has the strongest brand-to-product coherence (Sumi ink = Zen calligraphy), the highest Western market recognition among Eastern traditions ("zen" is an English word), and a koan tradition that naturally fits the Socratic dialogue mechanic. Stoicism ships as v1.1 — positioned as "East meets West" after the Eastern identity is firmly established. |
| NG3 | **No social features / community** | Community adds moderation burden, regulatory complexity, and dilutes the "solo practice" positioning. Revisit at 10k MAU. |
| NG4 | **No Android / Web / iPad** | iPhone only. Concentrate engineering on one flawless platform. iPad and Android are v2. |
| NG5 | **No Spanish localization** | English first to validate PMF. Spanish ships ~6 weeks post-launch. BUT: all UI strings use Swift String Catalogs from day one — zero hardcoded copy. |
| NG6 | **No teacher marketplace** | v2 feature once paid MAU > 10k. Architecture should not preclude it but we do not build it. |
| NG7 | **No meditation audio library** | We are NOT a meditation app. We are a wisdom practice app. No ambient sounds, no sleep stories, no breathing exercises. |

---

## 4. User Stories

### Persona: The Reflective Professional ("Alex")
28–50, English-speaking, iPhone, reads Ryan Holiday / Tim Ferriss, has paid for ≥ 1 wellness subscription, intellectually curious but lacks a structured daily wisdom practice.

**Onboarding & Purchase**

- As Alex, I want to understand what SumiDay offers within 30 seconds of opening the app, so I can decide if it's worth my money.
- As Alex, I want to purchase the 7-day intro path with a single tap (Apple Pay / StoreKit), so there's zero friction between interest and commitment.
- As Alex, I want to see what other paths are "coming soon" (Tao, Analects, Stoic), so I know the product has depth beyond what's available today.

**Daily Practice (Core Loop)**

- As Alex, I want to receive a gentle morning notification at my chosen time, so SumiDay becomes part of my morning ritual.
- As Alex, I want to read a curated passage from a Zen classic (Platform Sutra, Blue Cliff Record, Gateless Gate) with a clean modern translation, so I can engage with the source text directly.
- As Alex, I want to hear a 60–90 second AI-generated audio introduction contextualizing the passage, so I understand why this text matters before I reflect.
- As Alex, I want the AI to ask me 1–2 Socratic questions about the passage, so I'm prompted to think — not just consume.
- As Alex, I want to respond via text or voice, so I can choose whichever feels right in the moment.
- As Alex, I want my reflection saved to a personal journal, so I can look back on my growth over time.
- As Alex, I want the entire session to take ~10 minutes, so it fits before my morning commute.

**AI Dialogue**

- As Alex, I want to ask follow-up questions about the passage and get an in-character response from a "Zen master" persona, so the experience feels like a dialogue, not a lecture.
- As Alex, I want every AI response to cite the specific source text it's drawing from, so I trust the depth is real and not fabricated.
- As Alex, I want the AI to say "I don't know" or "that's outside this tradition" rather than hallucinate, so I can trust it completely.

**Progress & Retention**

- As Alex, I want to see my streak (consecutive days of practice), so I'm motivated to maintain the habit.
- As Alex, I want to earn practitioner levels (修行等级) as I replay and deepen my engagement, so there's a sense of long-term progression.
- As Alex, I want to replay a completed path and receive deeper, more challenging questions based on my previous reflections, so "温故而知新" is a real experience, not just a reset.
- As Alex, I want to see a summary of my reflections at the end of a 30-day path, so I can appreciate how my thinking has evolved.

**Monetization**

- As Alex, I want to buy the 7-day intro for a low price ($0.99) to try SumiDay, so I'm not committing to a subscription before I know if I like it.
- As Alex, I want the option to subscribe ($9.99/mo or $79/yr) for ongoing access to all paths + daily AI content, so I can commit if the intro convinces me.
- As Alex, I want the option to buy out a single 30-day path as a one-time purchase, so I can pay once if I hate subscriptions.

**Settings & Preferences**

- As Alex, I want to set my preferred practice time (morning default), so notifications arrive at the right moment.
- As Alex, I want to choose my preferred language (English at MVP; Spanish and others visible but "coming soon"), so I know localization is planned.

---

## 5. Requirements

### P0 — Must-Have (MVP cannot ship without these)

**P0-1: 7-Day Intro Path (Paid)**
- 7 self-contained daily sessions introducing Zen practice through SumiDay's format.
- Theme: **"Beginner's Mind" (初心)** — drawn from Shunryu Suzuki's foundational concept. Each day approaches one core Zen theme through a classic passage: the nature of mind, non-attachment, impermanence, koan practice, silence, presence, and what it means to "wake up."
- Each session: passage → audio intro → Socratic prompt (or koan) → user reflection → journal entry.
- Purchased via StoreKit 2. Minimum price: $0.99 USD (or regional equivalent).
- Acceptance criteria:
  - [ ] User can purchase intro path from onboarding screen via Apple Pay / StoreKit.
  - [ ] 7 sessions are unlocked sequentially (one per day, or user can advance freely).
  - [ ] Each session takes 8–12 minutes to complete.
  - [ ] Journal entries are persisted to Supabase.
  - [ ] User who completes Day 7 sees a summary + upsell to subscription or path buyout.

**P0-2: 30-Day Zen Path**
- 30 curated passages drawn from core Zen source texts: **Platform Sutra** (六祖坛经, Huineng), **Blue Cliff Record** (碧岩录), **Gateless Gate** (无门关 / Mumonkan), and **Zen Mind, Beginner's Mind** (where copyright permits; otherwise AI-rendered from primary Chinese sources).
- Each passage: original text (Chinese + English translation) + AI-generated modern reading + commentary.
- **Copyright note**: Platform Sutra and koan collections are ancient texts (public domain). English translations vary — use pre-1928 translations or commission fresh AI-assisted translations from the original Classical Chinese (chairman to QA). This is a moat, not a liability.
- Requires active subscription OR one-time path purchase to access.
- **Path structure — "The Gateless Gate" (无门之门)**:
  - Week 1 (Days 1–7): 见性 — Seeing Nature. What is the mind? What is Buddha?
  - Week 2 (Days 8–14): 无执 — Non-Attachment. Letting go of self, outcome, permanence.
  - Week 3 (Days 15–21): 当下 — Presence. This moment, this breath, this stroke.
  - Week 4 (Days 22–30): 日用 — Daily Life as Practice. Zen is not on the cushion — it's washing the bowl.
- Acceptance criteria:
  - [ ] 30 passages loaded from content library (markdown files in workspace).
  - [ ] Each passage has: source text (with attribution), modern reading, 60–90s audio intro (ElevenLabs TTS), 1 Socratic prompt + optionally 1 koan for contemplation.
  - [ ] Sessions unlock daily; user can replay previous sessions.
  - [ ] Path completion triggers a reflection summary + level-up notification.

**P0-3: AI Socratic Dialogue (Multi-LLM + SSE Streaming)**
- After each passage, AI asks 1–2 open-ended questions tailored to the text.
- User can respond via text (keyboard) or voice (Speech-to-text → transcribed → sent to AI).
- AI responds in-character as a **Zen master persona** — unnamed, timeless, speaking in the style of the classical Zen tradition: direct, spare, occasionally paradoxical. Never preachy. More likely to answer a question with a question (or a koan) than with an explanation.
- **Multi-LLM backend**: The server-side AI gateway (Aliyun HK or Supabase Edge Function) must support multiple LLM providers (Claude, OpenAI, Gemini, DeepSeek, etc.). Active provider is selected via an admin configuration table in Supabase — chairman can switch models from a management dashboard without app update. The iOS client sends requests to a single unified endpoint; it never calls LLM APIs directly.
- **SSE (Server-Sent Events) streaming**: AI responses are delivered to the iOS client via SSE to avoid HTTP timeout failures on long-running LLM calls. The AI gateway opens an SSE stream; the client renders tokens incrementally. Fallback: if SSE connection drops, client retries with exponential backoff and can request the full response via a non-streaming endpoint.
- **Guardrail: every AI response must cite the source passage. If the user asks about something outside the Zen tradition, the master responds in character: "That belongs to another river. Stay with this one." — never fabricates, never blends traditions.**
- Acceptance criteria:
  - [ ] AI gateway supports ≥ 2 LLM providers (Claude + OpenAI minimum at launch).
  - [ ] Active LLM provider is configurable via Supabase `ai_config` table (no app redeploy needed).
  - [ ] AI dialogue delivered via SSE; client renders streaming tokens in real-time.
  - [ ] SSE connection includes timeout handling, retry logic, and non-streaming fallback.
  - [ ] System prompt constrains AI to Zen source texts and Zen master persona regardless of which LLM is active.
  - [ ] Each AI response includes a citation (e.g., "Platform Sutra, Chapter 2" or "Blue Cliff Record, Case 1").
  - [ ] Conversation is limited to 5 exchanges per session (prevents runaway API cost).
  - [ ] Voice input is transcribed via Apple Speech framework and sent as text to AI gateway.
  - [ ] AI never claims to be a real person or therapist. Disclaimer visible in settings.

**P0-4: Reflection Journal**
- All user reflections and AI responses are saved chronologically.
- User can browse journal by date or by passage.
- Acceptance criteria:
  - [ ] Journal entries stored in Supabase with user_id, path_id, day_number, timestamp, user_text, ai_response.
  - [ ] Journal screen shows entries grouped by path → day.
  - [ ] User can search journal entries by keyword.

**P0-5: Streak & Practitioner Levels**
- Streak: consecutive days with a completed session. Visual counter on home screen.
- Practitioner levels: based on total sessions completed + paths replayed. Suggested tiers:
  - 初学 (Initiate): 0–7 sessions
  - 学徒 (Apprentice): 8–30 sessions
  - 行者 (Practitioner): 31–90 sessions
  - 修士 (Adept): 91–180 sessions
  - 贤者 (Sage): 181+ sessions
- Level names display in English at MVP (e.g., "Initiate", "Apprentice", "Practitioner", "Adept", "Sage") with i18n keys for future localization.
- Acceptance criteria:
  - [ ] Streak increments on session completion; resets if a day is missed.
  - [ ] Level badge visible on home screen and journal.
  - [ ] Level-up triggers a celebratory micro-animation (Shodo-style ink splash, not confetti).

**P0-6: Subscription + Path Buyout via StoreKit 2**
- Subscription: $9.99/mo or $79/yr (auto-renewable, managed by StoreKit 2 + RevenueCat).
- Path buyout: one-time purchase per path (suggested $29.99 for 30-day Stoic path).
- 7-day intro: one-time purchase ($0.99).
- Acceptance criteria:
  - [ ] Three product types configured in App Store Connect: consumable (intro), non-consumable (path buyout), auto-renewable (subscription).
  - [ ] RevenueCat SDK integrated for entitlement management + receipt validation.
  - [ ] User can see current entitlement status in settings (active sub, purchased paths).
  - [ ] Subscription includes access to ALL current and future paths.
  - [ ] Path buyout grants permanent access to that single path only.

**P0-7: Morning Notification**
- User sets preferred practice time during onboarding (default: 7:00 AM local).
- Daily local notification: short, contemplative copy (rotated from a pool of 30+ messages).
- Acceptance criteria:
  - [ ] UNUserNotificationCenter configured with daily repeating trigger.
  - [ ] Notification copy pulled from a localized string catalog (not hardcoded).
  - [ ] Tapping notification opens directly into today's session.

**P0-8: Onboarding Flow**
- Screen 1: Brand moment — SumiDay logo + tagline + ink-wash animation (3 seconds max).
- Screen 2: "Choose your path" — Zen path highlighted as available; Tao/Analects/Stoic shown as "coming soon" with subtle lock icons.
  - "Help me choose" button → AI asks 2–3 questions → recommends Zen (the only option at MVP, but the mechanism is built for multi-path future).
- Screen 3: Set practice time (morning default, scrollable time picker).
- Screen 4: Purchase 7-day intro ($0.99) — StoreKit sheet.
- Acceptance criteria:
  - [ ] Onboarding completes in < 90 seconds.
  - [ ] User cannot access any content without purchasing intro.
  - [ ] "Help me choose" AI dialogue works and gracefully recommends Stoic.
  - [ ] Practice time preference saved to UserDefaults + synced to Supabase user profile.

**P0-9: i18n Architecture**
- All user-facing strings in Swift String Catalogs (.xcstrings).
- Zero hardcoded English strings in SwiftUI views.
- Content library (passages, commentary) stored as separate locale-keyed markdown files.
- Acceptance criteria:
  - [ ] `Localizable.xcstrings` contains every UI string with `en` as base language.
  - [ ] A test target verifies no raw string literals exist in SwiftUI `Text()` calls.
  - [ ] Content files follow naming convention: `stoic/day-01.en.md`, `stoic/day-01.es.md` (ES files empty at MVP but structure exists).

**P0-10: Audio Intro Generation**
- Each session has a 60–90 second pre-recorded audio introduction.
- Generated via ElevenLabs TTS API from scripted text.
- Stored as .m4a files in Supabase Storage (or Aliyun CDN), streamed on demand.
- Acceptance criteria:
  - [ ] Audio files generated for all 37 sessions (7 intro "Beginner's Mind" + 30 "The Gateless Gate" path).
  - [ ] Audio player UI: play/pause, seek bar, playback speed (1x / 0.75x).
  - [ ] Audio auto-advances to Socratic prompt screen on completion.
  - [ ] Offline: audio files cached after first play.

**P0-11: Settings & Profile Management**
- A dedicated Settings view accessible from the Home/Journal tabs (e.g., via a gear icon).
- Manages user preferences, subscription status, and app-wide configurations.
- Acceptance criteria:
  - [ ] Shows current subscription / entitlement status (active paths, via RevenueCat).
  - [ ] Functionality to "Restore Purchases" via StoreKit 2.
  - [ ] App preference to update daily notification time (updates local notifications and user profile).
  - [ ] Display active UI language (with placeholders for "Spanish (Coming Soon)").
  - [ ] Links to Legal documents: Privacy Policy, Terms of Service.
  - [ ] Embedded "Not Medical Advice" disclaimer visibly placed at the bottom.
  - [ ] Contact Support link (e.g., mailto link to support email).

### P1 — Nice-to-Have (ship soon after launch)

**P1-1: Path Replay with Deeper Questions + Old Reflections Visible**
- When user replays a completed path, AI references their previous journal entries to ask deeper follow-up questions.
- "温故而知新" mechanic: same passage, new layer of meaning.
- **Old reflections visible**: During replay, the UI shows the user's previous reflection(s) for that day's session alongside the new Socratic prompt. This lets the user see how their thinking has evolved — a tangible sense of progress. Multiple replay layers are shown chronologically (replay 1, replay 2, etc.).
- AI prompt includes: original passage + user's prior reflection(s) + instruction to go deeper.
- Acceptance criteria:
  - [ ] Replay session screen displays previous reflection(s) in a collapsed/expandable section above the new prompt.
  - [ ] Each old reflection is labeled with its date and replay number.
  - [ ] AI system prompt receives the user's most recent prior reflection to generate deeper questions.
  - [ ] If user has replayed multiple times, all prior reflections are browsable but only the most recent is sent to AI (to control token cost).

**P1-2: Reflection Summary at Path Completion**
- AI-generated 1-page summary of user's 30-day journey: themes, growth areas, notable reflections.
- Shareable as image (for social posting) or PDF.

**P1-3: Apple Watch Complication**
- Shows current streak count + "practice now" shortcut.
- Notification mirroring.

**P1-4: Widget (iOS Home Screen)**
- Daily quote widget (small/medium) showing today's passage headline.
- Tapping opens directly into today's session.

**P1-5: Spanish Localization**
- Full UI translation + Stoic path content in Spanish.
- Separate ASO listing for Spanish-speaking markets.
- Target: 6 weeks post-English launch.

**P1-6: Offline Reading Mode**
- Users can read and review text content (passages, modern readings, commentary) and browse their journal without an internet connection.
- AI dialogue is unavailable offline — the AI chat UI shows a gentle message: "Dialogue with the sage requires a connection. For now, sit with the text."
- Audio intros are cached after first play (already in P0-10); cached audio plays offline.
- Acceptance criteria:
  - [ ] All text content for unlocked/purchased paths is cached locally (Core Data or file cache) after first sync.
  - [ ] Journal entries are stored locally and synced to Supabase when connectivity resumes.
  - [ ] Session screen renders passage + modern reading + cached audio in airplane mode.
  - [ ] AI dialogue section shows a graceful "offline" state instead of an error.
  - [ ] App detects connectivity via NWPathMonitor and toggles AI availability accordingly.

### P2 — Future Considerations (design for, don't build)

**P2-1: Zen / Tao / Analects Paths**
- Data model must support multiple traditions from day one (path has a `tradition` field).
- Each tradition will have its own sage persona, source texts, and visual accent color.

**P2-2: Teacher Marketplace**
- Architecture should support `teacher` as a user role (future Supabase RLS policy).
- Content model should distinguish "curated by SumiDay" vs "contributed by teacher."

**P2-3: Community Reflections**
- Journal entries could optionally be shared (anonymized) for other users to read.
- Data model: `reflection.is_public` boolean field (default false, not exposed in UI at MVP).

**P2-4: Android / iPad / Web**
- No cross-platform code. But API design should be client-agnostic (REST/GraphQL via Supabase, not tightly coupled to Swift).

**P2-5: Advanced Analytics Dashboard**
- User-facing: practice heatmap, reading speed, reflection word count over time.
- Internal: cohort analysis, conversion funnels, retention curves.

---

## 6. Data Model (Core Entities)

```
User
├── id (uuid, Supabase Auth)
├── email
├── display_name
├── preferred_locale (en, es, zh)
├── practice_time (time, default 07:00)
├── current_level (enum: initiate/apprentice/practitioner/adept/sage)
├── total_sessions_completed (int)
├── current_streak (int)
├── longest_streak (int)
├── created_at
└── updated_at

Path
├── id (uuid)
├── tradition (enum: stoic/zen/tao/analects)
├── title (localized)
├── description (localized)
├── duration_days (int, 7 or 30)
├── is_intro (bool)
├── price_tier (StoreKit product ID)
├── sort_order (int)
└── status (enum: active/coming_soon)

Session (= one day's content within a path)
├── id (uuid)
├── path_id (fk → Path)
├── day_number (int, 1-30)
├── passage_source (text, e.g., "Meditations, Book IV, §3")
├── passage_original (text, public domain translation)
├── passage_modern (text, AI-generated modern reading)
├── audio_url (text, ElevenLabs .m4a)
├── socratic_prompts (json array of 2 prompt strings)
└── sort_order (int)

UserPathProgress
├── id (uuid)
├── user_id (fk → User)
├── path_id (fk → Path)
├── current_day (int)
├── started_at (timestamp)
├── completed_at (timestamp, nullable)
├── replay_count (int, default 0)
└── status (enum: active/completed/paused)

JournalEntry
├── id (uuid)
├── user_id (fk → User)
├── session_id (fk → Session)
├── user_path_progress_id (fk → UserPathProgress)
├── user_reflection (text)
├── ai_response (text)
├── ai_citations (json array)
├── is_public (bool, default false — P2 prep)
├── replay_number (int, which replay iteration, 0 = first time)
├── created_at
└── updated_at

Entitlement (managed by RevenueCat, mirrored for query)
├── user_id (fk → User)
├── product_id (text, StoreKit product ID)
├── type (enum: subscription/path_buyout/intro)
├── is_active (bool)
├── expires_at (timestamp, nullable for buyout)
└── purchased_at
```

---

## 7. Success Metrics

### Leading Indicators (Days 1–30 post-launch)

| Metric | Target | Measurement |
|--------|--------|-------------|
| Intro path purchases | 500 in first 30 days | RevenueCat + App Store Connect |
| Intro completion rate (7/7 days) | ≥ 60% | Supabase: UserPathProgress.completed_at not null / total started |
| Intro → subscription/buyout conversion | ≥ 25% | RevenueCat: subscription or buyout purchase within 7 days of intro completion |
| D1 retention (return next day) | ≥ 70% | TelemetryDeck |
| D7 retention | ≥ 40% | TelemetryDeck |
| Average session duration | 8–12 minutes | TelemetryDeck |
| AI dialogue engagement (% who ask follow-up) | ≥ 30% | Supabase: JournalEntry count > 1 exchange per session |

### Lagging Indicators (Day 30–180)

| Metric | Target | Measurement |
|--------|--------|-------------|
| Monthly paid subscribers | 500 by Day 180 | RevenueCat |
| MRR | $3,000 by Day 180 | RevenueCat |
| App Store rating | ≥ 4.7 stars | App Store Connect |
| Path replay rate (users who start path again) | ≥ 15% | Supabase: UserPathProgress.replay_count > 0 |
| 30-day path completion rate | ≥ 40% | Supabase |
| Organic installs from ASO | ≥ 50% of total installs | App Store Connect attribution |

---

## 8. Open Questions

| # | Question | Owner | Status |
|---|----------|-------|--------|
| Q1 | **Path buyout price**: $29.99 for 30-day Stoic path — too high? too low? Need to A/B test. | Chairman | Open — launch with $29.99, test later |
| ~~Q2~~ | ~~**Intro price floor**~~: **Resolved** — $0.99 confirmed. Apple minimum applies. | Chairman | ✅ Closed |
| Q3 | **ElevenLabs voice selection**: which voice model for the Zen master audio? Voice character: measured, unhurried, slight resonance — not dramatic, not ASMR. Need to audition 3–5 voices. | GM | Open — can swap voice post-launch |
| ~~Q4~~ | ~~**AI cost modeling**~~: **Resolved** — reframed as multi-LLM architecture. Backend supports multiple providers (Claude, OpenAI, Gemini, DeepSeek) with admin-switchable config in Supabase `ai_config`. Cost optimized by switching models as needed. | Chairman | ✅ Closed |
| Q5 | **"Not medical advice" disclaimer**: exact wording and placement. Required for App Store review. Legal foundation doc will address. | GM (legal) | Open — blocking, must be in app before submission |
| Q8 | **Zen text translation copyright**: Platform Sutra and koan collections are ancient (public domain). However most well-known English translations (D.T. Suzuki, Thomas Cleary, etc.) are under copyright. Strategy: (a) use pre-1928 translations where they exist, (b) generate fresh translations from original Classical Chinese with chairman QA. GM to produce a per-text copyright clearance matrix before content library is written. | GM | Open — blocking for content library |
| ~~Q6~~ | ~~**Offline mode**~~: **Resolved** — Yes, offline reading mode is P1. Text content + cached audio available offline. AI dialogue unavailable offline (graceful message shown). | Chairman | ✅ Closed |
| ~~Q7~~ | ~~**Replay mechanic**~~: **Resolved** — Old reflections visible during replay. User sees prior reflection(s) alongside new Socratic prompt. Multiple replay layers shown chronologically. | Chairman | ✅ Closed |

---

## 9. Timeline Considerations

**Phase 0 (weeks 1–2) — Foundation** ✅ COMPLETE
- Competitive brief, brand name, brand tonality, PRD, legal foundation.

**Phase 1 (weeks 3–5) — Content + Design**
- Content library v1: 37 sessions (7 intro + 30 Stoic path) × EN.
- Visual system doc (brand/visual-system.md).
- Landing page live at sumi.day (email capture).
- Pre-launch content begins on X / Instagram.
- Chairman starts Swift project scaffold + Supabase setup.

**Phase 2 (weeks 6–10) — MVP Build**
- Chairman builds iOS app in Antigravity / Claude Code.
- GM produces: App Store listing copy, screenshots mockup descriptions, ASO keywords, onboarding copy, notification copy pool, legal docs.
- ElevenLabs audio generation for all 37 sessions.
- Integration testing: StoreKit 2 + RevenueCat + Supabase + Claude API + ElevenLabs.

**Phase 3 (weeks 11–12) — Soft Launch**
- TestFlight with 50–100 early users from email list.
- Bug bash, pricing validation, conversion funnel review.
- App Store metadata finalized.

**Phase 4 (week 13+) — Public Launch**
- App Store release.
- Product Hunt launch.
- Content auto-posting stack goes fully live (X / IG / TikTok / YT).
- Apple Editorial pitch.

**Hard dependencies**:
- Apple Developer account already active (✅ confirmed).
- ElevenLabs API access (GM to set up).
- Claude API key (GM to provision).
- sumi.day landing page (GM to build, week 3).

---

## 10. Technical Architecture Overview

```
┌─────────────────┐     ┌──────────────────┐
│   iOS App        │────▶│   Supabase       │
│   (Swift/SwiftUI)│     │   (Postgres +    │
│                  │     │    Auth + Storage │
│  - StoreKit 2    │     │    + ai_config   │
│  - RevenueCat    │     │    table)        │
│  - Speech FW     │     └──────────────────┘
│  - TelemetryDeck │              │
│  - Local cache   │              │ CDN origin
│    (offline mode)│     ┌──────────────────────────────────┐
│                  │     │   Aliyun HK — AI Gateway         │
└────────┬─────────┘     │   (SSE streaming proxy)          │
         │               │                                  │
         │  SSE stream   │   ┌───────────┐  ┌───────────┐  │
         └──────────────▶│   │ Claude API│  │ OpenAI API│  │
                         │   └───────────┘  └───────────┘  │
                         │   ┌───────────┐  ┌───────────┐  │
                         │   │ Gemini API│  │ DeepSeek  │  │
                         │   └───────────┘  └───────────┘  │
                         │   Active provider read from     │
                         │   Supabase ai_config at request │
                         └──────────────────────────────────┘
┌─────────────────┐
│   ElevenLabs API │  ← Audio intro generation (build-time, not runtime)
└─────────────────┘
```

**Key architectural decisions**:
- **Multi-LLM AI Gateway**: The Aliyun HK server runs a lightweight AI gateway (e.g., Node/Python service) that reads the active LLM provider from Supabase `ai_config` table and proxies requests. The iOS client never calls LLM APIs directly — it hits one endpoint. Chairman can switch providers from a simple admin dashboard without redeploying the app.
- **SSE streaming**: AI responses are delivered via Server-Sent Events to prevent timeout failures on long-running LLM calls. The gateway opens an SSE stream to the client and streams tokens as they arrive from the upstream LLM. Fallback: non-streaming POST endpoint for degraded connectivity.
- Audio is pre-generated at build time, NOT runtime. ElevenLabs is a build tool, not a runtime dependency.
- **Offline mode**: Text content and cached audio are available offline. AI dialogue requires connectivity. Local cache (Core Data or file-based) stores unlocked content after first sync; journal entries sync when online.
- All content (passages, commentary, prompts) stored as versioned markdown in the workspace repo, synced to Supabase at deploy time. Content is NOT hardcoded in Swift.
- Entitlements are the source of truth via RevenueCat. Supabase mirrors for query convenience but RevenueCat is authoritative.

---

*End of PRD v1.1. Revised 2026-04-16 with: multi-LLM backend + SSE streaming (P0-3), offline reading mode (P1-6), old reflections visible during replay (P1-1), $0.99 intro confirmed, Q2/Q4/Q6/Q7 closed. Phase 1 execution begins — see window prompts for parallel workstreams.*

# SumiDay Visual System

**Author**: GM (Claude)
**Date**: 2026-04-16
**Status**: v1.0 — locked for MVP development
**References**: brand/tonality-options.md (Option C Shodo selected), CLAUDE.md

This document is the single source of truth for all visual decisions. Chairman uses this file when building SwiftUI. Any deviation requires a DECISIONS.md entry.

---

## 1. Brand Metaphor (Design Foundation)

Sumi (墨) is the ink used in Zen calligraphy — made one stroke at a time, unrepeatable, contemplative. The visual system translates this into pixels:

- **Restraint over decoration.** Every element earns its place.
- **Negative space is active.** Emptiness is not absence — it is breath.
- **Nothing is symmetrically perfect.** The hand-made quality of sumi ink; slight imperfection signals authenticity.
- **Ceremony over efficiency.** Transitions are unhurried. The app does not rush the user.

Execution standard: **MUJI / Aesop / Kinfolk**. If a decision would feel appropriate on a fast-fashion app, it is wrong.

---

## 2. Color Palette

### Primary Colors

| Name | Hex | SwiftUI Token | Usage |
|------|-----|--------------|-------|
| **Sumi Ink** | `#1A1614` | `Color.sumiInk` | Primary text, primary backgrounds (dark mode), key UI elements |
| **Washi** | `#F2EDE4` | `Color.washi` | Primary background (light mode), card surfaces, breathing space |

### Accent Colors

| Name | Hex | SwiftUI Token | Usage |
|------|-----|--------------|-------|
| **Matcha** | `#6B8F71` | `Color.matcha` | Progress indicators, streak counter, level badges, positive states |
| **Persimmon** | `#C65D2A` | `Color.persimmon` | Primary CTA buttons, purchase actions, notification badges, ink-splash animations |

### Extended Palette (derived, do not invent new colors)

| Name | Hex | SwiftUI Token | Usage |
|------|-----|--------------|-------|
| **Sumi 80** | `#1A1614CC` | `Color.sumiInk.opacity(0.8)` | Secondary text on Washi |
| **Sumi 40** | `#1A161466` | `Color.sumiInk.opacity(0.4)` | Tertiary text, disabled states, placeholders |
| **Sumi 08** | `#1A161414` | `Color.sumiInk.opacity(0.08)` | Dividers, hairlines, subtle separators |
| **Washi Dark** | `#2A2420` | `Color.washiDark` | Dark mode card surface (slightly lighter than Sumi Ink) |
| **Matcha Light** | `#6B8F7126` | `Color.matcha.opacity(0.15)` | Progress bar tracks, level badge backgrounds |
| **Persimmon Light** | `#C65D2A1A` | `Color.persimmon.opacity(0.10)` | CTA button hover/pressed states |

### Color Rules

- **Never** use pure black (`#000000`) or pure white (`#FFFFFF`). Sumi Ink and Washi are the anchors.
- **Never** invent new colors for edge cases — derive via opacity from the 4 primaries.
- **Dark Mode**: Swap Washi (background) → Sumi Ink; keep Matcha and Persimmon unchanged; use Washi Dark for card surfaces.
- **Persimmon is precious.** Use sparingly — maximum one Persimmon element visible at a time per screen. It is the ink mark, not wallpaper.

---

## 3. Typography

### Typeface Selection

**Display & Headings: New York (Apple serif)**
- Built into iOS 17+, zero licensing cost
- Humanist serif with calligraphic stroke contrast — echoes the sumi brush
- Use: passage text, section headers, app name display, pull quotes

**Body & UI: SF Pro (Apple system)**
- Built into iOS 17+, zero licensing cost
- Use: navigation, labels, captions, settings, journal entry body

**Monospace (optional): SF Mono**
- Use sparingly: citation strings (e.g., "Platform Sutra, Ch. 1"), day counters, streak numbers — where precision signals credibility

### Type Scale

| Role | Font | Weight | Size | Line Height | Letter Spacing |
|------|------|--------|------|-------------|----------------|
| **App Name / Hero** | New York | Regular | 34pt | 41pt | -0.5pt |
| **Passage Text** | New York | Regular | 20pt | 32pt | -0.3pt |
| **Section Header** | New York | Medium | 22pt | 28pt | -0.2pt |
| **Card Title** | SF Pro | Semibold | 17pt | 22pt | -0.4pt |
| **Body / Caption** | SF Pro | Regular | 15pt | 22pt | -0.2pt |
| **Label / Tag** | SF Pro | Medium | 13pt | 18pt | 0pt |
| **Citation / Mono** | SF Mono | Regular | 13pt | 18pt | 0pt |
| **Micro / Legal** | SF Pro | Regular | 11pt | 16pt | 0pt |

### Typography Rules

- **Passage text gets New York.** This is non-negotiable. The serif signals "this is a text to be read carefully."
- **Never center-align body text.** Passages are left-aligned. Centered text is reserved only for single-line hero moments (tagline, path names).
- **No bold in passages.** Bold weight is reserved for UI chrome, never for the wisdom text itself — the text needs no emphasis.
- **Generous line height is mandatory.** The 32pt line height on passage text is not optional. The user needs room to breathe between lines.
- **All-caps sparingly.** Acceptable for short labels (e.g., "DAY 7", "STREAK") with +1pt letter-spacing. Never for passages or commentary.

---

## 4. Spacing & Layout

### Base Unit

**8pt grid.** All spacing values are multiples of 8 (or 4 for micro adjustments).

| Token | Value | Usage |
|-------|-------|-------|
| `Space.xs` | 4pt | Icon-to-label gap, tight inline spacing |
| `Space.sm` | 8pt | Between related elements |
| `Space.md` | 16pt | Standard padding, between cards |
| `Space.lg` | 24pt | Section separators |
| `Space.xl` | 32pt | Screen-level top/bottom padding |
| `Space.xxl` | 48pt | Hero section breathing room |
| `Space.section` | 64pt | Between major page sections |

### Layout Principles

- **Content margins**: 24pt horizontal on iPhone (never 16pt — too tight for contemplative content).
- **Safe area**: Always respect. No content under home indicator.
- **Card corner radius**: 16pt for large cards, 10pt for small chips/badges.
- **Passage screen**: Maximum content width 680pt (will letterbox on large phones). The line length matters for reading comfort.
- **Negative space is intentional.** A screen with generous empty space is correct. Filling space because it feels empty is wrong.

---

## 5. Iconography

### Style
- **Line icons only.** SF Symbols, weight: Regular (never Bold in passage context).
- **Fill icons**: reserved for tab bar active states only.
- **Size**: 22pt touchable area minimum; icon visual size 20pt for nav, 18pt for inline.

### Key Icons (SF Symbols mappings)

| Element | SF Symbol | Notes |
|---------|-----------|-------|
| Daily Practice | `sun.horizon` | Home screen, morning session |
| Journal | `text.alignleft` | Tab bar |
| Path / Progress | `circle.dotted` | Progress indicators |
| Streak | `flame` | Only when streak > 0 |
| Level / Badge | `seal` | Practitioner level |
| Audio Play | `play.circle` | Session audio player |
| Audio Pause | `pause.circle` | |
| Voice Input | `waveform` | STT recording |
| Unlock / Purchase | `lock.open` | Coming soon paths |
| Settings | `gearshape` | |
| Notification | `bell` | |
| Koan / Question | `questionmark.bubble` | Socratic prompt indicator |

### Rules
- **Never use emoji as UI icons.** Emoji are culturally misaligned with Shodo brand.
- **No colored icons** except Persimmon for the primary action icon (e.g., active record button).

---

## 6. Motion & Animation

### Principles

**Unhurried. Intentional. Never decorative.**

Every animation serves a purpose: it either communicates state change, guides attention, or reinforces the ritual quality of the practice. Animations that exist purely for delight are removed.

### Timing & Easing

| Type | Duration | Curve | Usage |
|------|----------|-------|-------|
| **Micro** | 150ms | `easeOut` | Button states, icon toggles |
| **Standard** | 280ms | `spring(dampingFraction: 0.8)` | Card transitions, modal presentation |
| **Deliberate** | 450ms | `spring(dampingFraction: 0.7)` | Screen transitions, passage reveal |
| **Ceremonial** | 600–900ms | Custom spring | Level-up, path completion, first launch |

### Key Animations

**Session Open — Ink Wash Reveal**
The passage text fades in from top to bottom, as if the ink is drying on the page. Implementation: staggered opacity + subtle upward translate (8pt), each text block delayed 80ms from the previous.

**Streak / Level-Up — Ink Splash**
A single Persimmon ink-splash shape (custom SVG, asymmetric, hand-made quality) scales from 0 to 1 with a brief overshoot (spring, dampingFraction: 0.5). Duration: 600ms. No confetti. No particles. One mark.

**Tab Bar Transitions**
Crossfade only. No slide. 280ms easeInOut.

**Audio Player Progress**
The progress bar fills with Matcha at a rate synchronized to audio playback. No animation — it is real-time data, not decoration.

**Koan Reveal**
After user submits reflection, the AI response appears with a 900ms deliberate fade. No typewriter effect — the full response appears as one breath. The waiting moment (before reveal) shows a single centered dot pulsing at 1.2s intervals.

### Rules
- **No parallax scrolling.**
- **No bounce on scroll.** Standard iOS scroll behavior only.
- **No skeleton loaders.** If content isn't ready, show the Washi background with a subtle opacity pulse on a placeholder block (800ms, opacity 0.3→0.6→0.3, repeat).
- **Haptics**: Use `UIImpactFeedbackGenerator(.light)` on session completion, `.medium` on purchase confirmation. No haptics on routine navigation.

---

## 7. Dark Mode

SumiDay fully supports dark mode. The palette inverts gracefully:

| Element | Light Mode | Dark Mode |
|---------|-----------|-----------|
| Screen background | Washi `#F2EDE4` | Sumi Ink `#1A1614` |
| Card surface | White `#FFFFFF` (8% elevation) | Washi Dark `#2A2420` |
| Primary text | Sumi Ink `#1A1614` | Washi `#F2EDE4` |
| Secondary text | Sumi 80 | `#F2EDE4CC` |
| Tertiary text | Sumi 40 | `#F2EDE466` |
| Dividers | Sumi 08 | `#F2EDE414` |
| Matcha | `#6B8F71` | `#7FA882` (slightly lighter for contrast) |
| Persimmon | `#C65D2A` | `#D4703A` (slightly lighter for contrast) |

**Implementation**: Use SwiftUI's `@Environment(\.colorScheme)` + semantic color assets in the Xcode Asset Catalog. Define all colors as adaptive pairs. Never hardcode hex in SwiftUI views.

---

## 8. Components (SwiftUI Reference)

### PassageCard
The central UI component. Used on the daily session screen.

```
Background: Washi (light) / Washi Dark (dark)
Corner radius: 16pt
Padding: 24pt all sides
Shadow: none (flat design — shadows are too decorative)
Border: none in light mode; 1pt Sumi 08 hairline in dark mode

Content layout (top to bottom):
  Citation label — SF Mono, 13pt, Sumi 40
  [Space.sm — 8pt]
  Passage text — New York Regular, 20pt, Sumi Ink, line height 32pt
  [Space.lg — 24pt]
  Divider — 1pt, Sumi 08, full width
  [Space.lg — 24pt]
  Modern reading — SF Pro Regular, 15pt, Sumi 80, line height 22pt
```

### PractitionerBadge
Displays the user's current level.

```
Shape: Rounded rectangle, 10pt radius
Background: Matcha Light (15% opacity)
Border: 1pt Matcha
Text: SF Pro Medium, 13pt, Matcha
Content: "INITIATE" / "APPRENTICE" / "PRACTITIONER" / "ADEPT" / "SAGE"
```

### PrimaryButton (CTA)
```
Background: Persimmon
Corner radius: 14pt
Height: 56pt
Text: SF Pro Semibold, 17pt, Washi
Pressed state: Persimmon Light overlay (10% white), scale 0.97, 150ms easeOut
Disabled state: Sumi 08 background, Sumi 40 text
```

### StreakCounter
```
Icon: SF Symbol `flame`, 20pt, Persimmon (only when streak > 0; Sumi 40 when streak = 0)
Number: SF Mono, 22pt, Sumi Ink (or Persimmon when streak > 7)
Label: SF Pro, 11pt, Sumi 40, "DAY STREAK"
```

---

## 9. App Icon

**Concept**: A single sumi brushstroke forming an abstract circle (ensō 円相) — the Zen symbol of completeness, the universe, emptiness. The stroke is imperfect, hand-made, open at one end (an open ensō, signifying room for growth).

**Execution**:
- Background: Sumi Ink `#1A1614`
- Stroke: Washi `#F2EDE4`, variable width (thick at start, tapers to end)
- No wordmark on icon — the shape alone is the identity
- Corner rounding: iOS standard (no custom mask needed, let Apple's rounding apply)

**At small sizes (16pt, 29pt)**: The ensō simplifies to a thick arc — legible, not muddy.

---

## 10. What This System Is Not

To prevent scope creep during development:

- **Not a meditation app.** No lotus flowers, no mountains, no water ripples, no gradient sunsets. These are clichés that compete with the content.
- **Not a Japanese aesthetics mood board.** Sumi ink is the single Eastern visual reference. No torii gates, no cherry blossoms, no koi fish.
- **Not a productivity app.** No dashboard grids, no bar charts (except the optional streak heatmap in P2), no gamification chrome.
- **Not a dark academia app.** New York serif is chosen for its warmth, not its library associations. No leather textures, no aged paper, no candlelight effects.

The visual system has one job: to make the user feel that what they are about to read is worth their complete attention.

---

*End of Visual System v1.0. Next update: after first Figma mockup review (if commissioned) or after TestFlight feedback on UI feel.*

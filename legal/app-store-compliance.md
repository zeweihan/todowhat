# SumiDay — Apple App Store Compliance Checklist

**Effective date:** 2026-04-16
**Last updated:** 2026-04-16
**Bundle ID:** com.sumiday.sumi
**Category:** Health & Fitness → Lifestyle (primary); Education (secondary — to discuss with Apple)

---

This checklist maps Apple App Store Review Guidelines requirements to SumiDay's specific product profile. Each item includes the guideline reference, the requirement, SumiDay's approach, and implementation status.

Legend: ✅ Ready / In design · ⚠️ Requires action before submission · 🔲 Not yet started

---

## 1. Subscriptions (Guideline 3.1.2)

### 1.1 Auto-Renewable Subscription Requirements

| # | Requirement | SumiDay Approach | Status |
|---|---|---|---|
| 3.1.2(a) | Subscription must provide ongoing value, not one-time content | Daily practice system, AI dialogue, and reflection log are ongoing services | ✅ |
| 3.1.2(b) | Price must be displayed clearly before purchase | Paywall screen to show price, billing frequency, and trial terms explicitly | ✅ In design |
| 3.1.2(c) | Free trial period must be clearly communicated | "7-day free trial, then [price]/month. Cancel any time in iOS Settings." — include on paywall | ⚠️ Copy needed |
| 3.1.2(d) | Cannot lock content the user has already paid for in a previous period | Reflections and practice logs remain accessible as long as account exists | ✅ |
| 3.1.2(e) | Must provide a privacy policy | Privacy Policy at https://sumi.day/privacy and in App Settings | ✅ |
| 3.1.2(f) | Must include a link to Terms of Service | ToS at https://sumi.day/terms and in App Settings | ✅ |
| 3.1.2(g) | Subscription management must be available in iOS Settings | Managed natively by Apple/StoreKit — no action needed | ✅ |

### 1.2 Paywall and Free Trial Implementation Notes

- **Trial duration:** 7 days (subject to final decision by chairman).
- **Paywall copy** must clearly state: trial length, what happens at trial end, subscription price and frequency, that billing is managed by Apple, and how to cancel.
- **Do not** promise a refund in app copy — direct users to Apple for refund requests.
- **Do not** gate features that are part of Apple's required restore flow (see 1.3 below).

---

## 2. Restore Purchases (Guideline 3.1.1)

| # | Requirement | SumiDay Approach | Status |
|---|---|---|---|
| 3.1.1(a) | Must provide a "Restore Purchases" mechanism | "Restore Purchases" button in App Settings → Subscription | ⚠️ Must be in build |
| 3.1.1(b) | Restore must use the same Apple ID | Handled by StoreKit 2 / RevenueCat automatically | ✅ |
| 3.1.1(c) | Restore must surface appropriate error messages if nothing found | RevenueCat SDK handles; UI string needed: "No active subscription found for this Apple ID." | ⚠️ UI string needed |

**Implementation note for chairman:** RevenueCat's SDK provides `Purchases.shared.restorePurchases()` — wire this to the "Restore Purchases" button. Test on a fresh install before submission.

---

## 3. Privacy Nutrition Label (App Privacy)

Apple requires a completed privacy nutrition label in App Store Connect before submission. The following reflects SumiDay's data practices:

### Data Used to Track You
**None.** SumiDay does not use data to track users across apps or websites for advertising. Select "We do not collect data used to track you."

### Data Linked to You

| Category | Data Type | Purpose |
|---|---|---|
| Contact Info | Email address | Account management |
| Identifiers | User ID | App functionality |
| User Content | Other user content (written reflections, practice logs) | App functionality |

### Data Not Linked to You

| Category | Data Type | Purpose |
|---|---|---|
| Diagnostics | Crash data | App functionality / analytics |
| Usage Data | Product interaction (feature usage, session data — TelemetryDeck) | Analytics |

### Important Notes for App Store Connect Entry
- TelemetryDeck signals are **not linked to you** — TelemetryDeck hashes identifiers and does not allow re-identification.
- RevenueCat purchase data is linked to you (via Apple ID) but this is handled under Apple's own data collection for StoreKit and does not need to be separately declared as SumiDay-collected data — however, confirm with App Store Review if in doubt.
- **Do not** declare data collection categories that you do not actually collect; this is grounds for rejection.

---

## 4. AI-Generated Content Disclosure (Guideline 1.1 and Developer Guidelines)

Apple requires disclosure when apps use AI to generate content that could mislead users.

| # | Requirement | SumiDay Approach | Status |
|---|---|---|---|
| AI disclosure | Clearly disclose that dialogue responses are AI-generated | Onboarding: "Your conversations are powered by AI — an artificial intelligence, not a human sage or licensed professional." | ⚠️ Copy needed |
| AI hallucination risk | AI content may be inaccurate; do not present it as authoritative | ToS Section 9.3 covers this; in-app: add a persistent label on dialogue screen such as "AI response — may be imperfect" | ⚠️ UI label needed |
| Sage persona framing | Fictional character framing is acceptable; must not impersonate real living persons | Sage personas are historical figures (deceased) presented as AI interpretations. This is acceptable under Apple guidelines. | ✅ |

**Recommended in-app disclosure (dialogue screen footer):**
> *Responses are generated by AI based on classical texts. This is not a real person and not professional advice.*

---

## 5. Health & Wellness Category Requirements (Guideline 5.1.3 / Developer Guidelines)

Because SumiDay is in the Health & Fitness or Lifestyle category and touches on mental well-being themes:

| # | Requirement | SumiDay Approach | Status |
|---|---|---|---|
| 5.1.3(a) | Apps offering "mental wellness" content must include a wellness disclaimer | Covered by `not-medical-advice.md` — in onboarding and Settings | ✅ |
| 5.1.3(b) | Apps must not diagnose, treat, or cure medical conditions | SumiDay makes no such claims; ToS Section 8 and not-medical-advice.md are explicit | ✅ |
| 5.1.3(c) | Crisis resources must be provided if content may touch on distress | Crisis resources included in not-medical-advice.md; AI safety guidelines in place | ✅ |
| 5.1.3(d) | Must not encourage or enable self-harm | AI content safety guidelines in not-medical-advice.md Part D address this | ✅ |
| Medical claims in marketing | App Store description must not make medical claims | Review all App Store copy before submission against this checklist | ⚠️ Copy review needed |

---

## 6. User-Generated Content (Guideline 1.2)

SumiDay v1 has no social or community features. User Reflections are private to each account. However, Guideline 1.2 still applies to UGC apps in some respects:

| # | Requirement | SumiDay Approach | Status |
|---|---|---|---|
| 1.2(a) | Report/flag mechanism for objectionable content | N/A — no user-to-user content visible in v1 | ✅ Not applicable |
| 1.2(b) | Block functionality | N/A — no social graph | ✅ Not applicable |
| 1.2(c) | Content moderation policy | Reflections are private; no public UGC to moderate in v1 | ✅ |

---

## 7. Sign in with Apple (Guideline 4.8)

Apple requires Sign in with Apple to be offered when any third-party login is offered.

| # | Requirement | SumiDay Approach | Status |
|---|---|---|---|
| 4.8(a) | If app offers any third-party login, must also offer Sign in with Apple | SumiDay offers both Sign in with Apple AND email/password (Supabase Auth) | ✅ |
| 4.8(b) | Sign in with Apple button must meet Apple's visual guidelines | Use official ASAuthorizationAppleIDButton component | ⚠️ Chairman to implement |
| 4.8(c) | Cannot require users to provide additional personal info beyond what Apple provides | Registration flow only asks for optional display name after Sign in with Apple | ✅ |

---

## 8. Age Rating

| # | Requirement | SumiDay Approach | Status |
|---|---|---|---|
| Age Rating | Set appropriate age rating in App Store Connect | Recommend **4+** (no objectionable content, no user-to-user features). If AI dialogue is considered "mature themes" by Apple, may need 12+. Safer to start with **12+** to avoid review friction. | ⚠️ Confirm with chairman |
| COPPA / GDPR-K | App not directed at children under 13 | Privacy Policy Section 1 states explicitly; no child-directed content or features | ✅ |

**Recommendation:** Submit with **12+** rating. The philosophical content (discussions of death, suffering, impermanence in Stoicism and Buddhism) may trigger a 12+ flag anyway. 12+ still excludes overtly mature content and is appropriate for SumiDay's target demographic.

---

## 9. App Store Description Compliance

The App Store product page copy must comply with the following before submission:

| # | Check | Notes |
|---|---|---|
| No medical claims | "helps you feel better", "reduces anxiety", "treats depression" — **prohibited** | Use language like "a daily philosophical practice", "engage with classical wisdom", "cultivate daily reflection" |
| No guaranteed outcomes | "you will achieve inner peace" — **prohibited** | Use language like "explore", "discover", "practice", "reflect" |
| Accurate feature description | Described features must be in the submitted build | Review description against the build at submission time |
| Wellness disclaimer | Include short disclaimer at end of description | Use Version 3 from not-medical-advice.md: "SumiDay is for philosophical practice, not professional advice." |
| Privacy policy URL | Must be present in App Store Connect metadata | https://sumi.day/privacy |
| Support URL | Must be present in App Store Connect metadata | https://sumi.day/support or support@sumi.day |
| AI disclosure | Note AI-generated content in description | "Daily practice sessions and sage dialogues are powered by AI." |

---

## 10. Localisation and Dual-Language Launch

| # | Requirement | SumiDay Approach | Status |
|---|---|---|---|
| ES localisation | App Store metadata (name, subtitle, description, keywords) must be in Spanish for ES markets | Produce ES App Store copy when EN copy is finalised | 🔲 |
| In-app strings | All UI strings localised in EN + ES | Chairman to implement Localizable.strings; ES strings from GM | 🔲 |
| Legal docs in Spanish | Terms and Privacy Policy in Spanish for Latin America | Defer to legal translation project; link to EN until ES is ready; add note in footer | ⚠️ Deferred |

---

## 11. Pre-Submission Review Checklist (Before Every Build Submission)

Run through this checklist before submitting to App Store Review:

- [ ] "Restore Purchases" button present and functional.
- [ ] Free trial terms clearly displayed on paywall screen.
- [ ] Subscription price, frequency, and auto-renewal language on paywall.
- [ ] "Managed by Apple" language on paywall (no SumiDay billing UI).
- [ ] Wellness disclaimer shown in onboarding with acknowledgement tap.
- [ ] AI disclosure label present on dialogue screen.
- [ ] Privacy Policy link in App Settings → About.
- [ ] Terms of Service link in App Settings → About.
- [ ] "Delete Account" function present and working.
- [ ] App Store Connect privacy nutrition label filled in and accurate.
- [ ] App Store description reviewed for medical claims.
- [ ] Support URL and Privacy Policy URL entered in App Store Connect.
- [ ] Age rating set to 12+.
- [ ] All features described in the App Store listing are present in the build.
- [ ] Sign in with Apple button uses official `ASAuthorizationAppleIDButton`.

---

## 12. Outstanding Actions (Requires Chairman or GM)

| Action | Owner | Priority |
|---|---|---|
| Finalise paywall copy (trial terms, price display) | GM drafts, Chairman approves | HIGH — needed before first TestFlight |
| Implement "Restore Purchases" button (StoreKit / RevenueCat) | Chairman | HIGH |
| Add AI disclosure label to dialogue screen | Chairman (UI), GM (copy) | HIGH |
| Confirm age rating choice (12+ vs 4+) | Chairman decides | MEDIUM |
| Produce App Store listing copy (EN) | GM | MEDIUM — Phase 2 |
| Produce App Store listing copy (ES) | GM | MEDIUM — Phase 2 |
| Legal docs translated to Spanish | GM (draft AI translation) + native speaker review | LOW — Phase 3 |

---

*Drafted by SumiDay GM (Claude). Chairman to review and mark implementation items complete as the build progresses.*

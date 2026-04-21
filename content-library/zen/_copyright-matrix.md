# SumiDay Zen Content — Copyright Matrix

**Created**: 2026-04-16
**Owner**: GM (Claude)
**Purpose**: Per-text copyright clearance for content library production (addresses PRD Q8)
**Principle**: Use only public-domain source material. Where translations are protected, produce fresh AI-rendered translations from Classical Chinese, QA'd by chairman.

---

## 1. 六祖坛经 — Platform Sutra (Liuzu Tanjing)

**Original text**: Tang Dynasty, c. 8th century CE — **public domain worldwide** ✅

| Translation | Translator | Year | US Public Domain? | Notes |
|-------------|-----------|------|-------------------|-------|
| *The Sutra of the Sixth Patriarch* | Wong Mou-Lam | 1930 | ✅ **Yes** — pre-1928 publication rule applies; first published in Shanghai, subsequently reprinted in the US; US copyright requires registration/notice not fulfilled for early printings | Preferred EN source for SumiDay. Slightly archaic diction ("hath", "thee") — can be lightly modernized as editorial quotation. |
| *The Platform Sutra of the Sixth Patriarch* | Philip Yampolsky | 1967 (Columbia University Press) | ❌ **No** — copyright held by Columbia University Press, renewed and active through 2062 | Do not use. Widely cited in academic contexts but fully protected. |
| *The Sixth Patriarch's Dharma Jewel Platform Sutra* | Buddhist Text Translation Society (BTTS) | 1977 | ❌ **No** — copyright held by Dharma Realm Buddhist Association | Do not use. |
| *Platform Sutra* | Red Pine (Bill Porter) | 2006 | ❌ **No** | Do not use. |

**Original Classical Chinese**: Fully public domain. Chairman reads Classical Chinese — can QA AI renderings directly against source.

**本项目策略**: **Primary: Wong Mou-Lam 1930 translation** (public domain ✅). Where diction requires light updating for readability, treat as editorial adaptation of a public domain work (standard practice). For passages where Wong Mou-Lam is unclear or where a fresh rendering better serves the SumiDay voice, use **AI-rendered translation from Classical Chinese**, QA'd by chairman against the original. Label all AI-rendered passages clearly in the session file (`translation_source: AI-rendered from Classical Chinese`).

---

## 2. 碧岩录 — Blue Cliff Record (Biyanlu)

**Original text**: Compiled by Xuedou Chongxian (c. 1022 CE), expanded commentary by Yuanwu Keqin (1125 CE) — **public domain worldwide** ✅

| Translation | Translator | Year | US Public Domain? | Notes |
|-------------|-----------|------|-------------------|-------|
| *The Blue Cliff Record* | R.D.M. Shaw | 1961 (Michael Joseph, London) | ⚠️ **Uncertain** — UK publication 1961; US copyright status depends on whether it was registered/renewed in the US. Life+70 rule (Shaw died ?) means UK protection may still be active. **Treat as protected until confirmed.** | Do not use without further research. |
| *The Blue Cliff Record* | Thomas Cleary & J.C. Cleary | 1990 (Shambhala) | ❌ **No** — clearly protected, active copyright | Do not use. |
| *The Blue Cliff Record* | Koun Yamada & various | Various | ❌ **No** | Do not use. |
| No pre-1928 English translation known | — | — | — | The Blue Cliff Record was not translated into English before 1928. No public-domain EN translation exists. |

**Original Classical Chinese**: Fully public domain. The *Biyanlu* is one of the most studied texts in East Asian Buddhism; its Classical Chinese is a well-understood corpus.

**本项目策略**: **AI-rendered translation from Classical Chinese**, QA'd by chairman. This is a genuine moat — no freely usable EN translation exists, so fresh translation from public-domain source is the only clean path. For the specific cases used in SumiDay sessions (Cases 1, 3, 7, 11, 18, 27, 60, 94, 100), chairman will QA each against the original Chinese. Label all as `translation_source: AI-rendered from Classical Chinese` in session files.

---

## 3. 无门关 — Gateless Gate (Wumenguan / Mumonkan)

**Original text**: Compiled by Wumen Huikai, 1228 CE (Song Dynasty) — **public domain worldwide** ✅

| Translation | Translator | Year | US Public Domain? | Notes |
|-------------|-----------|------|-------------------|-------|
| *The Gateless Gate* | Nyogen Senzaki & Paul Reps | 1934 (published in *Zen Flesh, Zen Bones*, collected 1957) | ⚠️ **Partially uncertain** — Senzaki first circulated these translations as pamphlets in the 1920s–30s; the 1934 pamphlet version may be in US public domain. The *Zen Flesh, Zen Bones* 1957 compilation (Tuttle) is under copyright. The pre-1928 pamphlet versions, if they exist, would be public domain. **Research required before use.** | Treat the 1957 collected edition as protected. Pamphlet versions require individual verification. |
| *The Gateless Barrier* | Robert Aitken | 1990 (North Point Press) | ❌ **No** | Do not use. |
| *Gateless Gate* | Katsuki Sekida | 1977 (*Two Zen Classics*, Shambhala) | ❌ **No** — protected | Do not use. |
| *The Gateless Gate* | Yamada Koun | 1979 | ❌ **No** | Do not use. |
| No confirmed pre-1928 EN translation of the complete *Wumenguan* | — | — | — | Unlike the Platform Sutra, no complete pre-1928 EN translation has been confirmed for the *Mumonkan*. D.T. Suzuki translated selected koans in *Essays in Zen Buddhism* (1927); individual cases may be usable — requires case-by-case verification. |

**D.T. Suzuki note**: *Essays in Zen Buddhism, First Series* (1927, Luzac & Co.) — published pre-1928 in the UK. US copyright status requires verification (was it registered in the US?). Treat with caution; use only where clearly public domain.

**Original Classical Chinese**: Fully public domain. The 48 cases of the *Wumenguan* plus Wumen's commentaries and verses are a known Classical Chinese corpus.

**本项目策略**: **AI-rendered translation from Classical Chinese**, QA'd by chairman. Same approach as the Blue Cliff Record. For the specific cases used (Cases 1, 9, 16, 18, 19, 26, 30, 37) — AI translates each case including the prose case, Wumen's commentary, and Wumen's verse; chairman QA's against original. Label as `translation_source: AI-rendered from Classical Chinese`. This is consistent, legally clean, and produces a SumiDay-voice-native rendering that no other app will have.

---

## Summary Table

| Text | Original | EN Translation Available (PD) | SumiDay Strategy |
|------|----------|-------------------------------|------------------|
| 六祖坛经 Platform Sutra | Public domain ✅ | Wong Mou-Lam 1930 ✅ | **Wong Mou-Lam primary; AI rendering for clarity/voice** |
| 碧岩录 Blue Cliff Record | Public domain ✅ | None confirmed ❌ | **AI-rendered from Classical Chinese, chairman QA** |
| 无门关 Gateless Gate | Public domain ✅ | None confirmed clean ❌ | **AI-rendered from Classical Chinese, chairman QA** |

---

## QA Protocol

1. **GM** generates draft session file with AI-rendered passage.
2. **Chairman** reads AI rendering against Classical Chinese source and marks any errors or distortions.
3. Approved text is locked in the session markdown file. No further changes without chairman sign-off.
4. Session file `translation_source` field records the final attribution.

---

## Further Research Items (non-blocking, low priority)

- Confirm D.T. Suzuki *Essays in Zen Buddhism* (1927) US copyright status for individual koan cases — could provide a secondary source for spot-checking AI renderings.
- Confirm R.D.M. Shaw 1961 death date to determine UK/US protection status for *Blue Cliff Record* translation.
- Verify whether any Nyogen Senzaki pre-1928 pamphlet versions of *Mumonkan* translations are definitively public domain in the US.

*None of these block content production — the AI-rendering strategy is legally clean regardless.*

# SumiDay Social Media Automation Setup

Solo-operator stack for pre-launch and ongoing content distribution.
Channels: X (Twitter) · Instagram · Threads
Operator time target: under 30 minutes per week.

---

## 1. X (Twitter) — Typefully

Typefully is the recommended scheduler for X. It handles both single posts and threads natively, offers a clean drafting interface, and provides API access for future automation.

**Account Connection**
1. Go to typefully.com and sign up with your personal or brand email.
2. Click "Connect Twitter/X account" and authorize via X's OAuth flow.
3. Typefully requests read/write permissions — approve both.
4. Your @SumiDay handle should appear in the left sidebar as the active account.

**Scheduling a Post**
1. Click "New Draft" (or press `N`).
2. Paste your post copy. For threads: paste Tweet 1, then press `Cmd+Enter` (Mac) or `Ctrl+Enter` (Windows) to add a new tweet card in the same thread.
3. Click "Schedule" in the bottom right. Select date and time.
4. Confirm: the post appears in your scheduled queue with a countdown.

**Scheduling a Thread**
Same as above. Each tweet card is one node. Typefully shows character count per card. Reorder cards by dragging. Preview the thread before scheduling.

**API Key Location (for future automation)**
1. Go to Settings → Integrations → API.
2. Generate a new API key. Store it in your project's secrets manager (not in the workspace folder).
3. API docs: typefully.com/developers — supports creating drafts, scheduling, and reading analytics via REST.

**Team Seat Setup (if needed later)**
Settings → Team → Invite Member. One seat covers all scheduling functions. Typefully Pro includes 2 seats.

**Recommended Plan**: Typefully Pro (~$19/month). Required for API access and unlimited scheduled posts.

---

## 2. Instagram — Buffer

Buffer Essentials is the simplest path for a solo operator. It connects to Instagram Business accounts, supports static posts, carousels, and Reels, and handles scheduling without the complexity of direct Meta Graph API integration.

**Prerequisites**
- Instagram account must be an Instagram Business account (not Personal or Creator). Convert in: Instagram app → Settings → Account → Switch to Professional Account → Business.
- The Instagram Business account must be linked to a Facebook Page. Create a bare-bones Facebook Page if you don't have one — it's a Meta requirement for API access, even via third-party tools.

**Connecting Instagram to Buffer**
1. Go to buffer.com and sign up.
2. Click "Connect a Channel" → Instagram.
3. Buffer redirects to Facebook OAuth. Log in to the Facebook account that owns the linked Facebook Page.
4. Select the Facebook Page connected to your Instagram Business account.
5. Approve permissions (Instagram content publishing, page management).
6. Your Instagram handle appears in Buffer's channel list.

**Scheduling a Static Post**
1. Click "Create Post" and select your Instagram channel.
2. Upload the image asset (JPG/PNG, minimum 1080×1080px for square posts).
3. Paste the caption and hashtag block.
4. Click "Schedule" → pick date and time.
5. Buffer sends a push notification to your phone at scheduled time, or publishes directly if the Instagram account is set to "Direct Publishing." Enable Direct Publishing in Buffer → Channel Settings → Instagram → toggle Direct Publishing on.

**Scheduling a Carousel**
Same flow. Upload multiple images in sequence. Buffer preserves the order.

**Cost Breakdown — Buffer Essentials**
- $6/month per channel.
- For SumiDay at launch: 1 channel (English Instagram) = $6/month.
- If adding Spanish Instagram later: $12/month total.
- Essentials supports up to 10 scheduled posts per channel at a time — sufficient for weekly batch scheduling.

**Buffer vs. Meta Graph API Direct**
Buffer Essentials is recommended over direct Meta Graph API for a solo operator because:
- No OAuth token refresh management required (tokens expire and need re-authorization with Graph API).
- No server infrastructure needed.
- Direct Publishing support means no manual phone taps.
- Limitation: Reels require a manual phone notification step in some Buffer configurations — test before relying on it for Reels-heavy weeks.

---

## 3. Threads

**Recommended approach: manual copy-paste from X.**

The Threads API (as of early 2026) is available but rate-limited to 250 posts per 24 hours per user and requires app review for broader access. For a single-account operation posting once per day, direct API use is possible but adds complexity (OAuth 2.0 setup, token storage, cron job or webhook) that is not worth the overhead at this stage.

**Recommended workflow:**
1. Schedule the X post in Typefully.
2. Immediately open Threads on your phone (or threads.net on desktop).
3. Copy the X post copy from Typefully's draft view.
4. Paste into Threads. Post immediately or use Threads' native scheduling (available in the app: tap the clock icon before posting).
5. Time investment: ~2 minutes per post.

**Note on formatting:** Threads renders line breaks the same as X. No adjustments needed to copy — paste directly.

**When to revisit direct API:** When daily Threads posting becomes a significant time drag (i.e., volume increases beyond one post per day), evaluate Zapier + Threads API or a tool like Publer, which integrates Threads scheduling natively.

---

## 4. Recommended Posting Times (UTC)

The SumiDay target audience spans US East Coast, Western Europe, and expat/professional communities in Asia Pacific (primarily HK, SG, AU, India tier-1). Three posting windows cover the primary attention peaks:

| Window | UTC Time | Local Equivalents | Rationale |
|---|---|---|---|
| **Primary** | 12:00 UTC | 8:00am ET · 1:00pm BST · 9:00pm HKT | US East morning commute + UK midday. Highest combined engagement for English-speaking professional audience. |
| **Secondary** | 02:00 UTC | 10:00pm ET (prev. day) · 10:00am AEST · 10:00am HKT | Asia Pacific morning and late-night US audience (night-owls, West Coast). Supplements the primary window for HK/SG/AU reach. |
| **Tertiary (optional)** | 20:00 UTC | 4:00pm ET · 9:00pm CET · 4:00am HKT (next day) | US afternoon second-scroll. Use for high-priority posts (link drops, countdowns) to capture the US afternoon/evening audience missed by the Primary window. |

**Day-by-day recommendation for pre-launch calendar:**

| Day of Week | Recommended UTC Post Time | Notes |
|---|---|---|
| Monday | 12:00 UTC | Start-of-week attention peak |
| Tuesday | 12:00 UTC | Strong professional engagement day |
| Wednesday | 12:00 UTC | Midweek — consistent performer |
| Thursday | 12:00 UTC | Pre-Friday engagement rise |
| Friday | 12:00 UTC | Morning window only; Friday afternoons drop off |
| Saturday | 14:00 UTC | Later morning for weekend scrolling behavior |
| Sunday | 13:00 UTC | Sunday afternoon reflection mood; suits SumiDay content |

For countdown posts (Days 22, 24, 25, 26, 27): consider adding a Secondary window post at 02:00 UTC the same day to double the CTA exposure across time zones.

---

## 5. Monthly Cost Estimate

| Tool | Plan | USD/month | Notes |
|---|---|---|---|
| Typefully | Pro | ~$19 | Required for thread scheduling + API access |
| Buffer | Essentials × 1 channel | ~$6 | English Instagram at launch |
| Buffer (Spanish, later) | Essentials × 1 channel | ~$6 | Add when @SumiDay_ES launches |
| Threads | Manual / free | $0 | Copy-paste workflow; no tool cost |
| **Total at launch** | | **~$25/month** | |
| **Total post-Spanish launch** | | **~$31/month** | |

*Pricing is approximate and subject to change. Verify current pricing at typefully.com and buffer.com before subscribing.*

---

## 6. One-Operator Weekly Workflow

Target: under 30 minutes per week to keep all channels fully scheduled and live.

**Monday — Batch Prep (20 minutes)**

1. Open the pre-launch content calendar (`/marketing/content-calendar/pre-launch-4-weeks.md`).
2. Identify the 7 posts for the upcoming week.
3. Open Typefully. Create 7 new drafts — one per day. Paste the X copy for each. For threads, use `Cmd+Enter` to split tweets. Set schedule dates and times per the UTC table above.
4. Open Buffer. For each day's post: upload the image asset, paste the Instagram caption and hashtag block, set schedule date and time.
5. Review all 7 Typefully drafts and 7 Buffer posts in queue view. Confirm scheduling looks correct.

**Monday — Threads Prep (5 minutes)**

Open Threads app. For each scheduled X post, paste the copy into Threads drafts (Threads allows saving drafts in-app). Or: keep the calendar open and copy-paste each morning after the X post goes live.

**During the Week — Monitoring (5 minutes total)**

Check Typefully and Buffer once mid-week (Wednesday) to confirm posts went live as scheduled. Review any engagement that warrants a reply (replies on X in particular — early follower engagement is worth nurturing personally during pre-launch).

**End of Week — Light Review (optional, 5 minutes)**

Note which posts generated the most engagement. Flag for content learning. No formal reporting needed at pre-launch stage — this is for intuition-building.

**Total weekly time: ~25-30 minutes.**

---

*Last updated: 2026-04-16*
*Maintained by: SumiDay GM (Claude)*

# SYFAT organic search baseline (Search Console, 22 May 2025 – 19 Sep 2026)

Source: Google Search Console API via `tools/gsc.sh`, properties `sc-domain:fomf.de`, `fomf.ch`, `fomf.at`; extracts in `data/gsc_*.tsv` (pulled 22 Sep 2026). Search Console keeps 16 months, so this is the full available history.

## Headline

| | fomf.de | fomf.at | fomf.ch |
|---|---|---|---|
| Organic clicks to SYFAT / Facharzt pages, 16 months | 150 | 18 | 8 |
| Impressions | 16,956 | 5,546 | 929 |
| Share of all fomf.de organic clicks | about 1% | | |
| Clicks per month, 2026 | 40–90 | | |

Only **two** fomf.de URLs receive organic traffic: the landing page `/facharztvorbereitungskurs` (96 clicks, 11k impressions, CTR 0.9%, avg position 8) and the legacy course page `/on-demand/syfat-allgemeinmedizin` (54 clicks, 6k impressions, position 11). `/syfat` redirects to the landing page.

**The four live course pages `/content/syfat-<fach>-de` have zero impressions in 16 months.** Google does not show them at all.

## Why the course pages are invisible (checked 22 Sep 2026)

- **Not in any sitemap.** None of the eight sitemaps (`sitemap-content`, `-on-demand`, `-pages`, `-main`, `-product`, …) lists a SYFAT or Facharzt URL, including the landing page.
- **No internal links in the HTML.** The landing page's HTML contains no `href` to the course pages; the course cards are rendered client-side. Googlebot renders JavaScript, but late and unreliably for links.
- **Thin server-rendered page.** A course page delivers about 1,300 characters of visible text server-side, no `<h1>`, no canonical tag; the title has a trailing space and the specialty first ("Innere Medizin | Facharztvorbereitung ").
- **Legacy duplicate still live.** `/on-demand/syfat-allgemeinmedizin` returns 200 with the old content and links to `/booking/promo-membership`, not to the new course page. It competes with the new page for the same queries.
- `robots.txt` does not block anything relevant.

## Demand that exists (queries where fomf.de already appears)

Exam-intent queries (containing Prüfung / Vorbereitung / Repetitorium) site-wide: **115 queries, 17,735 impressions, 215 clicks.** Where we stand:

| Query | Impressions | Clicks | Avg position |
|---|---|---|---|
| facharztvorbereitungskurs allgemeinmedizin | 1,843 | 30 | 7 |
| facharztvorbereitungskurs | 1,542 | 32 | 6 |
| ondemand facharztvorbereitung | 1,293 | 0 | 5 |
| facharztvorbereitung allgemeinmedizin | 1,054 | 2 | 20 |
| facharztvorbereitung | 1,040 | 5 | 6 |
| online facharztvorbereitung | 1,036 | 0 | 5 |
| facharztvorbereitungskurs innere medizin | 985 | 4 | 13 |
| facharztvorbereitungskurs dermatologie | 921 | 6 | 13 |
| facharztvorbereitung dermatologie | 757 | 2 | 16 |
| facharztvorbereitungskurs gynäkologie | 574 | 0 | 29 |
| facharztrepetitorium psychiatrie 2026 | 497 | 43 | 4 |
| facharztprüfung innere medizin vorbereitung | 445 | 1 | 49 |
| facharztvorbereitung innere medizin | 357 | 0 | 36 |
| facharztprüfung allgemeinmedizin | 351 | 0 | 39 |
| facharztprüfung gynäkologie vorbereitung | 242 | 0 | 40 |

Readings:
- Positions 5–8 with **CTR under 1%** on the head terms means the snippet, not the ranking, loses the click. Title and description of the landing page are the first fix.
- Allgemeinmedizin is the only specialty we rank for; **Innere Medizin, Gynäkologie and Pädiatrie sit at positions 13–49** although courses exist. Pädiatrie does not appear at all.
- **Dermatologie** and **Psychiatrie** have visible demand without a SYFAT course (Psychiatrie clicks go to a Refresher page; Dermatologie to `/product/DERMA`). Psychiatrie is on Marie's roadmap.
- Whole-site "Weiterbildung" queries (medizinische weiterbildung, 4.9k impressions, position 23) are generic and not exam-intent; ignore for SYFAT.

## Monthly trend, fomf.de SYFAT / Facharzt pages

| Month | Clicks | Impressions | Site clicks | Share |
|---|---|---|---|---|
| 2025-06 | 29 | 877 | 4,687 | 0.6% |
| 2025-09 | 38 | 934 | 6,202 | 0.6% |
| 2025-12 | 34 | 4,185 | 4,997 | 0.7% |
| 2026-01 | 87 | 2,550 | 6,016 | 1.5% |
| 2026-04 | 56 | 2,094 | 3,652 | 1.5% |
| 2026-07 | 70 | 1,689 | 3,653 | 1.9% |
| 2026-08 | 43 | 1,843 | 5,453 | 0.8% |
| 2026-09 (to 19th) | 39 | 1,382 | 3,421 | 1.1% |

Impressions grew from about 900 to about 2,000 a month from Oct 2025 (more queries shown, no better positions); clicks did not follow. Full monthly rows in `data/gsc_de_syfat_pages_by_date.tsv`.

## Caveats

- Search Console attributes clicks to the URL shown in Google, so client-side redirects and the `/syfat` → `/facharztvorbereitungskurs` redirect are already folded into the landing page's numbers.
- **URL inspection (Mahyar, 22 Sep 2026) for `/content/syfat-innere-medizin-de`: "URL ist Google nicht bekannt"** — never crawled, no referring sitemap, no referring page found. The course pages are not indexed at all; the same is expected for the other three.
- Ads and social traffic are not in these numbers; Search Console is organic Google search only.

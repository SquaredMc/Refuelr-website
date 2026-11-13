# Refuelr-website

The NearEmpty marketing site (the app was called Refuelr until 1.1): homepage, Privacy Policy, Terms of Use and Support page. The homepage, header and footer follow the Claude Design mockup ("Homepage — 1440"); the legal pages keep the layout of the [Netti website](https://github.com/SquaredMc/Netti-website). Colours and fonts come from the NearEmpty app (`src/theme/index.js` in [SquaredMc/NearEmpty](https://github.com/SquaredMc/NearEmpty)).

**Live:** https://squaredmc.com/nearempty/ (served by the SquaredMc website repo; see Deploy)

These pages double as the App Store Connect URLs:

| App Store Connect field | URL |
|---|---|
| Marketing URL | https://squaredmc.com/nearempty/ |
| Support URL | https://squaredmc.com/nearempty/support.html |
| Privacy Policy URL | https://squaredmc.com/nearempty/privacy.html |

The old `squaredmc.com/refuelr/` pages redirect to these.

## Structure

Plain HTML and CSS with a little vanilla JS (the mobile menu and the hero map's price pins). There's no framework and no build step.

```
index.html        Homepage (hero, why, how it works, pricing, FAQ, about, download)
privacy.html      Privacy Policy
terms.html        Terms of Use
support.html      Support page
404.html          Not-found page, served by GitHub Pages for any missing path (links resolve via <base>)
css/tokens.css    Design tokens (app colours and fonts, plus the homepage design's extra colours)
css/styles.css    Styles: shared base, header and footer, homepage sections, legal pages
js/main.js        Mobile menu, and the price pins on the hero map
assets/icons/     logo.svg (NearEmpty pin + wordmark, built from the app's assets/brand), app-icon.png,
                  favicon-32.png, favicon-192.png, apple-touch-icon.png (all from the app's assets/icon.png)
assets/screenshots/  1-car-setup, 2-prices, 3-map: the app screens in How it works
assets/og-image.png  1200×630 social preview (logo, headline and the Prices screen)
app-ads.txt       AdMob seller verification (same SquaredMc publisher ID as Netti)
sitemap.xml, .nojekyll
scripts/copy-to-squaredmc.sh  Copies the site into the SquaredMc website repo for squaredmc.com/nearempty/
```

The FAQ uses native `<details>`/`<summary>`. If you change a question or answer, update the matching `FAQPage` JSON-LD in the `<head>` of `index.html` too.

"How it works" uses real screenshots of NearEmpty 1.1 (`assets/screenshots/`, taken in the iOS Simulator and saved at 720px wide); the other illustrations are drawn in HTML and SVG. The hero map is an SVG tilted with a CSS perspective transform (`.hero-map` in `styles.css`); `js/main.js` projects each price pin through the same perspective, so if you change one, change the other to match. All prices on the homepage are illustrative.

## Preview locally

```bash
python3 -m http.server 8765
```

Then open http://localhost:8765.

## Deploy

squaredmc.com is one GitHub Pages site, built from the SquaredMc website repo, and this site lives in its `public/nearempty/` folder. To publish a change here, copy it across and push that repo:

```bash
scripts/copy-to-squaredmc.sh ../SquaredMc-website
```

All the absolute URLs (canonical, Open Graph, JSON-LD, sitemap) point at `https://squaredmc.com/nearempty/`, and `404.html` uses `<base href="/nearempty/">` because squaredmc.com's root 404 page hands misses under `/nearempty/` to it.

This repo also still publishes itself to GitHub Pages at `squaredmc.github.io/Refuelr-website/`; its canonical tags point search engines at squaredmc.com.

## Still to do

- **Server log retention**: replace the two `[N]` placeholders in `privacy.html` (search for `class="todo"`) with your Supabase plan's log retention in days.
- **App Store**: NearEmpty is live at https://apps.apple.com/gb/app/nearempty/id6796394766 (App Store ID 6796394766). The hero and the download card use Apple's official black badge (`assets/icons/app-store-badge.svg`, unmodified from developer.apple.com; keep it at least 40px tall), and the content pages carry the `apple-itunes-app` Smart App Banner tag.
- **Legal review**: `privacy.html` and `terms.html` were drafted with AI assistance. Have a solicitor review them before launch.
- **Last updated** dates on the legal pages should match the publish date.

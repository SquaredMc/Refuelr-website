# Refuelr-website

The Refuelr marketing site: homepage, Privacy Policy, Terms of Use and Support page. The homepage, header and footer follow the Claude Design mockup ("Homepage — 1440"); the legal pages keep the layout of the [Netti website](https://github.com/SquaredMc/Netti-website). Colours and fonts come from the Refuelr app (`src/theme/index.js` in [SquaredMc/Refuelr](https://github.com/SquaredMc/Refuelr)).

**Preview:** https://squaredmc.github.io/Refuelr-website/ (not indexed by search engines yet)

Once the domain is set, these pages double as the App Store Connect URLs:

| App Store Connect field | Page |
|---|---|
| Marketing URL | `/` |
| Support URL | `/support.html` |
| Privacy Policy URL | `/privacy.html` |

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
assets/icons/     logo.png, logo-white.svg, app-icon.png, favicon.svg, favicon-32.png, apple-touch-icon.png
assets/og-image.png  1200×630 social preview
app-ads.txt       AdMob seller verification (same SquaredMc publisher ID as Netti)
robots.txt, sitemap.xml, .nojekyll
```

The FAQ uses native `<details>`/`<summary>`. If you change a question or answer, update the matching `FAQPage` JSON-LD in the `<head>` of `index.html` too.

The app screens in "How it works" and the other illustrations are drawn in HTML and SVG, not screenshots. The hero map is an SVG tilted with a CSS perspective transform (`.hero-map` in `styles.css`); `js/main.js` projects each price pin through the same perspective, so if you change one, change the other to match. All prices on the homepage are illustrative.

## Preview locally

```bash
python3 -m http.server 8765
```

Then open http://localhost:8765.

## Deploy

GitHub Pages serves the root of `main`. Pushing to `main` publishes the site.

## Before launch

- **Domain**: absolute URLs (canonical, Open Graph, sitemap, robots) currently point at the GitHub Pages preview. When the domain is chosen, replace them, add a `CNAME` file containing the domain, and change `<base href="/Refuelr-website/">` in `404.html` to `<base href="/">`:
  ```bash
  grep -rl 'squaredmc.github.io/Refuelr-website' --include='*.html' --include='*.xml' --include='*.txt' . | xargs sed -i '' 's#squaredmc.github.io/Refuelr-website#NEW-DOMAIN#g'
  ```
- **Search indexing**: remove the `<meta name="robots" content="noindex">` preview tag from `index.html`, `privacy.html`, `terms.html` and `support.html`.
- **Server log retention**: replace the two `[N]` placeholders in `privacy.html` (search for `class="todo"`) with your Supabase plan's log retention in days.
- **App Store badge**: Apple's rules only allow its badge for apps that are on the App Store, so the site shows a plain "Coming soon to the App Store" button for now. Apple's official black badge is already in `assets/icons/app-store-badge.svg` (downloaded unmodified from developer.apple.com). At launch, swap the two "Coming soon to the App Store" buttons in `index.html` (in the hero and the download card) for the commented-out badge link above each one, put in the App Store ID, and uncomment the `apple-itunes-app` meta tag. Don't edit the badge artwork, and keep it at least 40px tall.
- **Legal review**: `privacy.html` and `terms.html` were drafted with AI assistance. Have a solicitor review them before launch.
- **Last updated** dates on the legal pages should match the publish date.

# Refuelr-website

The Refuelr marketing site: homepage, Privacy Policy, Terms of Use and Support page. Its layout, structure and components mirror the [Netti website](https://github.com/SquaredMc/Netti-website), and its colours and fonts come from the Refuelr app (`src/theme/index.js` in [SquaredMc/Refuelr](https://github.com/SquaredMc/Refuelr)).

**Preview:** https://squaredmc.github.io/Refuelr-website/ (not indexed by search engines yet)

Once the domain is set, these pages double as the App Store Connect URLs:

| App Store Connect field | Page |
|---|---|
| Marketing URL | `/` |
| Support URL | `/support.html` |
| Privacy Policy URL | `/privacy.html` |

## Structure

Plain HTML and CSS with a little vanilla JS (the mobile menu). There's no framework and no build step.

```
index.html        Homepage (hero, why, how it works, worked example, free, FAQ, download, about)
privacy.html      Privacy Policy
terms.html        Terms of Use
support.html      Support page
404.html          Not-found page, served by GitHub Pages for any missing path (links resolve via <base>)
css/tokens.css    Design tokens (app colours and fonts, Netti spacing and type scale)
css/styles.css    Styles, ported from the Netti site
js/main.js        Mobile menu
assets/icons/     logo.svg, logo-white.svg, favicon.svg, favicon-32.png, apple-touch-icon.png
assets/screenshots/  hero.png and step-1/2/3 screenshots, taken from the app in the iOS Simulator
assets/og-image.png  1200×630 social preview
app-ads.txt       AdMob seller verification (same SquaredMc publisher ID as Netti)
robots.txt, sitemap.xml, .nojekyll
```

The FAQ uses native `<details>`/`<summary>`. If you change a question or answer, update the matching `FAQPage` JSON-LD in the `<head>` of `index.html` too.

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
- **App Store badge**: Apple's rules only allow its badge for apps that are on the App Store, so the site shows a plain "Coming soon to the App Store" button for now. Apple's official black badge is already in `assets/icons/app-store-badge.svg` (downloaded unmodified from developer.apple.com). At launch, swap the two `coming-soon` spans in `index.html` for the commented-out badge link above each one, put in the App Store ID, and uncomment the `apple-itunes-app` meta tag. Don't edit the badge artwork, and keep it at least 40px tall.
- **Legal review**: `privacy.html` and `terms.html` were drafted with AI assistance. Have a solicitor review them before launch.
- **Last updated** dates on the legal pages should match the publish date.

# D-Modules 2026 — Svelte SPA

A small Svelte single-page app for the workshop site. Hash-based routing via
`svelte-spa-router`; each non-home page renders a markdown file from
`public/content/`.

## Branches

- **Dev** — source (this branch). Svelte source, build config, scripts.
- **Dist** — published artifacts (`index.html`, `assets/`, `content/`).
  Served by GitHub Pages. Content files (`content/*.md`) may be edited
  directly on this branch via the GitHub web UI; the publish script
  preserves them.

## Getting started

```sh
npm install               # use --legacy-peer-deps if it complains
npm run dev               # local dev server with HMR
npm run build             # production build into target/
npm run build:scss        # rebuild css/custom.css from scss/custom.scss
```

The dev server serves the app at `http://localhost:5173`. The production
build lands in `target/` (gitignored on Dev — it's published to Dist by the
`scripts/publish.sh` script).

## Adding a new page

A page lives in three places in the source plus one content file. Say you
want to add a page at `/sponsors`:

1. **Content** — create `public/content/sponsors.md` with the page text
   (standard Markdown).
2. **Route** — in [src/App.svelte](src/App.svelte), add the path to the
   `routes` map:

   ```js
   '/sponsors': Page,
   ```

3. **Nav link** — in
   [src/components/Navbar.svelte](src/components/Navbar.svelte), add an entry
   to the `links` array:

   ```js
   { path: '/sponsors', label: 'Sponsors' }
   ```

4. **Content mapping** — in
   [src/components/Page.svelte](src/components/Page.svelte), tell `Page`
   which file to fetch for that route:

   ```js
   '/sponsors': '/content/sponsors.md',
   ```

That's it. The `Home` page has its own component
([src/pages/Home.svelte](src/pages/Home.svelte)); every other page reuses
the generic `Page` component, which fetches and renders the markdown.

If a page's content is just an `<iframe>` (e.g. a Google Form for
registration), `Page` detects this and renders the iframe directly instead
of running it through the markdown parser.

## Publishing to the live site

The live site is whatever is on the `Dist` branch. To publish:

```sh
scripts/publish.sh
```

This:

1. Runs `npm run build` to produce `target/`.
2. Checks out `Dist` into a temporary worktree.
3. Replaces `index.html` and `assets/` on `Dist` with the freshly built
   ones.
4. Leaves `content/*.md` on `Dist` alone (so program abstracts, speaker
   lists, etc. that were edited directly on Dist are preserved).
5. Commits the change on the local `Dist` branch with a message that
   records the source commit.

The script does **not** push. After it finishes, review the commit and
push it yourself:

```sh
git log Dist -1 --stat   # review what's about to go live
git push origin Dist     # publish
```

Run the script from `Dev` (or any branch that has the Svelte source). It
builds from your current working tree, so commit your changes on `Dev`
first if you want them to make it into the publish. It exits cleanly with
a no-op message if nothing actually changed.

### Editing content without rebuilding

Because `Dist` owns the content files in production, small text fixes
(typos in abstracts, schedule tweaks, etc.) can be made by editing
`content/<page>.md` directly on the `Dist` branch through GitHub's web UI.
No build needed.

Note that `public/content/*.md` on `Dev` can drift from `Dist`. If you want
Dev to be authoritative again, copy the latest `content/*.md` from `Dist`
back into `public/content/` and commit on Dev.

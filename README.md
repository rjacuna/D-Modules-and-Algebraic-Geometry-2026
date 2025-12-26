# D-Modules 2026 — Svelte SPA (work in progress)

This repo now contains a Svelte single-page app that mirrors the original site pages.

Getting started

1. Install deps:

   npm install

2. Build SCSS (compiles `scss/custom.scss` -> `css/custom.css`):

   npm run build:scss

3. Run dev server:

   npm run dev

Notes

- The original static site is archived in `archived_static/` (scheduled for deletion); it includes the old page HTML and `js/custom.js`.
- Navbar and pages are in `src/components` and `src/pages` respectively.
- Bootstrap JS is imported in `src/main.js` and the compiled `css/custom.css` is used for styling.

Archived files (scheduled for deletion):
- archived_static/index.static.html
- archived_static/speakers.html
- archived_static/schedule.html
- archived_static/program.html
- archived_static/information.html
- archived_static/visa.html
- archived_static/registration.html
- archived_static/js/custom.js

If you'd like to delete these permanently, tell me and I will remove them from the repository.

import { defineConfig } from 'vite'
import { svelte } from '@sveltejs/vite-plugin-svelte'

export default defineConfig({
  base: '/D-Modules-and-Algebraic-Geometry-2026/',
  plugins: [svelte()],
  server: {
    open: false
  },
  build: {
    outDir: 'dist',
    emptyOutDir: true,
    assetsDir: 'assets',
    rollupOptions: {
      input: './index.html'
    }
  }
})
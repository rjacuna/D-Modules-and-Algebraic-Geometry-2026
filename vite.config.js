import { defineConfig } from 'vite'
import { svelte } from '@sveltejs/vite-plugin-svelte'

export default defineConfig({
  plugins: [svelte()],
  base: './',
  server: {
    open: false
  },
  build: {
    outDir: 'target',
    emptyOutDir: true,
    assetsDir: 'assets',
    rollupOptions: {
      input: './index.html'
    }
  }
})
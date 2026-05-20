import App from './App.svelte'
import 'bootstrap/dist/js/bootstrap.bundle'
import 'katex/dist/katex.min.css'
import { marked } from 'marked'
import markedKatex from 'marked-katex-extension'
import { markedSmartypants } from 'marked-smartypants'

// nonStandard: true makes single-dollar `$...$` inline math work in addition
// to display `$$...$$`. Without it, only display math renders.
marked.use(markedKatex({ throwOnError: false, nonStandard: true }))
marked.use(markedSmartypants())

const app = new App({
  target: document.getElementById('app')
})

export default app
import App from './App.svelte'
import 'bootstrap/dist/js/bootstrap.bundle'
import 'katex/dist/katex.min.css'
import { marked } from 'marked'
import markedKatex from 'marked-katex-extension'

marked.use(markedKatex({ throwOnError: false }))

const app = new App({
  target: document.getElementById('app')
})

export default app
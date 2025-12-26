<script>
  import { location } from 'svelte-spa-router'
  import { onMount } from 'svelte'
  import { marked } from 'marked'

  // Disable deprecated behaviors (see marked docs)
  marked.setOptions({ mangle: false, headerIds: false })

  // Map routes to markdown filenames under content/
  const routeToFile = {
    '/speakers': '/content/speakers.md',
    '/schedule': '/content/schedule.md',
    '/program': '/content/program.md',
    '/information': '/content/information.md',
    '/visa': '/content/visa.md',
    '/registration': '/content/registration.md'
  }

  let html = '<p>Loading...</p>'
  let article;

  $: path = $location || '/'

  async function fetchMarkdown(pathname) {
    try {
      const res = await fetch(pathname)
      if (!res.ok) return null
      return await res.text()
    } catch (err) {
      return null
    }
  }

  async function loadForPath(p) {
    const file = routeToFile[p]
    if (!file) {
      html = '<p>Not found</p>'
      return
    }
    const md = await fetchMarkdown(file)
    if (!md) {
      html = '<p>Content not available</p>'
      return
    }
    // Check if the content is just an iframe (with optional whitespace)
    const iframeMatch = md.trim().match(/^<iframe[\s\S]*<\/iframe>$/i)
    if (iframeMatch && md.trim().replace(/\n/g, '').replace(/\s+/g, ' ').startsWith('<iframe')) {
      html = md.trim()
    } else {
      html = marked.parse(md)
    }
  }

  $: loadForPath(path)
</script>

<section class="container mt-4">
  <div class="">
    <article class="markdown-body" bind:this={article}>
      {@html html}
    </article>
  </div>
</section>
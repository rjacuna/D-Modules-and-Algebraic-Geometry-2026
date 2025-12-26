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
    '/information': '/content/information.md',
    '/visa': '/content/visa.md',
    '/registration': '/content/registration.md'
  }

  let html = '<p>Loading...</p>'
  let article;
  let isIframe = false;
  let iframeLoaded = false;

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

  // Helper to extract src from iframe HTML string
  function getIframeSrc(html) {
    const match = html.match(/src=["']([^"']+)["']/i)
    return match ? match[1] : ''
  }

  async function loadForPath(p) {
    const file = routeToFile[p]
    isIframe = false;
    iframeLoaded = false;
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
      isIframe = true;
      html = md.trim()
    } else {
      html = marked.parse(md)
    }
  }

  $: loadForPath(path)
</script>

<section class="container mt-4">
  <div class="">
    {#if isIframe}
      {#if !iframeLoaded}
        <div class="progress my-3" style="height: 6px;">
          <div class="progress-bar progress-bar-striped progress-bar-animated" style="width: 100%"></div>
        </div>
      {/if}
      <article class="markdown-body" bind:this={article}>
        <iframe
          src={getIframeSrc(html)}
          width="640"
          height="1154"
          frameborder="0"
          marginheight="0"
          marginwidth="0"
          style="width:100%;min-height:600px;"
          on:load={() => { iframeLoaded = true; }}
          title="Registration form"
        >Loading…</iframe>
      </article>
    {:else}
      <article class="markdown-body" bind:this={article}>
        {@html html}
      </article>
    {/if}
  </div>
</section>
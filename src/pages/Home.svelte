<script>
  import { onMount, onDestroy } from 'svelte'
  import { marked } from 'marked'

  // Disable deprecated marked behaviors used elsewhere (silences warnings)
  marked.setOptions({ mangle: false, headerIds: false })

  let titleHtml = ''
  let organizersHtml = ''
  let datesHtml = ''
  let locationHtml = ''
  let descriptionHtml = ''

  async function fetchMd(path) {
    try {
      const res = await fetch(path)
      if (!res.ok) return null
      return await res.text()
    } catch (err) {
      return null
    }
  }

  onMount(async () => {
    document.body.classList.add('home-bg')

    const [titleMd, organizersMd, datesMd, locationMd, descriptionMd] = await Promise.all([
      fetchMd('/content/title.md'),
      fetchMd('/content/organizers.md'),
      fetchMd('/content/dates.md'),
      fetchMd('/content/location.md'),
      fetchMd('/content/description.md')
    ])

    titleHtml = titleMd ? marked.parse(titleMd) : ''
    organizersHtml = organizersMd ? marked.parse(organizersMd) : ''
    datesHtml = datesMd ? marked.parse(datesMd) : ''
    locationHtml = locationMd ? marked.parse(locationMd) : ''
    descriptionHtml = descriptionMd ? marked.parse(descriptionMd) : ''
  })

  onDestroy(() => {
    document.body.classList.remove('home-bg')
  })
</script>

<section class="container">
  <div class="bg-pill rounded-3 d-inline-block px-4 py-2 mb-4">
    <h4 class="display-4 mb-0">{@html titleHtml}</h4>
  </div>
  <div class="bg-pill p-4 rounded-3 mt-4">
    <dl class="row">
      <dt class="col-sm-3">Organizers</dt>
      <dd class="col-sm-9">{@html organizersHtml}</dd>

      <dt class="col-sm-3">Dates</dt>
      <dd class="col-sm-9">{@html datesHtml}</dd>

      <dt class="col-sm-3">Location</dt>
      <dd class="col-sm-9">{@html locationHtml}</dd>

      <dt class="col-sm-3">Description</dt>
      <dd class="col-sm-9">{@html descriptionHtml}</dd>
    </dl>
  </div>
</section>
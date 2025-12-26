<script>
  import { onMount, onDestroy } from 'svelte'
  import { marked } from 'marked'

  import titleMd from '/content/title.md?raw'
  import organizersMd from '/content/organizers.md?raw'
  import datesMd from '/content/dates.md?raw'
  import locationMd from '/content/location.md?raw'
  import descriptionMd from '/content/description.md?raw'

  let titleHtml = marked.parse(titleMd)
  let organizersHtml = marked.parse(organizersMd)
  let datesHtml = marked.parse(datesMd)
  let locationHtml = marked.parse(locationMd)
  let descriptionHtml = marked.parse(descriptionMd)

  onMount(() => {
    document.body.classList.add('home-bg')
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
<script>
  import { onMount, onDestroy } from 'svelte'

  onMount(() => {
    document.body.classList.add('home-bg')
  })

  onDestroy(() => {
    document.body.classList.remove('home-bg')
  })
</script>

<section class="container">
  <div class="bg-pill rounded-3 d-inline-block px-4 py-2 mb-4">
    <h4 class="display-4 mb-0">D-Modules and Algebraic Geometry Workshop 2026</h4>
  </div>
  <div class="bg-pill p-4 rounded-3 mt-4">
    <dl class="row">
      <dt class="col-sm-3">Organizers</dt>
      <dd class="col-sm-9">RJ Acuña, Thomas Bitoun, and Mingyi Zhang</dd>

      <dt class="col-sm-3">Dates</dt>
      <dd class="col-sm-9">June 1–5, 2026</dd>

      <dt class="col-sm-3">Location</dt>
      <dd class="col-sm-9">Shanghai Institute for Mathematics and Interdisciplinary Sciences (<a href="https://www.simis.cn">www.simis.cn</a>)</dd>

      <dt class="col-sm-3">Description</dt>
      <dd class="col-sm-9">This workshop brings together leading international researchers to discuss recent advances in applications of D-module theory to algebraic geometry, with a focus on singular support.</dd>
    </dl>
  </div>
</section>
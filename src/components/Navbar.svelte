<script>
  import { location } from 'svelte-spa-router'

  const links = [
    { path: '/', label: 'Home' },
    { path: '/speakers', label: 'Speakers' },
    { path: '/schedule', label: 'Schedule' },
    { path: '/program', label: 'Program' },
    { path: '/information', label: 'Information' },
    { path: '/visa', label: 'Visa' },
    { path: '/registration', label: 'Registration' }
  ]

  $: current = $location || '/'
  const isActive = (p) => p === current
</script>

<nav class="navbar navbar-expand-lg navbar-light bg-light shadow-sm">
  <div class="container-fluid">
    <a class="navbar-brand ms-5" href="#/">D-Modules 2026</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav ms-auto">
        {#each links as l}
          <li class="nav-item">
            <a
              class="nav-link"
              class:active={isActive(l.path)}
              href={"#" + l.path}
              aria-current={isActive(l.path) ? 'page' : undefined}
            >{l.label}</a>
          </li>
        {/each}
      </ul>
    </div>
  </div>
</nav>

<style>
  .navbar {
    box-shadow: 0 4px 12px rgba(0,0,0,0.15);
  }
  .navbar .nav-link { font-weight: 700; }
  .navbar .nav-link.active { color: var(--bs-navbar-active-color); }
  /* Ensure brand appears neatly on the right */
  .navbar .navbar-brand { margin-left: .5rem; }
</style>
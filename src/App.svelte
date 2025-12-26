<script>
  import Router from 'svelte-spa-router'
  import Navbar from './components/Navbar.svelte'
  import Home from './pages/Home.svelte'
  import Page from './components/Page.svelte'

  const routes = {
    '/': Home,
    '/speakers': Page,
    '/schedule': Page,
    '/information': Page,
    '/visa': Page,
    '/registration': Page
  }
</script>

<Navbar />
<main>
  <Router {routes} />
</main>

<style>
  main {
    padding-top: 1rem;
  }
</style>
<script>
  import Router from 'svelte-spa-router'
  import Navbar from './components/Navbar.svelte'
  import Home from './pages/Home.svelte'
  import Speakers from './pages/Speakers.svelte'
  import Schedule from './pages/Schedule.svelte'
  import Program from './pages/Program.svelte'
  import Information from './pages/Information.svelte'
  import Visa from './pages/Visa.svelte'
  import Registration from './pages/Registration.svelte'

  const routes = {
    '/': Home,
    '/speakers': Speakers,
    '/schedule': Schedule,
    '/program': Program,
    '/information': Information,
    '/visa': Visa,
    '/registration': Registration
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
<!-- App.svelte -->
<script>
    import { currentPage } from './store';

    import Toasts from './parts/Toasts.svelte';

    import Login from './routes/Login.svelte';
    import Create from './routes/Create.svelte';
    import Game from './routes/Game.svelte';
</script>

{#if $currentPage === 'login'}<Login />{/if}
{#if $currentPage === 'create'}<Create />{/if}
{#if $currentPage === 'game'}<Game />{/if}
<!-- Add the toast messages to all pages -->
<Toasts />
<!-- App.svelte -->
<script>
    import { currentPage } from './store';

    import Toasts from './components/Toasts.svelte';


    import Login from './routes/Login.svelte';
    import Create from './routes/Create.svelte';
</script>

{#if $currentPage === 'login'}
    <Login />
{:else if $currentPage === 'create'}
    <Create />
{/if}

<!-- Add the toast messages to all pages -->
<Toasts />
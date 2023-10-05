<!-- Toasts.svelte -->
<script>
    import { fade } from 'svelte/transition';
    import { dismissToast, toasts } from '../store';

    // Types: info, success, warning, error
</script>

{#if $toasts}
    <div class="toast toast-top toast-center">
        {#each $toasts as toast (toast.id)}
            <div class="alert alert-{toast.type}" transition:fade>
                {toast.message}
                {#if toast.dismissible}
                    <button on:click={() => dismissToast(toast.id)}>X</button>
                {/if}
            </div>
        {/each}
    </div>
{/if}
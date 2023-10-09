<!-- Toasts.svelte -->
<script>
    import { fade } from 'svelte/transition';
    import { dismissToast, toasts } from '../store';

    // Types: info, success, warning, error
</script>

{#if $toasts}
    <div class="toast toast-top toast-center">
        {#each $toasts as toast (toast.id)}
            {#if toast.type === 'info'}
                <div class="alert alert-info" transition:fade>
                    {toast.message}
                    {#if toast.dismissible}
                        <button on:click={() => dismissToast(toast.id)}>X</button>
                    {/if}
                </div>
            {/if}
            {#if toast.type === 'success'}
                <div class="alert alert-success" transition:fade>
                    {toast.message}
                    {#if toast.dismissible}
                        <button on:click={() => dismissToast(toast.id)}>X</button>
                    {/if}
                </div>
            {/if}
            {#if toast.type === 'warning'}
                <div class="alert alert-warning" transition:fade>
                    {toast.message}
                    {#if toast.dismissible}
                        <button on:click={() => dismissToast(toast.id)}>X</button>
                    {/if}
                </div>
            {/if}
            {#if toast.type === 'error'}
                <div class="alert alert-error" transition:fade>
                    {toast.message}
                    {#if toast.dismissible}
                        <button on:click={() => dismissToast(toast.id)}>X</button>
                    {/if}
                </div>
            {/if}
        {/each}
    </div>
{/if}
import { writable } from 'svelte/store';

export let serverAddress = 'http://10.0.0.102:81';
export let currentPage = writable('login');
export const toasts = writable([]);


export function setPage(page) {
    currentPage.set(page);
}

export const dismissToast = (id) => {
    toasts.update((all) => all.filter((t) => t.id !== id));
};

export const addToast = (toast) => {
    // Create a unique ID so we can easily find/remove it
    // if it is dismissible/has a timeout.
    const id = Math.floor(Math.random() * 10000);
    
    // Setup some sensible defaults for a toast.
    const defaults = {
        id,
        type: "info",
        dismissible: true,
        timeout: 5000,
    };

    // Merge the provided toast with the defaults
    const mergedToast = { ...defaults, ...toast };

    // Push the toast to the top of the list of toasts
    toasts.update((all) => [mergedToast, ...all]);

    // If toast is dismissible, dismiss it after "timeout" amount of time.
    if (mergedToast.timeout) {
        setTimeout(() => dismissToast(id), mergedToast.timeout);
    }
};

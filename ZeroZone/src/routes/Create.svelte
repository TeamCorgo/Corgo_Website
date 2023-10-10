<!-- Create.svelte -->
<script>
    import { onMount } from 'svelte';
    import { setPage, addToast, serverAddress } from '../store';

    let isLoading = false;
    let username;
    let password;    
    onMount(() => {
        document.title = 'ZeroZone | Create User';

        // Remove the item if it exists
        if (localStorage.getItem('JWT_Access')) {
            localStorage.removeItem('JWT_Access');
        }
    });

    async function handleSubmit(event) {
        event.preventDefault();
        if (isLoading) return; // Prevent multiple requests while one is in progress
        isLoading = true; // Ok function is now loading, set the lock out

        const formData = { 
            username: username, 
            password: password,
        }

        fetch(serverAddress + '/accounts/create', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(formData),
        })
        .then(response => {
            response.json().then(data => {
                // Check for manual warnings from FastAPI
                if (data.warning) {
                    console.log('Warning found')
                    console.log(data.warning);
                    addToast({ type: 'warning', message: data.warning });
                    isLoading = false;
                }
                // Check for manual errors from FastAPI
                if (data.error) {
                    console.log('Error found')
                    console.log(data.error);
                    addToast({ type: 'error', message: data.error });
                    isLoading = false;
                }
                // No errors, time to party
                if (isLoading === true) {
                    //console.log(data);
                    // Set the browser local storage for the JWT
                    localStorage.setItem('JWT_Access', data.access_token);
                    addToast({ type: 'success', message: 'Logged in' });
                    isLoading = false;
                    // redirect to new page TODO
                }
            });
        })
        .catch(error => {
            // Handle Server Errors
            console.error('Error:', error);
            addToast({ type: 'error', message: error.message });
            setPage('create');
            isLoading = false;
        });
    }
</script>

<body class="bg-gray-100 flex items-center justify-center h-screen">
    <div class="bg-white p-8 rounded-lg shadow-md w-96">
        <h1 class="text-2xl font-semibold mb-6">Create a ZeroZone account</h1>
        {#if username}
            <div class="avatar flex items-center justify-center">
                <div class="w-24 rounded-full ring ring-primary ring-offset-base-100 ring-offset-2">
                    <img src="https://api.dicebear.com/7.x/avataaars/svg?seed={username}" alt="Avatar" />
                </div>
            </div>
        {/if}
        <form on:submit={handleSubmit}>
            <div class="mb-4">
                <label for="username" class="block text-gray-700 font-medium mb-2">Username</label>
                <input type="text" id="username" bind:value={username} required class="w-full p-2 border border-gray-300 rounded-lg focus:outline-none focus:border-blue-400" placeholder="Enter username">
            </div>
            <div class="mb-4">
                <label for="password" class="block text-gray-700 font-medium mb-2">Password</label>
                <input type="password" id="password" bind:value={password} required class="w-full p-2 border border-gray-300 rounded-lg focus:outline-none focus:border-blue-400" placeholder="Enter password">
            </div>
            <div class="mb-4">
                <button type="submit" class="w-full btn btn-success">Create an account</button>
            </div>
            <!-- svelte-ignore a11y-click-events-have-key-events -->
            <span on:click={() => setPage('login')} class="text-blue-500 hover:underline cursor-pointer">Log into an existing account</span>
        </form>
    </div>
</body>  
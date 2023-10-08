<!-- Login.svelte -->
<script>
    import { onMount } from 'svelte';
    import { setPage, addToast, serverAddress } from '../store';

    let isLoading = false;
    let username;
    let password;    
    onMount(() => {
        document.title = 'ZeroZone | Login';

        // Remove the item if it exists
        if (localStorage.getItem('JWT_Access')) {
            localStorage.removeItem('JWT_Access');
        }
    });

    async function handleSubmit(event) {
        event.preventDefault();
        if (isLoading) return; // Prevent multiple requests while one is in progress
        isLoading = true; // Ok function is now loading, set the lock out
        const formData = new URLSearchParams();
        formData.append('username', username);
        formData.append('password', password);

        fetch(serverAddress + '/accounts/login', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: formData.toString(),
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
                    setPage('game');
                    isLoading = false;
                }
            });
        })
        .catch(error => {
            // Handle Server Errors
            console.error('Error:', error);
            addToast({ type: 'error', message: error.message });
            setPage('login');
            isLoading = false;
        });
    }
</script>

<body class="bg-gray-100 flex items-center justify-center h-screen">
    <div class="bg-white p-8 rounded-lg shadow-md w-96">
        <h1 class="text-2xl font-semibold mb-6">Login into an account</h1>
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
                <button type="submit" class="w-full bg-blue-500 text-white p-2 rounded-lg hover:bg-blue-600 focus:outline-none focus:bg-blue-600">
                    Log In
                </button>
            </div>
            <!-- svelte-ignore a11y-click-events-have-key-events -->
            <span on:click={() => setPage('create')} class="text-blue-500 hover:underline cursor-pointer">Create an account</span>
        </form>
    </div>
</body>
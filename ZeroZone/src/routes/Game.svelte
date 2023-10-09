<script>
    import { setPage, addToast, serverAddress } from '../store';
    import PlayerMap from '../parts/ViewMap.svelte';
    import ViewPlayer from '../parts/ViewPlayer.svelte';

    // Done with Svelte code switching to basic JS
    let dataReceived = false;
    let isLoading = false;
    let formData = {};
    let map = [];
    let player = '';


    async function refreshPage() {
        if (isLoading) return; // Prevent multiple requests while one is in progress
        isLoading = true; // Ok function is now loading, set the lock out
        dataReceived = false;
        fetch("http://localhost:81/game", {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer ' + localStorage.getItem("JWT_Access"),
            },
            body: JSON.stringify(formData)
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
                    player = data['player'];
                    map = data['map'];
                    console.log(map);
                    dataReceived = true;
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

    refreshPage();
    setInterval(refreshPage, 5000);
</script>

{#if dataReceived}
    <body class="bg-gray-100 items-center justify-center">
        <!-- Render your content using the received JSON data -->
        <PlayerMap map={map} />

        

        <!-- Add player info -->
        <ViewPlayer player={player} />


    </body>
{:else}
    <!-- Render a loading message or any other content while waiting for data -->
    <h1>Loading...</h1>
{/if}



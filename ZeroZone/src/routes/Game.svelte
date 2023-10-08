<script>
    import { setPage, addToast, serverAddress } from '../store';
    import PlayerMap from '../parts/PlayerMap.svelte';


    // Done with Svelte code switching to basic JS
    let dataReceived = false;
    let isLoading = false;
    let formData = {};
    let map = ''


    async function refreshPage() {
        if (isLoading) return; // Prevent multiple requests while one is in progress
        isLoading = true; // Ok function is now loading, set the lock out
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
</script>


{#if dataReceived}
    <!-- Render your content using the received JSON data -->
    <PlayerMap map={map} />
    <span>
        User Actions:
        <br>
        <a href="/">Log out</a>
        <br>
        <form id="user_move_up" title="Hello world!">
            <button type="submit">Move Up</button>
        </form>
        <form id="user_move_down">
            <button type="submit">Move Down</button>
        </form>
        <form id="user_move_left">
            <button type="submit">Move Left</button>
        </form>
        <form id="user_move_right">
            <button type="submit">Move Right</button>
        </form>
    </span>
{:else}
    <!-- Render a loading message or any other content while waiting for data -->
    <h1>Loading...</h1>
{/if}

<script>
    import { setPage, addToast, serverAddress, addInterval, deleteIntervals } from '../store';
    import { onMount, onDestroy } from 'svelte';
    import PlayerMap from '../parts/ViewMap.svelte';
    import ViewPlayer from '../parts/ViewPlayer.svelte';

    // Done with Svelte code switching to basic JS
    let dataReceived = false;
    let map = [];
    let player = '';
    let response;

    let error = null; // Initialize error as null


    async function updateData() {
//        if (isLoading) return; // Prevent multiple requests while one is in progress
//        isLoading = true; // Ok function is now loading, set the lock out
//        dataReceived = false;
//
//        fetch("http://localhost:81/game", {
//            method: 'POST',
//            headers: {
//                'Content-Type': 'application/json',
//                'Authorization': 'Bearer ' + localStorage.getItem("JWT_Access"),
//            },
//        })
//        .then(response => {
//            response.json().then(data => {
//                // Check for manual warnings from FastAPI
//                if (data.warning) {
//                    console.log('Warning found')
//                    console.log(data.warning);
//                    addToast({ type: 'warning', message: data.warning });
//                    isLoading = false;
//                }
//                // Check for manual errors from FastAPI
//                if (data.error) {
//                    console.log('Error found')
//                    console.log(data.error);
//                    addToast({ type: 'error', message: data.error });
//                    isLoading = false;
//                }
//                // No errors, time to party
//                if (isLoading === true) {
//                    //console.log(data);
//                    player = data['player'];
//                    map = data['map'];
//                    console.log(map);
//                    dataReceived = true;
//                    isLoading = false;
//                }
//            });
//        })
//        .catch(error => {
//            // Handle Server Errors
//            console.error('Error:', error);
//            addToast({ type: 'error', message: error.message });
//            setPage('login');
//            isLoading = false;
//        });
        //dataReceived = false;
        try {
            response = await fetch("http://localhost:81/game", {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'Authorization': 'Bearer ' + localStorage.getItem("JWT_Access"),
                },
            });
            if (!response.ok) {
                addToast({ type: 'error', message: 'URL Fetch failed'});
                setPage('login');
            }
            response = await response.json();
            dataReceived = true;
            player = response['player'];
            map = response['map'];
            console.log(response);
        } catch (err) {
            // Handle the error
            addToast({ type: 'error', message: err.message });
            setPage('login');
        }

    }

    onMount(() => {
        document.title = 'ZeroZone | Game';

        updateData();
        addInterval(setInterval(function() {updateData()}, 5000));
    });

    onDestroy(() => {
        deleteIntervals();
    });

</script>

{#if dataReceived}
    <div class="flex h-screen">
        <!-- Sidebar (left menu) -->
        <aside class="w-64">
            <!-- Add player info -->
            <ViewPlayer player={player} on:refreshParent={updateData}/>
        </aside>

        <!-- Main Content -->
        <main class="flex-1 p-4">
            <!-- Add your page content here -->
            <PlayerMap map={map} />
        </main>
    </div>
{:else}
    <!-- Render a loading message or any other content while waiting for data -->
    <h1>Loading...</h1>
{/if}



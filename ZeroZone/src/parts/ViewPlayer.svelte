<script>
	import { createEventDispatcher } from 'svelte';
    import { setPage, addToast, serverAddress, addInterval, deleteIntervals } from '../store';
	const dispatch = createEventDispatcher();
    export let player;

    async function movement(event, direction) {
        if (event){
            event.preventDefault();
        }
        fetch("http://localhost:81/move_" + direction, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer ' + localStorage.getItem("JWT_Access"),
            },
        })
        .then(response => {
            response.json().then(data => {
                //console.log('Yes');
                
                dispatch('refreshParent');
            });
        })
        .catch(error => {
            //console.log('No');
        });
    }

	function onKeyDown(event) {
	    switch(event.keyCode) {
	        case 38:
	            movement(null, 'north');
	            break;
	        case 40:
                movement(null, 'south');
	            break;
	        case 37:
                movement(null, 'west');
	            break;
	        case 39:
                movement(null, 'east');
	            break;
	    }
	}
</script>

<div class="w-full items-center justify-center">
    <div class="card items-center justify-center shadow-2xl">
        <div class="avatar items-center justify-center">
            <div class="w-24 rounded-full ring ring-primary ring-offset-base-100 ring-offset-2">
                <img src="https://api.dicebear.com/7.x/avataaars/svg?seed={player.name}" alt="Avatar" />
            </div>
        </div>
    <!-- Display who the User is signed in as -->
    <span class="font-bold">{player.name}</span>
    </div>
</div>

<br>

<div class="w-full items-center justify-center">
    <div class="card items-center justify-center shadow-2xl">
        Player Movement
        <div class="flex justify-center w-full">
            <form on:submit={(event) => movement(event, "northwest")}>
                <button type="submit" class="kbd btn">
                    <kbd>◤</kbd>
                </button>
            </form>
            <form on:submit={(event) => movement(event, "north")}>
                <button type="submit" class="kbd btn">
                    <kbd>▲</kbd>
                </button>
            </form>
            <form on:submit={(event) => movement(event, "northeast")}>
                <button type="submit" class="kbd btn">
                    <kbd>◥</kbd>
                </button>
            </form>
        </div>

        <div class="flex justify-center w-full">
            <form on:submit={(event) => movement(event, "west")}>
                <button type="submit" class="kbd btn">
                    <kbd>◀︎</kbd>
                </button>
            </form>
            <button type="submit" class="kbd btn">
                    <kbd>⊙</kbd>
            </button>
            <form on:submit={(event) => movement(event, "east")}>
                <button type="submit" class="kbd btn">
                    <kbd>▶︎</kbd>
                </button>
            </form>
        </div>

        <div class="flex justify-center w-full">
            <form on:submit={(event) => movement(event, "southwest")}>
                <button type="submit" class="kbd btn">
                    <kbd>◣</kbd>
                </button>
            </form>
            <form on:submit={(event) => (movement(event, "south"))}>
                <button type="submit" class="kbd btn">
                    <kbd>▼</kbd>
                </button>
            </form>
            <form on:submit={(event) => movement(event, "southeast")}>
                <button type="submit" class="kbd btn">
                    <kbd>◢</kbd>
                </button>
            </form>
        </div>
    </div>
</div>

<br>

<div class="w-full items-center justify-center">
    <div class="card items-center justify-center shadow-2xl">
        <button on:click={() => setPage('login')} class="btn btn-primary">Logout</button>
    </div>
</div>

<svelte:window on:keydown|preventDefault={onKeyDown} />
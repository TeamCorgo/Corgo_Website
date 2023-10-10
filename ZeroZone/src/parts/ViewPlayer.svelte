<script>
    // Declare a prop with the same name as in the parent component
    export let player;


	import { createEventDispatcher } from 'svelte';

	const dispatch = createEventDispatcher();




    async function movement(event, direction) {
        event.preventDefault();
        fetch("http://localhost:81/move_" + direction, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer ' + localStorage.getItem("JWT_Access"),
            },
        })
        .then(response => {
            response.json().then(data => {
                console.log('Yes');
                dispatch('refresh');
            });
        })
        .catch(error => {
            console.log('No');
        });
    }
</script>

<div class="items-center justify-center">
    <div class="card shadow-xl items-center justify-center">
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

<div class="items-center justify-center">
    <div class="card shadow-xl items-center justify-center">
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

<div class="items-center justify-center">
    <div class="card shadow-xl items-center justify-center">
        <span>
            Actions
            <br>
            <a href="/">Log out</a>
            <br>
            <form on:submit={(event) => movement(event, "north")}>
                <button type="submit">Move North</button>
            </form>
            <form on:submit={(event) => movement(event, "south")}>
                <button type="submit">Move South</button>
            </form>
            <form on:submit={(event) => movement(event, "west")}>
                <button type="submit">Move West</button>
            </form>
            <form on:submit={(event) => movement(event, "east")}>
                <button type="submit">Move East</button>
            </form>
        </span>
    </div>
</div>
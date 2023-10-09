<script>
    // Declare a prop with the same name as in the parent component
    export let player;
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
        Movement
        <div class="flex justify-center w-full">
            <kbd class="kbd kbd-lg">◤</kbd>
            <kbd class="kbd kbd-lg">▲</kbd>
            <kbd class="kbd kbd-lg">◥</kbd>
        </div>
        <div class="flex justify-center w-full">
            <kbd class="kbd kbd-lg">◀︎</kbd>
            <kbd class="kbd kbd-lg">X</kbd>
            <kbd class="kbd kbd-lg">▶︎</kbd>
        </div>
        <div class="flex justify-center w-full">
            <kbd class="kbd kbd-lg">◣</kbd>
            <kbd class="kbd kbd-lg">▼</kbd>
            <kbd class="kbd kbd-lg">◢</kbd>
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
    </div>
</div>
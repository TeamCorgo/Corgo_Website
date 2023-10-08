<script>
    // Declare a prop with the same name as in the parent component
    export let map;
    let arrayg = [];
    let width = Math.sqrt(map.length);

    // Reshape the flat array into a 2D array
    for (let rowIndex = 0; rowIndex < width; rowIndex++) {
        let row = [];
        for (let colIndex = 0; colIndex < width; colIndex++) {
            row.push(map[rowIndex * width + colIndex]);
        }
        arrayg.push(row);
    }
</script>




<body class="bg-gray-100 flex items-center justify-center h-screen">
    <div class="bg-white p-8 rounded-lg shadow-md w-196">
        <table>
            {#each arrayg as row}
                <tr>
                    {#each row as cell}
                        <td bgcolor="{cell['color']}">
                            {cell['name']}
                        </td>
                    {/each}
                </tr>
            {/each}
        </table>
    </div>
</body>

<style>
table, td {
    border: 1px solid black;
    border-collapse: collapse;
}
</style>

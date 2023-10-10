<script>
    // Declare a prop with the same name as in the parent component
    export let map;
    let arrayg = [];
    let width = Math.sqrt(map.length);

    // Create a reactive statement that watches for changes to the map prop
    $: {
        arrayg = [];
        width = Math.sqrt(map.length);

        // Reshape the flat array into a 2D array
        for (let rowIndex = 0; rowIndex < width; rowIndex++) {
            let row = [];
            for (let colIndex = 0; colIndex < width; colIndex++) {
                row.push(map[rowIndex * width + colIndex]);
            }
            arrayg.push(row);
        }
    }
</script>





<div class="bg-white p-8 rounded-lg shadow-md w-196">
    <table>
        {#each arrayg as row}
            <tr>
                {#each row as cell}
                    <td style="background-color: {cell['color']}">
                        {cell['name']}
                        <br>
                        {cell['y_pos']}:{cell['x_pos']}
                    </td>
                {/each}
            </tr>
        {/each}
    </table>
</div>

<style>
    table, td {
        border: 1px solid black;
        border-collapse: collapse;
    }
</style>

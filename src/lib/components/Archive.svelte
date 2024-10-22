<script>
    import { onMount } from "svelte";
    import { selected } from "$lib/stores/selected";
    import { points } from "$lib/stores/points";
    import DetailPanel from "@components/DetailPanel.svelte";
    import { createEventDispatcher } from "svelte";

    const dispatch = createEventDispatcher();
    export let data;

    let selectedPoint = null;
    let panelVisible = false;
    let panelRef;
    let searchTerm = "";
    let filteredPoints = [];

    $: selected.subscribe((value) => {
        selectedPoint = value;
        panelVisible = !!selectedPoint;
    });

    $: filteredPoints = $points.filter((point) =>
        (point.Title || point["Reference Code"])
            .toLowerCase()
            .includes(searchTerm.toLowerCase()),
    );

    function handleKeydown(event) {
        if (event.key === "Enter") {
            dispatch("updateFilteredData", filteredPoints);
        }
    }

    function resetSearch() {
        searchTerm = "";
        dispatch("updateFilteredData", data);
    }

    onMount(() => {
        document.addEventListener("click", handleClickOutside, true);
    });

    function handleClickOutside(event) {
        if (panelVisible && panelRef && !panelRef.contains(event.target)) {
            selected.set(null);
        }
    }

    function selectPoint(point) {
        selected.set(point);
    }
</script>

<button class="reset-button" on:click={resetSearch}>Reset</button>

<input
    type="text"
    placeholder="Search..."
    bind:value={searchTerm}
    class="search-input"
    on:keydown={handleKeydown}
/>

<section>
    {#if panelVisible}
        <div bind:this={panelRef}>
            <DetailPanel />
        </div>
    {/if}
    <div class="list-container">
        {#each filteredPoints as point, index}
            <div
                class:gray-background={index % 2 === 1}
                on:click={() => selectPoint(point)}
            >
                <p>{point.Title || point["Reference Code"]}</p>
            </div>
        {/each}
    </div>
</section>

<style>
    section {
        width: 250px;
    }

    .search-input {
        width: calc(100% - 10px);
        border: none;
        outline: none;
        color: var(--primary-color);
        position: sticky;
        top: 0;
        margin-bottom: 10px;
    }

    .reset-button {
        background-color: gainsboro;
        color: black;
        border: none;
        padding: 5px;
        cursor: pointer;
        margin-bottom: 2px;
    }

    .reset-button:hover {
        background-color: var(--primary-color);
        color: white;
    }

    .list-container {
        background-color: white;
        max-height: 100vh;
        font-size: 12px;
        color: var(--primary-color);
        cursor: pointer;
        overflow: auto;
    }

    .list-container > * {
        margin: 0;
        padding: 0 5px;
        font-size: 12px;
    }

    .list-container > * :hover {
        background-color: var(--primary-color);
        color: black;
    }

    .gray-background {
        background-color: rgb(241, 241, 241);
    }

    p {
        margin: 0;
        font-weight: 400;
    }
</style>

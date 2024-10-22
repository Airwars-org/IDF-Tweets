<script>
    import MapContainer from "@components/MapContainer.svelte";
</script>

<svelte:window />

<article>
    <MapContainer />
</article>

<style>
    :global(html) {
        --primary-color: blue;
        background-color: rgb(237, 237, 237);
    }

    :global(body) {
        margin: 0;
        padding: 0;
        color: white;
        font-family: sans-serif;
        font-size: 19px;
    }

    :global(::selection) {
        background-color: var(--primary-color);
        color: black;
    }

    article {
        /* max-width: 1920px; */
        display: block;
        margin: 0 auto;
    }
</style>

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

    @font-face {
        font-family: "Atlas Grotesk";
        src:
            url("/fonts/AtlasGrotesk-Regular.woff2") format("woff2"),
            url("/fonts/AtlasGrotesk-Regular.woff") format("woff"),
            url("/fonts/AtlasGrotesk-Regular.otf") format("opentype");
        font-weight: normal;
        font-style: normal;
    }

    @font-face {
        font-family: "Atlas Grotesk";
        src:
            url("/fonts/AtlasGrotesk-Bold.woff2") format("woff2"),
            url("/fonts/AtlasGrotesk-Bold.woff") format("woff"),
            url("/fonts/AtlasGrotesk-Bold.otf") format("opentype");
        font-weight: bold;
        font-style: normal;
    }

    @font-face {
        font-family: "Atlas Grotesk";
        src:
            url("/fonts/AtlasGrotesk-RegularItalic.woff2") format("woff2"),
            url("/fonts/AtlasGrotesk-RegularItalic.woff") format("woff"),
            url("/fonts/AtlasGrotesk-RegularItalic.otf") format("opentype");
        font-weight: normal;
        font-style: italic;
    }
</style>

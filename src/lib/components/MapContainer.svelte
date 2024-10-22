<script>
    import Map from "@components/Map.svelte";
    import Archive from "@components/Archive.svelte";
    import SmallMap from "@components/SmallMap.svelte";
    import { csv } from "d3";
    import { onMount } from "svelte";

    import Timeline from "@components/Timeline.svelte";

    let data = [];
    let filteredData = [];
    let windowWidth = 0;
    let viewportHeight = 0;

    const handleResize = () => {
        windowWidth = window.innerWidth;
        viewportHeight = window.innerHeight;
    };

    const updateFilteredData = (newFilteredData) => {
        filteredData = newFilteredData?.detail;
    };

    onMount(async () => {
        const response =
            "https://docs.google.com/spreadsheets/d/e/2PACX-1vR2ixzurghRCd5eNEn15gsUC9wjAW2PoB2eIkxNvp89g2vIFjG-to5geUiBIN9yxJrJ_vZkIYesjKOW/pub?output=csv";
        data = await csv(response);
        data = data.filter((d) => d["Add to Map"] == "TRUE");
        handleResize();
        window.addEventListener("resize", handleResize);
    });
</script>

<section class="map">
    {#if data.length === 0}
        <p class="loading">Loading...</p>
    {:else}
        <section class="top">
            <section>
                {#if windowWidth > 800}
                    <div class="small">
                        <SmallMap
                            data={filteredData.length > 0 ? filteredData : data}
                            {windowWidth}
                        />
                    </div>
                {/if}
            </section>
            <div class="mapContainer">
                <Map data={filteredData.length > 0 ? filteredData : data} />
            </div>
            <div class="panel">
                <Archive {data} on:updateFilteredData={updateFilteredData} />
            </div>
        </section>
        <div class="timeline">
            <Timeline  data={filteredData.length > 0 ? filteredData : data} on:filteredData={updateFilteredData} />
        </div>
    {/if}
</section>

<style>
    .top {
        display: flex;
        justify-content: space-between;
    }

    .mapContainer {
        width: 100%;
        max-width: 1080px;
        height: 100vh;
        overflow: scroll;
        margin-bottom: 100px;
    }

    .panel {
        min-width: 100px;
    }

    .loading {
        margin: 0;
        padding: 10px;
        color: var(--primary-color);
    }

    .timeline {
        padding: 10px;
        position: fixed;
        bottom: 0;
        width: 100%;
        background-color: rgb(241, 241, 241);
        border-top: 1px solid black;
    }
</style>

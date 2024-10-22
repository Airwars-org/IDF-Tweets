<script>
    import Map from "@components/Map.svelte";
    import Legend from "@components/Legend.svelte";
    import DetailPanel from "@components/DetailPanel.svelte";
    import SmallMap from "@components/SmallMap.svelte";
    import { csv } from "d3";
    import { onMount } from "svelte";
    import { selected } from "$lib/stores/selected";

    import DateRange from "@components/DateRange.svelte";
    import TimelineSlider from "@components/TimelineSlider.svelte";

    let data = [];
    let filteredData = [];
    let mapContainer;
    let windowWidth = 0;
    let scrollPercentage = 0;
    let containerHeight = 0;
    let viewportHeight = 0;

    const handleResize = () => {
        windowWidth = window.innerWidth;
        viewportHeight = window.innerHeight;
    };

    const handleScroll = () => {
        if (mapContainer) {
            const containerBounds = mapContainer.getBoundingClientRect();
            containerHeight = containerBounds.height;

            const maxScrollHeight = containerHeight - viewportHeight;
            const scrolledDistance = Math.max(0, -containerBounds.top);

            scrollPercentage = Math.min(
                Math.max(0, (scrolledDistance / maxScrollHeight) * 100),
                100,
            );
        }
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
        window.addEventListener("scroll", handleScroll);
        handleScroll();
    });
</script>

<section class="map">
    {#if data.length === 0}
        <p class="loading">Loading...</p>
    {:else}
        <section>
            {#if windowWidth <= 800}
                <div class="small-heading">
                    <DateRange {data} />
                </div>
                <Legend />
            {/if}
            <div class="sticky">
                {#if windowWidth > 800}
                    <div class="intro small-heading">
                        <DateRange {data} />
                    </div>
                {/if}

                <div class="panel">
                    {#if !$selected}
                        {#if windowWidth > 800}
                            <Legend />
                        {/if}
                    {/if}
                    <DetailPanel />
                </div>
                {#if windowWidth > 800}
                    <div class="small">
                        <SmallMap
                            data={filteredData.length > 0 ? filteredData : data}
                            {windowWidth}
                            {scrollPercentage}
                            {containerHeight}
                            {viewportHeight}
                        />
                    </div>
                {/if}
            </div>
            <div class="mapContainer" bind:this={mapContainer}>
                <Map data={filteredData.length > 0 ? filteredData : data} />
            </div>
        </section>
        <div class="timeline">
            <TimelineSlider {data} on:filteredData={updateFilteredData} />
        </div>
    {/if}
</section>

<style>
    .map {
        position: relative;
    }

    .loading {
        padding: 10px;
        min-height: 100vh;
        color: var(--primary-color);
    }

    .intro {
        color: var(--primary-color);
        width: 100%;
        position: absolute;
    }

    .small-heading {
        color: var(--primary-color);
        font-size: clamp(1.6rem, 1.4vw, 2rem);
    }

    .mapContainer {
        margin-top: -100vh;
        margin-bottom: 100px;
    }

    .sticky {
        position: sticky;
        z-index: 1;
        top: 10px;
        height: 100vh;
        pointer-events: none;
        padding-bottom: 100px;
    }

    .panel {
        z-index: 1;
        margin-left: calc(100vw - 320px - 10px);
        overflow: scroll;
    }

    .small {
        position: absolute;
        z-index: -1;
        bottom: 250px;
        margin: 10px;
    }

    .timeline {
        position: fixed;
        bottom: 0;
        width: 100%;
        background-color: black;
    }

    @media (max-width: 800px) {
        .panel {
            margin-left: 0;
            top: 0px;
        }

        .sticky {
            top: 0px;
            padding-bottom: 20px;
        }

        .small {
            display: none;
        }
    }
</style>

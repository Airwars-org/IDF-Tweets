<script>
    import { geoPath, geoMercator } from "d3-geo";
    import * as topojson from "topojson-client";
    import Tooltip from "@components/Tooltip.svelte";
    import { points } from "$lib/stores/points";

    export let data;

    let container;
    let w;
    let svgWidth = 0;
    let svgHeight = 0;
    let projection;
    let path;
    let gaza = [];
    let boundary = [];
    let buildings = [];
    let pointsArray = [];

    // Fetch initial data for Gaza, boundary, and buildings
    $: if (gaza.length === 0) {
        fetch("boundary.json")
            .then((response) => response.json())
            .then((boundaryData) => {
                boundary = topojson.feature(
                    boundaryData,
                    boundaryData.objects.boundary,
                ).features;
            });

        fetch("streets.json")
            .then((response) => response.json())
            .then((gazaData) => {
                gaza = topojson.feature(
                    gazaData,
                    gazaData.objects.streets,
                ).features;
            });

        fetch("buildings2.json")
            .then((response) => response.json())
            .then((buildingsData) => {
                buildings = topojson.feature(
                    buildingsData,
                    buildingsData.objects.test1,
                ).features;
            });
    }

    // Reactive statement to update pointsArray when data changes
    $: pointsArray = data.map((d) => {
        return {
            ...d,
            direction: d["Direction"]
                ? d["Direction"]
                : Math.random() > 0.5
                  ? "left"
                  : "right",
            date: d["Date of incident"],
        };
    });

    $: if (w && gaza.length > 0) {
        updateMap(w);
    }

    $: if (pointsArray) {
        updateMap(w);
    }

    function updateMap(width) {
        projection = geoMercator().rotate([-48, 48]).scale(1).translate([0, 0]);

        const pathGenerator = geoPath().projection(projection);
        const bounds = pathGenerator.bounds({
            type: "FeatureCollection",
            features: gaza,
        });

        const dx = bounds[1][0] - bounds[0][0];
        const dy = bounds[1][1] - bounds[0][1];
        const x = (bounds[0][0] + bounds[1][0]) / 2;
        const y = bounds[0][1] + bounds[1][1];

        const padding = [100, 10, 20];
        const scale = (width - padding[0]) / dx;
        const translate = [
            width / 2 - scale * x,
            (-scale - padding[1]) * bounds[0][1] + bounds[1][1],
        ];

        projection = projection.scale(scale).translate(translate);
        path = geoPath().projection(projection);

        svgWidth = width;
        svgHeight = scale * dy + padding[2];

        $points = pointsArray.map((d) => {
            const [cx, cy] = projection([d.lon, d.lat]);
            return {
                ...d,
                cx,
                cy,
            };
        });
    }

    $: pointsWithRefCode = $points
        ? $points.filter((point) => point["Reference Code"])
        : [];
    $: pointsWithoutRefCode = $points
        ? $points.filter((point) => !point["Reference Code"])
        : [];
</script>

<article bind:this={container} bind:clientWidth={w} class="map">
    {#if gaza.length > 0}
        <svg width={svgWidth} height={svgHeight}>
            {#if boundary.length > 0}
                <g class="boundary">
                    {#each boundary as feature, i}
                        <path d={path(feature)} class="boundary" />
                    {/each}
                </g>
            {/if}

            <!-- {#if w > 800 && buildings.length > 0}
                <g class="buildings">
                    {#each buildings as feature, i}
                        <path d={path(feature)} class="building" />
                    {/each}
                </g>
            {/if} -->

            <g class="streets">
                {#each gaza as feature, i}
                    <path d={path(feature)} class="street" />
                {/each}
            </g>

            <g class="points">
                {#each pointsWithoutRefCode as point, i}
                    {#if point.cx && point.cy}
                        <Tooltip {point} {w} />
                    {/if}
                {/each}

                {#each pointsWithRefCode as point, i}
                    {#if point.cx && point.cy}
                        <Tooltip {point} {w} />
                    {/if}
                {/each}
            </g>
        </svg>
    {/if}
</article>

<style>
    article {
        width: 100%;
    }

    .boundary {
        stroke-width: 2px;
        fill: none;
    }

    .boundary {
        fill: rgb(242, 242, 242);
        stroke-width: 2px;
        stroke: rgb(228, 228, 228);
    }

    .buildings {
        fill: rgb(40, 40, 40);
        stroke: none;
    }

    .streets {
        fill: none;
        stroke-width: 0.5px;
        stroke: rgb(166, 166, 166);
    }
</style>

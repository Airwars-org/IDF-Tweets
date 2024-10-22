<script>
    import { geoPath, geoMercator } from "d3-geo";

    export let data;
    export let windowWidth;
    export let scrollPercentage;
    export let containerHeight;
    export let viewportHeight;

    let container;
    let w = windowWidth > 800 ? 100 : 50;
    let h = windowWidth > 800 ? 300 : 150;

    let svgWidth = 0;
    let svgHeight = 0;
    let projection;
    let path;
    let boundary = [];
    let pointsArray = [];
    let gaza = [];
    let viewportRect = {};

    $: if (boundary.length == 0) {
        fetch("boundary.geojson")
            .then((response) => response.json())
            .then((boundaryData) => {
                boundary = boundaryData.features;
            });

        fetch("streets.geojson")
            .then((response) => response.json())
            .then((gazaData) => {
                gaza = gazaData.features;
            });
    }
    
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

    $: if (pointsArray) {
        updateMap(w, h);
    }

    $: if (w && boundary.length > 0) {
        updateMap(w, h);
    }

    $: if (svgHeight && containerHeight) {
        const ratio = svgHeight / containerHeight;
        const rectHeight = viewportHeight * ratio;

        viewportRect = {
            x: 0,
            y: (svgHeight - rectHeight) * (scrollPercentage / 100),
            width: svgWidth,
            height: rectHeight,
        };
    }

    function updateMap(width, height) {
        projection = geoMercator().rotate([-48, 48]).scale(1).translate([0, 0]);

        const pathGenerator = geoPath().projection(projection);
        const bounds = pathGenerator.bounds({
            type: "FeatureCollection",
            features: boundary,
        });

        const dx = bounds[1][0] - bounds[0][0];
        const dy = bounds[1][1] - bounds[0][1];
        const x = (bounds[0][0] + bounds[1][0]) / 2;
        const y = (bounds[0][1] + bounds[1][1]) / 2;

        const padding = [10, 10];
        const scale = Math.min(
            (width - padding[0]) / dx,
            (height - padding[1]) / dy,
        );
        const translate = [width / 2 - scale * x, height / 2 - scale * y];

        projection = projection.scale(scale).translate(translate);
        path = geoPath().projection(projection);

        pointsArray = pointsArray.map((d) => {
            const [cx, cy] = projection([d.lon, d.lat]);
            return { ...d, cx, cy };
        });

        svgWidth = width;
        svgHeight = height;
    }
</script>

<article bind:this={container} class="map">
    {#if boundary.length > 0}
        <svg width={svgWidth} height={svgHeight}>
            <g class="boundary">
                {#each boundary as feature, i}
                    <path d={path(feature)} class="boundary" />
                {/each}
            </g>

            <g class="streets">
                {#each gaza as feature, i}
                    <path d={path(feature)} class="street" />
                {/each}
            </g>

            <g class="legend-points">
                {#each pointsArray as point, i}
                    {#if point.cx && point.cy}
                        <circle cx={point.cx} cy={point.cy} r={1} />
                    {/if}
                {/each}
            </g>

            <rect
                x={viewportRect.x}
                y={viewportRect.y}
                width={viewportRect.width}
                height={viewportRect.height}
                fill="var(--primary-color)"
                stroke="red"
                stroke-width="0.5"
            />
        </svg>
    {/if}
</article>

<style>
    .boundary {
        fill: rgb(214, 214, 214);
        stroke-width: 1px;
        stroke: rgb(179, 179, 179);
    }

    .streets {
        fill: none;
        stroke-width: 0.1px;
        stroke: rgb(60, 60, 60);
    }

    rect {
        opacity: 0.3;
    }

    .legend-points circle {
        fill: var(--primary-color);
        stroke: none;
    }
</style>

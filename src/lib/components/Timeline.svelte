<script>
    import { createEventDispatcher } from "svelte";
    import { getMinMaxDates, parseDate } from "@lib/utils.js";
    import Legend from "@components/Legend.svelte";

    export let data = [];
    const dispatch = createEventDispatcher();

    let minDate, maxDate;
    let filteredData = data;
    let incidentCounts = {};
    let dateRange = [];
    let counts = [];
    $: selectedDate = null;

    $: ({ min: minDate, max: maxDate } = getMinMaxDates(data));

    $: if (data.length) {
        incidentCounts = {};
        for (let d of data) {
            const postDate = parseDate(d["Post Date"]);
            if (postDate && !isNaN(postDate.getTime())) {
                const dateKey = postDate.toISOString().split("T")[0];
                incidentCounts[dateKey] = (incidentCounts[dateKey] || 0) + 1;
            }
        }
    }

    $: if (minDate && maxDate) {
        dateRange = [];
        counts = [];
        for (let i = minDate.getTime(); i <= maxDate.getTime(); i += 86400000) {
            const dateKey = new Date(i).toISOString().split("T")[0];
            dateRange.push(dateKey);
            counts.push(incidentCounts[dateKey] || 0);
        }
    }

    function filterDataByDate(date) {
        if (selectedDate === date) {
            filteredData = data;
            selectedDate = null;
        } else {
            filteredData = data.filter((d) => {
                const postDate = parseDate(d["Post Date"]);
                return (
                    postDate && postDate.toISOString().split("T")[0] === date
                );
            });
            selectedDate = date;
        }

        dispatch("filteredData", filteredData);
    }
</script>

<div class="timeline-container">
    <Legend {filteredData} {selectedDate} {data} {minDate} />

    <div class="chart">
        <!-- <p class="date">
            {formatDate(new Date(minDate))}
        </p> -->
        {#each dateRange as dateKey, index}
            <div
                class="bar"
                style="height: {counts[index] *
                    2}px; background-color: {selectedDate === dateKey
                    ? 'black'
                    : 'var(--primary-color)'};"
                title="{dateKey}: {counts[index]} incidents"
                on:click={() => filterDataByDate(dateKey)}
            >
                <div class="count">
                    <p>
                        {parseDate(dateKey).toLocaleDateString("en-US", {
                            month: "short",
                            day: "numeric",
                        })}
                    </p>
                    <!-- <p>
                        {counts[index]}
                    </p> -->
                </div>
            </div>
        {/each}
        <!-- <p class="date">
            {formatDate(new Date(maxDate))}
        </p> -->
    </div>
</div>

<style>
    .timeline-container {
        display: flex;
        flex-direction: column;
        align-items: center;
        color: var(--primary-color);
        width: calc(100% - 2rem);
        margin: 1rem;
        max-height: 200px;
        z-index: 100;
    }

    .chart {
        display: flex;
        width: 100%;
        overflow-x: auto;
        margin-bottom: 1rem;
        position: relative;
    }

    .bar {
        width: 100%;
        min-width: 10px;
        text-align: center;
        position: relative;
        margin-right: 2px;
        cursor: pointer;
        position: relative;
        border-top: 1px solid gray;
        margin-top: 25px;
        font-size: 10px;
    }

    .bar span {
        bottom: 100%;
        left: 50%;
        transform: translateX(-50%);
        white-space: nowrap;
    }

    .date {
        font-size: 12px;
        min-width: fit-content;
    }

    .count {
        position: absolute;
        margin-top: -25px;
        text-align: center;
        width: 100%;
    }
</style>

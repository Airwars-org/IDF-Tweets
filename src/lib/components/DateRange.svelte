<script>
    import { getMinMaxDates, parseDate } from "@lib/utils.js";

    export let data = [];

    let dateRange = { min: null, max: null };

    $: if (data.length) {
        dateRange = getMinMaxDates(data);
    }
</script>

<div>
    {#if dateRange.min && dateRange.max}
        <p>Geolocated Israeli military strike footage in Gaza</p>
        <p class="tiny">
            {dateRange.min.toLocaleDateString("en-US", {
                month: "short",
                day: "numeric",
            })} –
            {dateRange.max.toLocaleDateString("en-US", {
                month: "short",
                day: "numeric",
                year: "numeric",
            })}
        </p>
    {:else}
        <p class="tiny">Loading date range...</p>
    {/if}
</div>

<style>
    p {
        margin: 0;
        font-size: 1rem;
    }
</style>

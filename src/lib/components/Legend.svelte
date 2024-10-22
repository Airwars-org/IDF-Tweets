<script>
    import { getMinMaxDates, parseDate } from "@lib/utils.js";
    import DateRange from "@components/DateRange.svelte";
    export let filteredData;
    export let selectedDate;
    export let data;
    export let minDate;

    const formatDate = (date) =>
        date.toLocaleDateString("en-US", {
            month: "short",
            day: "numeric",
            year: "numeric",
        });
</script>

<div class="results">
    <div>
        <DateRange {data} />
    </div>
    <div class="centre-heading">
        {filteredData?.length} incidents found from
        <strong>
            {selectedDate
                ? formatDate(new Date(selectedDate))
                : formatDate(new Date(minDate))}
        </strong> onwards
    </div>
    <div class="legend">
        <svg
            class="marker"
            width=".8rem"
            height=".8rem"
            viewBox="0 0 20 29"
            fill="none"
            xmlns="http://www.w3.org/2000/svg"
        >
            <path
                fill-rule="evenodd"
                clip-rule="evenodd"
                d="M20 0H0V15.6522L10 28.2609L20 15.6522V0ZM10 15.8967C13.1216 15.8967 15.6522 13.3266 15.6522 10.1562C15.6522 6.98586 13.1216 4.41576 10 4.41576C6.87839 4.41576 4.34783 6.98586 4.34783 10.1562C4.34783 13.3266 6.87839 15.8967 10 15.8967Z"
                fill="white"
            />
            <!-- <ellipse
                cx="9.99996"
                cy="10.1562"
                rx="2.17391"
                ry="2.20788"
                fill="white"
            /> -->
        </svg>
        <p class="explore">
            Strike footage matched with civilian harm allegation
        </p>
        <svg
            class="marker"
            width=".8rem"
            height=".8rem"
            viewBox="0 0 20 20"
            fill="none"
            xmlns="http://www.w3.org/2000/svg"
        >
            <ellipse cx="10" cy="10" rx="4" ry="4" fill="white" />
        </svg>
        <p>Geolocated Israeli military strike footage</p>
    </div>
</div>

<style>
    .results {
        width: 100%;
        display: flex;
        font-size: 1rem;
        gap: 10px;
        padding-bottom: 20px;
    }

    .results > * {
        flex: 1;
        padding: 0;
    }

    p {
        padding: 0;
        margin: 0;
    }

    .legend {
        align-items: center;
        display: flex;
        margin: 10px 0;
        border-radius: 8px;
        width: 320px;
        height: fit-content;
        align-items: flex-start;
        flex-wrap: wrap;
        gap: 5px;
    }

    .legend > svg {
        flex: 5%;
    }

    .legend > p {
        flex: 90%;
    }

    .marker * {
        fill: var(--primary-color);
        /* fill: #8c8c8c; */
        padding: 5px;
    }
</style>

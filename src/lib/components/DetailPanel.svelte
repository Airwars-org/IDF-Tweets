<script>
    import { selected } from "$lib/stores/selected";
    let selectedPoint = null;
    let panelVisible = false;
    let panelRef;

    let searchTerm = "";

    $: selected.subscribe((value) => {
        selectedPoint = value;
        panelVisible = !!selectedPoint;
    });
</script>

<div class="detail-panel">
    <div class="close" on:click={() => selected.set(null)}>×</div>

    <h1>{selectedPoint.Title || "No Title"}</h1>

    {#if selectedPoint["Post date"]}
        <div>
            <h3>Date Posted</h3>
            <p>{selectedPoint["Post date"]}</p>
        </div>
    {/if}

    {#if selectedPoint.Location}
        <div>
            <h3>Location</h3>
            <p>{selectedPoint.Location}</p>
        </div>
    {/if}

    {#if selectedPoint["Civilians reported killed"]}
        <div>
            <h3>Civilians Reported Killed</h3>
            <p>{selectedPoint["Civilians reported killed"]}</p>
        </div>
    {/if}

    {#if selectedPoint["Footage link"]}
        <div>
            <h3>Source</h3>
            <a href={selectedPoint["Footage link"]} target="_blank">
                View Footage
            </a>
        </div>
    {/if}
</div>

<style>
    .detail-panel {
        width: 100%;
        background: var(--primary-color);
        color: black;
    }

    .detail-panel > div {
        padding-bottom: 10px;
    }

    .close {
        cursor: pointer;
        font-size: 24px;
        position: absolute;
        right: 10px;
        top: 10px;
    }

    h1,
    h3,
    p {
        margin: 0;
        font-weight: 400;
        font-size: 12px;
    }

    a {
        color: var(--primary-color);
    }
</style>

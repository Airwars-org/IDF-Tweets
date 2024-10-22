<section>
    <div>
        <h1>The</h1>
        <h1>Killings</h1>
        <h1>They</h1>
        <h1>Tweeted</h1>

        <p class="small-heading">An Airwars investigation</p>
        <p>
            By Rowena De Silva, Nikolaj Houmann Mortensen, Joe Dyke, Sanjana
            Varghese, Nathan Walker, Rosie Harris-Davison, Maia Awada, Azul De
            Monte, Giacomo Nanni, Mohammed Shatat
        </p>
        <p class="tiny">October 9, 2024</p>
    </div>
    <div>
        <p>
            In the largest public analysis of Israeli military strike footage,
            Airwars, in collaboration with Sky News, reviewed hundreds of clips
            of strikes the IDF said were targeting Hamas and other militant
            groups in Gaza that were posted on official military social media
            accounts in the first month of the war. Despite the grainy videos
            published with few details on targets or locations, Airwars matched
            17 strikes to specific geo-coordinates where our researchers had
            tracked Palestinians killed or injured. In these strikes alone, more
            than 400 civilians were reported killed.
        </p>

        <p>
            The video above explains our findings in detail, while the
            interactive map below features all strike footage geolocated as well
            as those cases matched to the Airwars civilian harm archive.
        </p>
    </div>
</section>
<hr />

<style>
    section {
        color: var(--primary-color);
        display: flex;
        flex-wrap: wrap;
        gap: 10px;
        padding: 10px;
        padding-bottom: 130px;
        border-bottom: 10px solid rgb(8, 8, 8);
        /* max-width: 1920px;
        margin: 0 auto; */
    }

    hr {
        border: none;
        border-bottom: 1px dotted var(--primary-color);
        margin: 0;
        margin-bottom: 2rem;
    }

    div {
        flex: 1;
        max-width: 800px;
    }

    div > * {
        max-width: 650px;
    }

    section div:nth-of-type(1) > * {
        max-width: 450px;
    }

    h1 {
        font-size: clamp(2rem, 6vw, 6rem);
        line-height: clamp(2rem, 6vw, 6rem);
        font-weight: 400;
        margin: 0;
        padding: 0;
    }

    p {
        font-size: clamp(1rem, 1vw, 1.6rem);
        line-height: 1.3em;
    }

    .small-heading {
        font-size: clamp(1.6rem, 1.4vw, 2rem);
        line-height: clamp(1.6rem, 1.4vw, 2rem);
        margin: 0.5rem 0 2rem 0;
    }

    .tiny {
        font-size: clamp(0.875rem, 1vw, 1rem);
        opacity: 0.6;
    }

    .explore {
        display: flex;
        align-content: center;
        align-items: center;
        gap: 10px;
    }

    @media (max-width: 800px) {
        section {
            position: unset;
            margin-bottom: 50px;
            padding-bottom: 0;
        }
    }
</style>

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
    <p class="explore">Strike footage matched with civilian harm allegation</p>
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

    <!-- <svg
        width=".9rem"
        height=".9rem"
        viewBox="0 0 17 17"
        fill="none"
        xmlns="http://www.w3.org/2000/svg"
    >
        <g opacity="0.5">
            <rect
                x="0.5"
                y="0.5"
                width="16"
                height="15.756"
                rx="7.878"
                stroke="#FC540D"
            />
            <path
                d="M9.68845 6.376C9.68845 5.76 9.28145 5.364 8.56645 5.364C7.86245 5.364 7.26845 5.749 7.26845 6.937H5.59645C5.56345 5.21 6.63045 4 8.59945 4C10.5794 4 11.4044 5.023 11.4044 6.288C11.4044 7.3 10.9754 7.85 10.2604 8.444L9.52345 9.06C9.29245 9.247 9.21545 9.346 9.21545 9.654V10.127H7.70845V9.423C7.70845 8.73 7.79645 8.554 8.37945 8.081L9.00645 7.564C9.42445 7.212 9.68845 6.926 9.68845 6.376ZM9.42445 12.756H7.49945V11.084H9.42445V12.756Z"
                fill="#FC540D"
            />
        </g>
    </svg> -->
</div>

<style>
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

    p {
        color: var(--primary-color);
        /* color: #8c8c8c; */
        font-size: clamp(14px, 1vw, 16px);
        /* padding: 5px; */
        vertical-align: middle;
        margin: 0;
    }

    @media (max-width: 800px) {
        .legend {
            /* width: 100%; */
            max-width: unset;
            margin: 10px;
            padding: 10px 0;
            border-radius: 0;

            /* display: block; */
        }
    }
</style>

export const parseDate = (dateString) => {
    return new Date(dateString);
};

export const getMinMaxDates = (data) => {
    const dates = data
        .map((d) => parseDate(d["Post Date"]))
        .filter((date) => date instanceof Date && !isNaN(date));

    const minDate = new Date(Math.min(...dates.map((d) => d.getTime())));
    const maxDate = new Date(Math.max(...dates.map((d) => d.getTime())));

    return { min: minDate, max: maxDate };
};
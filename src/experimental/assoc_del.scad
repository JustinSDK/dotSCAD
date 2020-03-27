use <util/slice.scad>;

function assoc_del(array, key) =
    let(idx = search([key], array)[0])
    idx == [] ? array : concat(slice(array, 0, idx), slice(array, idx + 1));
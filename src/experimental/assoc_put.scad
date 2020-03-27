use <util/slice.scad>;

function assoc_put(array, key, value) =
    let(idx = search([key], array)[0])
    idx == [] ? concat(array, [[key, value]]) : 
                concat(slice(array, 0, idx), [[key, value]], slice(array, idx + 1));
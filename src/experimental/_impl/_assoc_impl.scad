use <util/slice.scad>;

function _assoc_get(array, key) = 
    let(idx = search([key], array)[0])
    array[idx][1];

function _assoc_put(array, key, value) =
    let(idx = search([key], array)[0])
    idx == [] ? concat(array, [[key, value]]) : 
                concat(slice(array, 0, idx), [[key, value]], slice(array, idx + 1));

function _assoc_remove(array, key) =
    let(idx = search([key], array)[0])
    idx == [] ? array : concat(slice(array, 0, idx), slice(array, idx + 1));
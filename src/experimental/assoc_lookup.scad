function assoc_lookup(array, key) = 
    let(idx = search([key], array)[0])
    array[idx][1];
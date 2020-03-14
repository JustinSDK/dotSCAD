use <util/bsearch.scad>;

function has(lt, elem, sorted = false) = 
    sorted ? bsearch(lt, elem, by = "vt") != -1 :
             search([elem], lt) != [[]];
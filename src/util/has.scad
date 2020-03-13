use <util/sort.scad>;
use <util/bsearch.scad>;

function has(lt, elem, sorted = false) = 
    sorted ? bsearch(lt, elem) != -1 :
             search([elem], lt) != [[]];
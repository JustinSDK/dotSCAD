function _greaterThan(elem1, elem2, i) =
    i == -1              ? false :
    elem1[i] > elem2[i]  ? true :
    elem1[i] == elem2[i] ? _greaterThan(elem1, elem2, i - 1) : false;
    
function greaterThan(elem1, elem2) = _greaterThan(elem1, elem2, len(elem1));
    
function lessThan(elem1, elem2) = !greaterThan(elem1, elem2) && elem1 != elem2;

function _binary_search(sorted, elem, low, upper) =
    low > upper ? -1 :
    let(mid = floor((low + upper) / 2))
    lessThan(sorted[mid], elem) ? _binary_search(sorted, elem, mid + 1, upper) :
    greaterThan(sorted[mid], elem) ? _binary_search(sorted, elem, low, mid - 1) : mid;

function bsearch(sorted, elem) = _binary_search(sorted, elem, 0, len(sorted) - 1);
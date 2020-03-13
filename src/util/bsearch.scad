use <util/_impl/_vt_default_comparator.scad>;

function _binary_search(sorted, elem, low, upper) =
    low > upper ? -1 :
    let(mid = floor((low + upper) / 2))
    lessThan(sorted[mid], elem) ? _binary_search(sorted, elem, mid + 1, upper) :
    greaterThan(sorted[mid], elem) ? _binary_search(sorted, elem, low, mid - 1) : mid;

// for example, `sorted` is by zyx
function bsearch(sorted, elem) = _binary_search(sorted, elem, 0, len(sorted) - 1);
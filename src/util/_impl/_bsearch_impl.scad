use <_vt_default_comparator.scad>;

function _bsearch_vt(sorted, elem, low, upper) =
    low > upper ? -1 :
    let(mid = floor((low + upper) / 2))
    lessThan(sorted[mid], elem) ? _bsearch_vt(sorted, elem, mid + 1, upper) :
    greaterThan(sorted[mid], elem) ? _bsearch_vt(sorted, elem, low, mid - 1) : mid;

function _bsearch_cmp(sorted, cmp, low, upper) =
    low > upper ? -1 :
    let(mid = floor((low + upper) / 2))
    cmp(sorted[mid]) < 0 ? _bsearch_cmp(sorted, cmp, mid + 1, upper) :
    cmp(sorted[mid]) > 0 ? _bsearch_cmp(sorted, cmp, low, mid - 1) : mid;
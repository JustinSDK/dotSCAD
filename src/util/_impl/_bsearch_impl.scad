use <_vt_default_comparator.scad>

function _bsearch_vt(sorted, elem, low, upper) =
    low > upper ? -1 :
    let(mid = floor((low + upper) / 2))
    sorted[mid] == elem ? mid :
    let(lu = lessThan(sorted[mid], elem) ? [mid + 1, upper] : [low, mid - 1])
    _bsearch_vt(sorted, elem, lu[0], lu[1]);
    
function _bsearch_cmp(sorted, cmp, low, upper) =
    low > upper ? -1 :
    let(mid = floor((low + upper) / 2), compared = cmp(sorted[mid]))
    compared == 0 ? mid :
    let(lu = compared < 0 ? [mid + 1, upper] : [low, mid - 1])
    _bsearch_cmp(sorted, cmp, lu[0], lu[1]);
use <util/_impl/_vt_default_comparator.scad>;

function _binary_search_by(sorted, elem, low, upper, i) =
    low > upper ? -1 :
    let(mid = floor((low + upper) / 2))
    sorted[mid][i] < elem[i] ? _binary_search_by(sorted, elem, mid + 1, upper, i) :
    sorted[mid][i] > elem[i] ? _binary_search_by(sorted, elem, low, mid - 1, i) : mid;

function _bsearch_vt(sorted, elem, low, upper) =
    low > upper ? -1 :
    let(mid = floor((low + upper) / 2))
    lessThan(sorted[mid], elem) ? _bsearch_vt(sorted, elem, mid + 1, upper) :
    greaterThan(sorted[mid], elem) ? _bsearch_vt(sorted, elem, low, mid - 1) : mid;

function _bsearch_by(sorted, elem, by, idx) =
    let(
        dict = [["x", 0], ["y", 1], ["z", 2], ["i", idx]],
        i = dict[search(by == "idx" ? "i" : by, dict)[0]][1]
    )
    _binary_search_by(sorted, elem, 0, len(sorted) - 1, i);
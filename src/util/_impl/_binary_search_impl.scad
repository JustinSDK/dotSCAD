function _binary_search_impl(sorted, cmp, low, upper) =
    low > upper ? -1 :
    let(mid = floor((low + upper) / 2), compared = cmp(sorted[mid]))
    compared == 0 ? mid :
    let(lu = compared < 0 ? [mid + 1, upper] : [low, mid - 1])
    _binary_search_impl(sorted, cmp, lu[0], lu[1]);
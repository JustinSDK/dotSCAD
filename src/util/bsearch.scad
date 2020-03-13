use <util/_impl/_bsearch_impl.scad>;

// for example, `sorted` is by zyx
function bsearch(sorted, elem) = _binary_search(sorted, elem, 0, len(sorted) - 1);
use <_vt_default_comparator.scad>;

function _insert(sorted, elem, less, leng, before = [], i = 0) =
    i == leng ? [each sorted, elem] :
    less(elem, sorted[i]) ? 
        [each before, elem, each [for(j = [i:leng - 1]) sorted[j]]] :
        _insert(sorted, elem, less, leng, [each before, sorted[i]], i + 1);
        
function _insert_sort_sub(lt, sorted, less, leng, i = 1) = 
    i == leng ? sorted :
    _insert_sort_sub(lt, _insert(sorted, lt[i], less, len(sorted)), less, leng, i + 1);
    
function _insert_sort(lt, less) = 
    let(leng = len(lt))
    leng == 0 ? lt : _insert_sort_sub(lt, [lt[0]], less, leng);
    
function _sort(lt, less, gt_eq) = 
    let(leng = len(lt))
    leng <= 7 ? _insert_sort(lt, less) :
    // quick sort
    let(
        pivot = lt[0],
        before = [for(j = 1; j < leng; j = j + 1) if(less(lt[j], pivot)) lt[j]],
        after =  [for(j = 1; j < leng; j = j + 1) if(gt_eq(lt[j], pivot)) lt[j]]
    )
    [each _sort(before, less, gt_eq), pivot, each _sort(after, less, gt_eq)];

function _vt_sort(lt) = _sort(lt, function(a, b) lessThan(a, b), function(a, b) greaterThan(a, b) || a == b);

function _sort_by_idx(lt, i) = _sort(lt, function(a, b) a[i] < b[i], function(a, b) a[i] >= b[i]);

function _sort_by_cmp(lt, cmp) = _sort(lt, function(a, b) cmp(a, b) < 0, function(a, b) cmp(a, b) >= 0);

function _sort_by(lt, by, idx) =
    let(
        dict = [["x", 0], ["y", 1], ["z", 2], ["i", idx]],
        i = dict[search(by == "idx" ? "i" : by, dict)[0]][1]
    )
    _sort_by_idx(lt, i);



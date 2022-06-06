use <_vt_default_comparator.scad>

function _sort(lt, less, gt_eq) = 
    let(leng = len(lt))
    leng <= 1 ? lt : 
    leng == 2 ? gt_eq(lt[1], lt[0]) ? lt : [lt[1], lt[0]] :
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



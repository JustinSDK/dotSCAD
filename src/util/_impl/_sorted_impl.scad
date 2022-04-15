function _sorted(lt, less, gt_eq) = 
    let(leng = len(lt))
    leng <= 1 ? lt : 
    leng == 2 ? gt_eq(lt[1], lt[0]) ? lt : [lt[1], lt[0]] :
        let(
            pivot = lt[0],
            before = [for(j = 1; j < leng; j = j + 1) if(less(lt[j], pivot)) lt[j]],
            after =  [for(j = 1; j < leng; j = j + 1) if(gt_eq(lt[j], pivot)) lt[j]]
        )
        [each _sorted(before, less, gt_eq), pivot, each _sorted(after, less, gt_eq)];

function _sorted_default(lt) = _sorted(lt, function(a, b) a < b, function(a, b) a >= b);

function _sorted_cmp(lt, cmp) = _sorted(lt, function(a, b) cmp(a, b) < 0, function(a, b) cmp(a, b) >= 0);   
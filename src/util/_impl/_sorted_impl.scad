function _sorted(lt, less) = 
    let(leng = len(lt))
    leng <= 1 ? lt : 
    leng == 2 ? !less(lt[1], lt[0]) ? lt : [lt[1], lt[0]] :
        let(
            pivot = lt[0],
            before = [for(j = 1; j < leng; j = j + 1) if(less(lt[j], pivot)) lt[j]],
            after =  [for(j = 1; j < leng; j = j + 1) if(!less(lt[j], pivot)) lt[j]]
        )
        [each _sorted(before, less), pivot, each _sorted(after, less)];

function _sorted_default(lt) = _sorted(lt, function(a, b) a < b);

function _sorted_cmp(lt, cmp) = _sorted(lt, function(a, b) cmp(a, b) < 0);   
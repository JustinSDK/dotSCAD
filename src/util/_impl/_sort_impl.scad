use <util/_impl/_vt_default_comparator.scad>;

function _vt_sort(lt) = 
    let(leng = len(lt))
    leng <= 1 ? lt : 
        let(
            pivot = lt[0],
            before = [for(j = 1; j < leng; j = j + 1) if(lessThan(lt[j], pivot)) lt[j]],
            after =  [for(j = 1; j < leng; j = j + 1) if(greaterThan(lt[j], pivot) || lt[j] == pivot) lt[j]]
        )
        concat(_vt_sort(before), [pivot], _vt_sort(after));

function _sort_by_idx(lt, i) = 
    let(leng = len(lt))
    leng <= 1 ? lt : 
        let(
            pivot = lt[0],
            before = [for(j = 1; j < leng; j = j + 1) if(lt[j][i] < pivot[i]) lt[j]],
            after =  [for(j = 1; j < leng; j = j + 1) if(lt[j][i] >= pivot[i]) lt[j]]
        )
        concat(_sort_by_idx(before, i), [pivot], _sort_by_idx(after, i));

function _sort_by(lt, by, idx) =
    let(
        dict = [["x", 0], ["y", 1], ["z", 2], ["i", idx]],
        i = dict[search(by == "idx" ? "i" : by, dict)[0]][1]
    )
    _sort_by_idx(lt, i);
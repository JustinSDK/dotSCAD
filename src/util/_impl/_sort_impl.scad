function _greaterThan(elem1, elem2, i) =
    i == -1              ? false :
    elem1[i] > elem2[i]  ? true :
    elem1[i] == elem2[i] ? _greaterThan(elem1, elem2, i - 1) : false;
    
function greaterThan(elem1, elem2) = _greaterThan(elem1, elem2, len(elem1));
    
function lessThan(elem1, elem2) = !greaterThan(elem1, elem2) && elem1 != elem2;

function _default_sort(lt) = 
    let(leng = len(lt))
    leng <= 1 ? lt : 
        let(
            pivot = lt[0],
            before = [for(j = 1; j < leng; j = j + 1) if(lessThan(lt[j], pivot)) lt[j]],
            after =  [for(j = 1; j < leng; j = j + 1) if(greaterThan(lt[j], pivot) || lt[j] == pivot) lt[j]]
        )
        concat(_default_sort(before), [pivot], _default_sort(after));

function _sort(lt, i) = 
    let(leng = len(lt))
    leng <= 1 ? lt : 
        let(
            pivot = lt[0],
            before = [for(j = 1; j < leng; j = j + 1) if(lt[j][i] < pivot[i]) lt[j]],
            after =  [for(j = 1; j < leng; j = j + 1) if(lt[j][i] >= pivot[i]) lt[j]]
        )
        concat(_sort(before, i), [pivot], _sort(after, i));

function _sort_impl(lt, by, idx) =
    let(
        dict = [["x", 0], ["y", 1], ["z", 2], ["i", idx]],
        i = dict[search(by == "idx" ? "i" : by, dict)[0]][1]
    )
    _sort(lt, i);
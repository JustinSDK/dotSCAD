function _sort(pts, i) = 
    let(leng = len(pts))
    leng <= 1 ? pts : 
        let(
            pivot = pts[0],
            before = [for(j = 1; j < leng; j = j + 1) if(pts[j][i] < pivot[i]) pts[j]],
            after =  [for(j = 1; j < leng; j = j + 1) if(pts[j][i] >= pivot[i]) pts[j]]
        )
        concat(_sort(before, i), [pivot], _sort(after, i));

function sort(points, by, idx = -1) =
    let(
        i = by == "x" ? 0 : (
            by == "y" ? 1 : (
                by == "z" ? 2 : idx
            )
        )
    )
    _sort(points, i);
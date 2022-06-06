use <../../util/sum.scad>

function _manhattan(v) = sum([for(d = v) abs(d)]);

function _chebyshev(p1, p2) =
    max([for(i = [0:len(p1) - 1]) abs(p1[i] - p2[i])]);

function _nz_worley_euclidean(p, cells) =
    min([for(cell = cells) norm(cell - p)]);;

function _nz_worley_manhattan(p, cells) =
    min([for(cell = cells) _manhattan(cell - p)]);

function _nz_worley_chebyshev(p, cells) =
    min([for(cell = cells) _chebyshev(cell, p)]);

function _nz_worley_border(p, cells) = 
    let(
        dists = [for(cell = cells) norm(cell - p)],
        m1 = min(dists),
        i1 = search(m1, dists)[0],
        dists2 = [for(i = [0:len(dists) - 1]) if(i != i1) dists[i]],
        nbrs2 = [for(i = [0:len(cells) - 1]) if(i != i1) cells[i]],
        m2 = min(dists2),
        i2 = search(m2, dists2)[0],
        fst = cells[i1],
        snd = nbrs2[i2],
        m = (fst + snd) / 2        
    )
    (p - m) * (fst - m);

use <../../util/sorted.scad>;
use <../../util/sum.scad>;

function _manhattan(v) = sum([for(d = v) abs(d)]);

function _chebyshev(p1, p2) =
    max([for(i = [0:len(p1) - 1]) abs(p1[i] - p2[i])]); 

function _nz_cell_classic(cells, p, dist) =
    let(
        dists = 
            dist == "euclidean" ? [for(cell = cells) norm(cell - p)] :
            dist == "manhattan" ? [for(cell = cells) _manhattan(cell - p)] :
            dist == "chebyshev" ? [for(cell = cells) _chebyshev(cell, p)] :
                            assert("Unknown distance option")
    )
    min(dists); 

function _nz_cell_border(cells, p) =
    let(
        dists = [for(cell = cells) norm(cell - p)],
        m1 = min(dists),
        i1 = search(m1, dists)[0],
        dists2 = [for(i = [0:len(dists) - 1]) if(i != i1) dists[i]],
        cells2 = [for(i = [0:len(cells) - 1]) if(i != i1) cells[i]],
        m2 = min(dists2),
        i2 = search(m2, dists2)[0],
        fst = cells[i1],
        snd = cells2[i2],
        m = (fst + snd) / 2
    )
    (p - m) * (fst - m);
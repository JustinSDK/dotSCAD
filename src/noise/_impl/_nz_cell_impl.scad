use <../../util/sort.scad>;
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
        dists = [
            for(cell = cells)
            [each cell, norm(cell - p)]
        ],
        idx = len(cells[0]),
        sorted = sort(dists, by = "idx", idx = idx),
        sorted0 = sorted[0],
        sorted1 = sorted[1],
        a = [for(i = [0:idx - 1]) sorted0[i]],
        m = (a + [for(i = [0:idx - 1]) sorted1[i]]) / 2
    )
    (p - m) * (a - m);
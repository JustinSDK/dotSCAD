use <../../util/sum.scad>

function _manhattan(v) = sum([for(d = v) abs(d)]);

function _chebyshev(p1, p2) =
    max([for(i = [0:len(p1) - 1]) abs(p1[i] - p2[i])]);

function _nz_worley_euclidean(p, nbrs) =
    _nz_worley_from(nbrs, [for(nbr = nbrs) norm(nbr - p)]);

function _nz_worley_manhattan(p, nbrs) =
    _nz_worley_from(nbrs, [for(nbr = nbrs) _manhattan(nbr - p)]);

function _nz_worley_chebyshev(p, nbrs) =
    _nz_worley_from(nbrs, [for(nbr = nbrs) _chebyshev(nbr, p)]);

function _nz_worley_from(nbrs, dists) = 
    let(
        m = min(dists),
        i = search(m, dists)[0]
    )
    [each nbrs[i], m];    

function _nz_worley_border(p, nbrs) = 
    let(
        dists = [for(nbr = nbrs) norm(nbr - p)],
        m1 = min(dists),
        i1 = search(m1, dists)[0],
        dists2 = [for(i = [0:len(dists) - 1]) if(i != i1) dists[i]],
        nbrs2 = [for(i = [0:len(nbrs) - 1]) if(i != i1) nbrs[i]],
        m2 = min(dists2),
        i2 = search(m2, dists2)[0],
        fst = nbrs[i1],
        snd = nbrs2[i2],
        m = (fst + snd) / 2        
    )
    [each fst, (p - m) * (fst - m)];

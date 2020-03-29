use <experimental/_impl/_nz_worley2_impl.scad>;
use <util/sort.scad>;

function _nz_voronoi2(p, seed, dim, m, n) = 
    let(
        fcord = [floor(p[0] / m), floor(p[1] / n)],
        nbrs = _neighbors(fcord, seed, dim, m, n),
        dists = [
            for(nbr = nbrs) 
                if(!is_undef(nbr[1])) // Here's a workaround for a weired undef problem. bug of 2019.05? 
                    [nbr[0], nbr[1], norm(nbr - p)]
        ],
        sorted = sort(dists, by = "z"),
        a = [sorted[0][0], sorted[0][1]],
        b = [sorted[1][0], sorted[1][1]],
        m = (a + b) / 2
    )
    (p - m) * (a - m);
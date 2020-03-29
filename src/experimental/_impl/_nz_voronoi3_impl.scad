use <experimental/_impl/_nz_worley3_impl.scad>;
use <util/sort.scad>;
    
function _nz_voronoi3(p, seed, dim, m, n, o) = 
    let(
        fcord = [floor(p[0] / m), floor(p[1] / n), floor(p[2] / o)],
        nbrs = _neighbors(fcord, seed, dim, m, n, o),
        dists = [
            for(nbr = nbrs) 
                if(!is_undef(nbr[1])) // Here's a workaround for a weired undef problem. bug of 2019.05? 
                    [nbr[0], nbr[1], nbr[2], norm(nbr - p)]
        ],
        sorted = sort(dists, by = "idx", idx = 3),
        a = [sorted[0][0], sorted[0][1], sorted[0][2]],
        b = [sorted[1][0], sorted[1][1], sorted[1][2]],
        m = (a + b) / 2        
    )
    (p - m) * (a - m);
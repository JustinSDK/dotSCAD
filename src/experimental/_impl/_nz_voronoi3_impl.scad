use <experimental/_impl/_nz_worley3_impl.scad>;
use <util/sort.scad>;
    
function _nz_voronoi3(p, seed, dim, m, n, o) = 
    let(
        fcord = [floor(p[0] / m), floor(p[1] / n), floor(p[2] / o)],
        nbrs = _neighbors(fcord, seed, dim, m, n, o),
        dists = [
            for(nbr = nbrs) 
                if(!is_undef(nbr[1])) // Here's a workaround for a weired undef problem. bug of 2019.05? 
                    [norm(nbr - p)]
        ],
        sorted = sort(dists)
    )
    sorted[1][0] - sorted[0][0];
use <experimental/_impl/_nz_worley_comm.scad>;
use <util/sort.scad>;

function _neighbors(fcord, seed, dim, m, n) = [
    for(y = [-1:1])
        for(x = [-1:1])
        let(
            nx = fcord[0] + x,
            ny = fcord[1] + y,
            sd_base = nx + ny * dim,
            sd1 = _lookup_noise_table(seed + sd_base),
            sd2 = _lookup_noise_table(sd1 * 255 + sd_base),
            nbr = [(nx + sd1) * m, (ny + sd2) * n]
        )
        nbr
];
    
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
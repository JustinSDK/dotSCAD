use <experimental/_impl/_nz_worley_comm.scad>;

function _neighbors(fcord, seed, dim, m, n, o) = [
    for(z = [-1:1])    
        for(y = [-1:1])
            for(x = [-1:1])
            let(
                nx = fcord[0] + x,
                ny = fcord[1] + y,
                nz = fcord[2] + z,
                sd_base = nx + ny * dim + nz * dim * dim,
                sd1 = _lookup_noise_table(seed + sd_base),
                sd2 = _lookup_noise_table(sd1 * 255 + sd_base),
                sd3 = _lookup_noise_table(sd2 * 255 + sd_base),
                nbr = [(nx + sd1) * m, (ny + sd2) * n, (nz + sd3) * o]
            )
            nbr
];
    
function _nz_worley3(p, seed, dim, m, n, o, dist) = 
    let(
        fcord = [floor(p[0] / m), floor(p[1] / n), floor(p[2] / o)],
        nbrs = _neighbors(fcord, seed, dim, m, n, o),
        dists = [
            for(nbr = nbrs) 
                if(!is_undef(nbr[1])) // Here's a workaround for a weired undef problem. bug of 2019.05? 
                    _distance(nbr, p, dist)
        ]
    )
    min(dists);
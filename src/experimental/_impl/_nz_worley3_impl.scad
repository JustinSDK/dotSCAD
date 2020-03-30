use <experimental/_impl/_nz_worley_comm.scad>;
use <util/sort.scad>;

function _neighbors(fcord, seed, cell_w) = [
    for(z = [-1:1])    
        for(y = [-1:1])
            for(x = [-1:1])
            let(
                nx = fcord[0] + x,
                ny = fcord[1] + y,
                nz = fcord[2] + z,
                sd_base = abs(nx + ny * cell_w + nz * cell_w * cell_w),
                sd1 = _lookup_noise_table(seed + sd_base),
                sd2 = _lookup_noise_table(sd1 * 255 + sd_base),
                sd3 = _lookup_noise_table(sd2 * 255 + sd_base),
                nbr = [(nx + sd1) * cell_w, (ny + sd2) * cell_w, (nz + sd3) * cell_w]
            )
            nbr
];

function _nz_worley3_classic(p, nbrs, dist) = 
    min([
        for(nbr = nbrs) 
            if(!is_undef(nbr[1])) // Here's a workaround for a weired undef problem. bug of 2019.05? 
                _distance(nbr, p, dist)
    ]);

function _nz_worley3_border(p, nbrs, dist) = 
    let(
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
    
function _nz_worley3(p, seed, cell_w, dist) = 
    let(
        fcord = [floor(p[0] / cell_w), floor(p[1] / cell_w), floor(p[2] / cell_w)],
        nbrs = _neighbors(fcord, seed, cell_w)
    )
    dist == "border" ? _nz_worley3_border(p, nbrs, dist) :
                       _nz_worley3_classic(p, nbrs, dist);
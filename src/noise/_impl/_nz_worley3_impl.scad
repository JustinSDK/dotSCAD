use <noise/_impl/_nz_worley_comm.scad>;
use <util/sort.scad>;

function _neighbors(fcord, seed, tile_w) = [
    for(z = [-1:1])    
        for(y = [-1:1])
            for(x = [-1:1])
            let(
                nx = fcord[0] + x,
                ny = fcord[1] + y,
                nz = fcord[2] + z,
                sd_base = abs(nx + ny * tile_w + nz * tile_w * tile_w),
                sd1 = _lookup_noise_table(seed + sd_base),
                sd2 = _lookup_noise_table(sd1 * 255 + sd_base),
                sd3 = _lookup_noise_table(sd2 * 255 + sd_base),
                nbr = [(nx + sd1) * tile_w, (ny + sd2) * tile_w, (nz + sd3) * tile_w]
            )
            nbr
];

function _nz_worley3_classic(p, nbrs, dist) =
    let(
        cells = [
            for(nbr = nbrs) 
                [nbr[0], nbr[1], nbr[2], _distance(nbr, p, dist)]
        ],
        sorted = sort(cells, by = "idx", idx = 3)
    )
    sorted[0];

function _nz_worley3_border(p, nbrs) = 
    let(
        cells = [
            for(nbr = nbrs) 
                [nbr[0], nbr[1], nbr[2], norm(nbr - p)]
        ],
        sorted = sort(cells, by = "idx", idx = 3),
        a = [sorted[0][0], sorted[0][1], sorted[0][2]],
        b = [sorted[1][0], sorted[1][1], sorted[1][2]],
        m = (a + b) / 2        
    )
    [a[0], a[1], a[2], (p - m) * (a - m)];
    
function _nz_worley3(p, seed, tile_w, dist) = 
    let(
        fcord = [floor(p[0] / tile_w), floor(p[1] / tile_w), floor(p[2] / tile_w)],
        nbrs = _neighbors(fcord, seed, tile_w)
    )
    dist == "border" ? _nz_worley3_border(p, nbrs) :
                       _nz_worley3_classic(p, nbrs, dist);
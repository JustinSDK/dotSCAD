use <experimental/_impl/_nz_worley_comm.scad>;
use <util/sort.scad>;

function _neighbors(fcord, seed, cell_w) = [
    for(y = [-1:1])
        for(x = [-1:1])
        let(
            nx = fcord[0] + x,
            ny = fcord[1] + y,
            sd_base = abs(nx + ny * cell_w),
            sd1 = _lookup_noise_table(seed + sd_base),
            sd2 = _lookup_noise_table(sd1 * 255 + sd_base),
            nbr = [(nx + sd1) * cell_w, (ny + sd2) * cell_w]
        )
        nbr
];

function _nz_worley2_classic(p, nbrs, dist) = 
    min([
        for(nbr = nbrs) 
            _distance(nbr, p, dist)
    ]);

function _nz_worley2_border(p, nbrs, dist) = 
    let(
        cells = [
            for(nbr = nbrs) 
                [nbr[0], nbr[1], norm(nbr - p)]
        ],
        sorted = sort(cells, by = "z"),
        a = [sorted[0][0], sorted[0][1]],
        b = [sorted[1][0], sorted[1][1]],
        m = (a + b) / 2
    )
    (p - m) * (a - m);
    
function _nz_worley2(p, seed, cell_w, dist) = 
    let(
        fcord = [floor(p[0] / cell_w), floor(p[1] / cell_w)],
        nbrs = _neighbors(fcord, seed, cell_w)
    )
    dist == "border" ? _nz_worley2_border(p, nbrs, dist) : 
                       _nz_worley2_classic(p, nbrs, dist);
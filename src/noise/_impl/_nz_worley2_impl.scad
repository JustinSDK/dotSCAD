use <_nz_worley_comm.scad>;
use <../../util/sort.scad>;

function _neighbors(fcord, seed, grid_w) = 
    let(range = [-1:1])
    [
        for(y = range, x = range)
        let(
            nx = fcord.x + x,
            ny = fcord.y + y,
            sd_base = abs(nx + ny * grid_w),
            sd1 = _lookup_noise_table(seed + sd_base),
            sd2 = _lookup_noise_table(sd1 * 255 + sd_base),
            nbr = [(nx + sd1) * grid_w, (ny + sd2) * grid_w]
        )
        nbr
    ];

function _nz_worley2_classic(p, nbrs, dist) = 
    let(
        cells = dist == "euclidean" ? [for(nbr = nbrs) [each nbr, norm(nbr - p)]] :
                dist == "manhattan" ? [for(nbr = nbrs) [each nbr, _manhattan(nbr - p)]]  :
                dist == "chebyshev" ? [for(nbr = nbrs) [each nbr, _chebyshev(nbr, p)]] : 
                               assert("Unknown distance option"),     
        sorted = sort(cells, by = "idx", idx = 2)
    )
    sorted[0];

function _nz_worley2_border(p, nbrs) = 
    let(
        cells = [
            for(nbr = nbrs) 
                [each nbr, norm(nbr - p)]
        ],
        sorted = sort(cells, by = "z"),
        a = [sorted[0].x, sorted[0].y],
        m = (a + [sorted[1].x, sorted[1].y]) / 2
    )
    [a[0], a[1], (p - m) * (a - m)];
    
function _nz_worley2(p, seed, grid_w, dist) = 
    let(
        fcord = [floor(p.x / grid_w), floor(p.y / grid_w)],
        nbrs = _neighbors(fcord, seed, grid_w)
    )
    dist == "border" ? _nz_worley2_border(p, nbrs) : 
                       _nz_worley2_classic(p, nbrs, dist);
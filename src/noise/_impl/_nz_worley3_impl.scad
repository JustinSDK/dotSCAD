use <_nz_worley_comm.scad>;
use <../../util/sorted.scad>;

_cmp = function(a, b) a[3] - b[3];

function _neighbors(fcord, seed, grid_w) = 
    let(range = [-1:1])
    [
        for(z = range, y = range, x = range)
        let(
            nx = fcord.x + x,
            ny = fcord.y + y,
            nz = fcord.z + z,
            sd_base = abs(nx + ny * grid_w + nz * grid_w * grid_w),
            sd1 = _lookup_noise_table(seed + sd_base),
            sd2 = _lookup_noise_table(sd1 * 255 + sd_base),
            sd3 = _lookup_noise_table(sd2 * 255 + sd_base),
            nbr = [(nx + sd1) * grid_w, (ny + sd2) * grid_w, (nz + sd3) * grid_w]
        )
        nbr
    ];

function _nz_worley3_classic(p, nbrs, dist) =
    let(
        cells = dist == "euclidean" ? [for(nbr = nbrs) [each nbr, norm(nbr - p)]] :
                dist == "manhattan" ? [for(nbr = nbrs) [each nbr, _manhattan(nbr - p)]]  :
                dist == "chebyshev" ? [for(nbr = nbrs) [each nbr, _chebyshev(nbr, p)]] : 
                               assert("Unknown distance option")   
    )
    sorted(cells, _cmp)[0];

function _nz_worley3_border(p, nbrs) = 
    let(
        cells = [
            for(nbr = nbrs) 
                [each nbr, norm(nbr - p)]
        ],
        sorted_cells = sorted(cells, _cmp),
        a = [sorted_cells[0].x, sorted_cells[0].y, sorted_cells[0].z],
        m = (a + [sorted_cells[1].x, sorted_cells[1].y, sorted_cells[1].z]) / 2        
    )
    [a[0], a[1], a[2], (p - m) * (a - m)];
    
function _nz_worley3(p, seed, grid_w, dist) = 
    let(
        fcord = [floor(p.x / grid_w), floor(p.y / grid_w), floor(p.z / grid_w)],
        nbrs = _neighbors(fcord, seed, grid_w)
    )
    dist == "border" ? _nz_worley3_border(p, nbrs) :
                       _nz_worley3_classic(p, nbrs, dist);
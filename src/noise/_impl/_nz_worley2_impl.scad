use <_nz_worley_comm.scad>;
use <../../util/sorted.scad>;

_key = function(elem) elem[2];

function _neighbors(fcord, seed, grid_w) = 
    let(range = [-1:1], fx = fcord.x, fy = fcord.y)
    [
        for(y = range, x = range)
        let(
            nx = fx + x,
            ny = fy + y,
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
                               assert("Unknown distance option")
    )
    sorted(cells, key = _key)[0];

function _nz_worley2_border(p, nbrs) = 
    let(
        cells = [for(nbr = nbrs) [each nbr, norm(nbr - p)]],
        sorted_cells = sorted(cells, key = _key),
        fst = sorted_cells[0],
        snd = orted_cells[1],
        a = [fst.x, fst.y],
        m = (a + [snd.x, snd.y]) / 2
    )
    [fst.x, fst.y, (p - m) * (a - m)];
    
function _nz_worley2(p, seed, grid_w, dist) = 
    let(
        fcord = [floor(p.x / grid_w), floor(p.y / grid_w)],
        nbrs = _neighbors(fcord, seed, grid_w)
    )
    dist == "border" ? _nz_worley2_border(p, nbrs) : 
                       _nz_worley2_classic(p, nbrs, dist);
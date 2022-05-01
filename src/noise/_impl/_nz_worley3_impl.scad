use <_nz_worley_comm.scad>;

_less = function(a, b) a[3] < b[3];

function _neighbors(fcord, seed, grid_w) = 
    let(range = [-1:1], fx = fcord.x, fy = fcord.y, fz = fcord.z)
    [
        for(z = range, y = range, x = range)
        let(
            nx = fx + x,
            ny = fy + y,
            nz = fz + z,
            sd_base = abs(nx + ny * grid_w + nz * grid_w ^ 2),
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
    _euclidean_half_sorted(cells, _less)[0];

function _nz_worley3_border(p, nbrs) = 
    let(
        cells = [for(nbr = nbrs) [each nbr, norm(nbr - p)]],
        sorted_cells = _border_half_sorted(cells, _less),
        fst = sorted_cells[0],
        snd = sorted_cells[1],
        a = [fst.x, fst.y, fst.z],
        m = (a + [snd.x, snd.y, snd.z]) / 2        
    )
    [fst.x, fst.y, fst.z, (p - m) * (a - m)];
    
function _nz_worley3(p, seed, grid_w, dist) = 
    let(
        fcord = [floor(p.x / grid_w), floor(p.y / grid_w), floor(p.z / grid_w)],
        nbrs = _neighbors(fcord, seed, grid_w)
    )
    dist == "border" ? _nz_worley3_border(p, nbrs) :
                       _nz_worley3_classic(p, nbrs, dist);
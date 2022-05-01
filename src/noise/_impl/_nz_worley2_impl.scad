use <_nz_worley_comm.scad>;

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

function _nz_worley2(p, seed, grid_w, dist) = 
    let(
        fcord = [floor(p.x / grid_w), floor(p.y / grid_w)],
        nbrs = _neighbors(fcord, seed, grid_w)
    )
    dist == "border" ? _nz_worley_border(p, nbrs) : 
                       _nz_worley_classic(p, nbrs, dist);
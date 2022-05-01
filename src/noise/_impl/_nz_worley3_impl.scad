use <_nz_worley_comm.scad>;

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

function _nz_worley3(p, seed, grid_w, dist) = 
    let(
        fcord = [floor(p.x / grid_w), floor(p.y / grid_w), floor(p.z / grid_w)],
        nbrs = _neighbors(fcord, seed, grid_w)
    )
    dist == "border" ? _nz_worley_border(p, nbrs) :
                       _nz_worley_classic(p, nbrs, dist);
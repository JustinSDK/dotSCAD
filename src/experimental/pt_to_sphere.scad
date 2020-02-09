use <rotate_p.scad>;

function pt_to_sphere(p, size, r, angle = [180, 360]) =
    let(
        x = p[0],
        y = p[1],
        za = angle[0],
        xa = angle[1],
        xlen = size[0],
        ylen = size[1],
        za_step = za / ylen,
        rza = za_step * y,
        rzpt = [r * cos(rza), r * sin(rza), 0],
        rxpt = rotate_p(rzpt, [xa / xlen * x, 0, 0])
    )
    rxpt;
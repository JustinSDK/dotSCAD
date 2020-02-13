use <rotate_p.scad>;

/*
    size: The size of the rectangle mapping to a sphere.
    point: A point in the rectangle.
    radius: sphere radius.
    angle: [za, xa] mapping angles.
*/
function tf_sphere(size, point, radius, angle = [180, 360]) =
    let(
        x = point[0],
        y = point[1],
        za = angle[0],  
        xa = angle[1], 
        xlen = size[0],
        ylen = size[1],
        za_step = za / ylen,
        rza = za_step * y,
        rzpt = [radius * cos(rza), radius * sin(rza), 0],       
        rxpt = rotate_p(rzpt, [xa / xlen * x, 0, 0])   
    )
    rxpt;
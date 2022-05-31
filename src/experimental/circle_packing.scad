use <triangle/tri_delaunay.scad>;
use <triangle/tri_incenter.scad>;

function circle_packing(points, density = 1, min_r = 1) =
    [
        for(t = tri_delaunay(points, ret = "TRI_SHAPES"))
        each circle_packing_triangle(t, density, min_r)
    ];

function circle_packing_triangle(t, density, min_r) =
    let(
        center = tri_incenter(t),
        s1 = t[1] - t[0],
        s2 = t[2] - t[1],
        s3 = t[0] - t[2],
        leng_s1 = norm(s1),
        leng_s2 = norm(s2),
        leng_s3 = norm(s3),
        R = abs(cross(s1, s2)) / (leng_s1 + leng_s2 + leng_s3),
        r = function(sin, leng_cv, pre_R) sin * (leng_cv - pre_R) / (1 + sin),
        ca = center - t[0],
        leng_ca = norm(ca),
        unit_ca = ca / leng_ca,
        sina = R / leng_ca,
        cb = center - t[1],
        leng_cb = norm(cb),
        unit_cb = cb / leng_cb,
        sinb = R / leng_cb,
        cc = center - t[2],
        leng_cc = norm(cc),
        unit_cc = cc / leng_cc,
        sinc = R / leng_cc,
        _small_circles = function(density, pre_Ra = R, pre_Rb = R, pre_Rc = R) 
            density <= 0 ? [] :
            let(
                ra = r(sina, leng_ca, pre_Ra),
                Ra = pre_Ra + ra,
                rb = r(sinb, leng_cb, pre_Rb),
                Rb = pre_Rb + rb,
                rc = r(sinc, leng_cc, pre_Rc),
                Rc = pre_Rc + rc
            )
            [
                if(ra > min_r) [center - unit_ca * Ra, ra], 
                if(rb > min_r) [center - unit_cb * Rb, rb], 
                if(rc > min_r) [center - unit_cc * Rc, rc], 
                each _small_circles(density - 1, ra + Ra, rb + Rb, rc + Rc)]
    )
    [[center, R], each _small_circles(density - 1)];

/*
use <experimental/circle_packing.scad>;

$fn = 24;
density = 4;
min_r = 1;
points = [for(i = [0:100]) rands(-100, 100, 2)]; 

for(c = circle_packing(points, density, min_r)) {
    translate(c[0])
        sphere(c[1]);
}
*/
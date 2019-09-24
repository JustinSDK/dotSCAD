// https://www.cs.purdue.edu/homes/gnf/book2/trisqu.html
function triangle2square(tri_side_leng) = 
    let(
        p0 = [0, 0],
        p1 = tri_side_leng * [0.25, 0.4330125],
        p2 = tri_side_leng * [0.5, 0.8660255],
        p4 = tri_side_leng * [1, 0],
        p3 = tri_side_leng * [0.75, 0.4330125],
        p6 = tri_side_leng * [0.254508, 0],
        p5 = tri_side_leng * [0.754508, 0],
        p8 = tri_side_leng * [0.5380015, 0.247745],
        p7 = tri_side_leng * [0.4665065, 0.1852665],
        pieces = [
            [p0, p6, p7, p1],
            [p6, p5, p8],
            [p5, p4, p3, p8],
            [p1, p7, p3, p2]
        ],
        hinged_pts = [p5, p3, p1]
    )
    [pieces, hinged_pts];
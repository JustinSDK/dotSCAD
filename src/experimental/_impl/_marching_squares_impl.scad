function pn_label(pts, sigma) =
    [
        for(row = pts)
        [for(p = row) [p[0], p[1], p[2], p[2] - sigma >= 0]]
    ]; 
    
function corner_value(cell_pts) =
    let(
        c0 = cell_pts[0][3] ? 1 : 0,
        c1 = cell_pts[1][3] ? 2 : 0,
        c2 = cell_pts[2][3] ? 4 : 0,
        c3 = cell_pts[3][3] ? 8 : 0
    )
    c0 + c1 + c2 + c3;

function interpolated_pt(p0, p1, sigma) =
    let(
        x0 = p0[0],
        y0 = p0[1],
        z0 = p0[2],
        v = p1 - p0,
        t = (sigma - z0) / v[2]
    )
    [x0 + v[0] * t, y0 + v[1] * t];

function case1_contours(cell_pts, sigma) = [
    [interpolated_pt(cell_pts[0], cell_pts[1], sigma), interpolated_pt(cell_pts[0], cell_pts[3], sigma)]
];

function case2_contours(cell_pts, sigma) = [
    [interpolated_pt(cell_pts[0], cell_pts[3], sigma), interpolated_pt(cell_pts[2], cell_pts[3], sigma)]
];

function case3_contours(cell_pts, sigma) = [
    [interpolated_pt(cell_pts[0], cell_pts[1], sigma), interpolated_pt(cell_pts[2], cell_pts[3], sigma)]
];

function case4_contours(cell_pts, sigma) = [
    [interpolated_pt(cell_pts[1], cell_pts[2], sigma), interpolated_pt(cell_pts[2], cell_pts[3], sigma)]
];

function case5_contours(cell_pts, sigma) = [
    [interpolated_pt(cell_pts[0], cell_pts[1], sigma), interpolated_pt(cell_pts[1], cell_pts[2], sigma)],
    [interpolated_pt(cell_pts[0], cell_pts[3], sigma), interpolated_pt(cell_pts[2], cell_pts[3], sigma)]
];

function case6_contours(cell_pts, sigma) = [
    [interpolated_pt(cell_pts[1], cell_pts[2], sigma), interpolated_pt(cell_pts[0], cell_pts[3], sigma)]
];

function case7_contours(cell_pts, sigma) = [
    [interpolated_pt(cell_pts[0], cell_pts[1], sigma), interpolated_pt(cell_pts[1], cell_pts[2], sigma)]
];
    
function case8_contours(cell_pts, sigma) = case7_contours(cell_pts, sigma);

function case9_contours(cell_pts, sigma) = case6_contours(cell_pts, sigma);

function case10_contours(cell_pts, sigma) = [
    [interpolated_pt(cell_pts[0], cell_pts[1], sigma), interpolated_pt(cell_pts[0], cell_pts[3], sigma)],
    [interpolated_pt(cell_pts[1], cell_pts[2], sigma), interpolated_pt(cell_pts[2], cell_pts[3], sigma)]
];
    
function case11_contours(cell_pts, sigma) = case4_contours(cell_pts, sigma);

function case12_contours(cell_pts, sigma) = case3_contours(cell_pts, sigma);

function case13_contours(cell_pts, sigma) = case2_contours(cell_pts, sigma);

function case14_contours(cell_pts, sigma) = case1_contours(cell_pts, sigma);

function contours_of(cell_pts, sigma) =
    let(cv = corner_value(cell_pts))
    cv == 0  ? [] :
    cv == 1  ? case1_contours(cell_pts, sigma) :
    cv == 8  ? case2_contours(cell_pts, sigma) :
    cv == 9  ? case3_contours(cell_pts, sigma) :
    cv == 4  ? case4_contours(cell_pts, sigma) :
    cv == 5  ? case5_contours(cell_pts, sigma) :
    cv == 12 ? case6_contours(cell_pts, sigma) :
    cv == 13 ? case7_contours(cell_pts, sigma) :
    cv == 2  ? case8_contours(cell_pts, sigma) :
    cv == 3  ? case9_contours(cell_pts, sigma) :
    cv == 10 ? case10_contours(cell_pts, sigma) :
    cv == 11 ? case11_contours(cell_pts, sigma) :
    cv == 6  ? case12_contours(cell_pts, sigma) :
    cv == 7  ? case13_contours(cell_pts, sigma) :
    cv == 14 ? case14_contours(cell_pts, sigma) : [];

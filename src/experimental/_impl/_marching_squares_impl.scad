function _isolines_pn_label(pts, sigma) =
    [
        for(row = pts)
        [for(p = row) [p[0], p[1], p[2], p[2] - sigma >= 0]]
    ]; 
    
function _isolines_corner_value(cell_pts) =
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

function _case1_isolines(cell_pts, sigma) = [
    [interpolated_pt(cell_pts[0], cell_pts[1], sigma), interpolated_pt(cell_pts[0], cell_pts[3], sigma)]
];

function _case2_isolines(cell_pts, sigma) = [
    [interpolated_pt(cell_pts[0], cell_pts[3], sigma), interpolated_pt(cell_pts[2], cell_pts[3], sigma)]
];

function _case3_isolines(cell_pts, sigma) = [
    [interpolated_pt(cell_pts[0], cell_pts[1], sigma), interpolated_pt(cell_pts[2], cell_pts[3], sigma)]
];

function _case4_isolines(cell_pts, sigma) = [
    [interpolated_pt(cell_pts[1], cell_pts[2], sigma), interpolated_pt(cell_pts[2], cell_pts[3], sigma)]
];

function _case5_isolines(cell_pts, sigma) = 
    let(mdpz = ((cell_pts[0] + cell_pts[1]) / 2)[2])
    mdpz >= sigma ?
    [
        [interpolated_pt(cell_pts[0], cell_pts[1], sigma), interpolated_pt(cell_pts[1], cell_pts[2], sigma)],
        [interpolated_pt(cell_pts[0], cell_pts[3], sigma), interpolated_pt(cell_pts[2], cell_pts[3], sigma)]
    ]
    :
    [
        [interpolated_pt(cell_pts[0], cell_pts[1], sigma), interpolated_pt(cell_pts[0], cell_pts[3], sigma)],
        [interpolated_pt(cell_pts[1], cell_pts[2], sigma), interpolated_pt(cell_pts[2], cell_pts[3], sigma)]
    ];

function _case6_isolines(cell_pts, sigma) = [
    [interpolated_pt(cell_pts[1], cell_pts[2], sigma), interpolated_pt(cell_pts[0], cell_pts[3], sigma)]
];

function _case7_isolines(cell_pts, sigma) = [
    [interpolated_pt(cell_pts[0], cell_pts[1], sigma), interpolated_pt(cell_pts[1], cell_pts[2], sigma)]
];
    
function _case8_isolines(cell_pts, sigma) = _case7_isolines(cell_pts, sigma);

function _case9_isolines(cell_pts, sigma) = _case6_isolines(cell_pts, sigma);

function _case10_isolines(cell_pts, sigma) = 
    let(mdpz = ((cell_pts[0] + cell_pts[1]) / 2)[2])
    mdpz >= sigma ?
        [
            [interpolated_pt(cell_pts[0], cell_pts[1], sigma), interpolated_pt(cell_pts[0], cell_pts[3], sigma)],
            [interpolated_pt(cell_pts[1], cell_pts[2], sigma), interpolated_pt(cell_pts[2], cell_pts[3], sigma)]
        ]
        :
        [
            [interpolated_pt(cell_pts[0], cell_pts[1], sigma), interpolated_pt(cell_pts[1], cell_pts[2], sigma)],
            [interpolated_pt(cell_pts[0], cell_pts[3], sigma), interpolated_pt(cell_pts[2], cell_pts[3], sigma)]
        ];
    
function _case11_isolines(cell_pts, sigma) = _case4_isolines(cell_pts, sigma);

function _case12_isolines(cell_pts, sigma) = _case3_isolines(cell_pts, sigma);

function _case13_isolines(cell_pts, sigma) = _case2_isolines(cell_pts, sigma);

function _case14_isolines(cell_pts, sigma) = _case1_isolines(cell_pts, sigma);

function _isolines_of(cell_pts, sigma) =
    let(cv = _isolines_corner_value(cell_pts))
    cv == 0  ? [] :
    cv == 1  ? _case1_isolines(cell_pts, sigma) :
    cv == 8  ? _case2_isolines(cell_pts, sigma) :
    cv == 9  ? _case3_isolines(cell_pts, sigma) :
    cv == 4  ? _case4_isolines(cell_pts, sigma) :
    cv == 5  ? _case5_isolines(cell_pts, sigma) :
    cv == 12 ? _case6_isolines(cell_pts, sigma) :
    cv == 13 ? _case7_isolines(cell_pts, sigma) :
    cv == 2  ? _case8_isolines(cell_pts, sigma) :
    cv == 3  ? _case9_isolines(cell_pts, sigma) :
    cv == 10 ? _case10_isolines(cell_pts, sigma) :
    cv == 11 ? _case11_isolines(cell_pts, sigma) :
    cv == 6  ? _case12_isolines(cell_pts, sigma) :
    cv == 7  ? _case13_isolines(cell_pts, sigma) :
    cv == 14 ? _case14_isolines(cell_pts, sigma) : [];

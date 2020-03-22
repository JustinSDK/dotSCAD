function interpolated_pt(p0, p1, sigma) =
    let(
        x0 = p0[0],
        y0 = p0[1],
        z0 = p0[2],
        v = p1 - p0,
        t = (sigma - z0) / v[2]
    )
    [x0 + v[0] * t, y0 + v[1] * t, sigma];

/*
    ISOLINES Impl Begin ============================
*/

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
    let(mdpz = (cell_pts[0][2] + cell_pts[1][2] + cell_pts[2][2] + cell_pts[3][2]) / 4)
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
    let(mdpz = (cell_pts[0][2] + cell_pts[1][2] + cell_pts[2][2] + cell_pts[3][2]) / 4)
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
    cv == 0 || cv == 15  ? [] :
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
               _case14_isolines(cell_pts, sigma);

function _marching_squares_isolines(points, sigma) = 
    let(labeled_pts = _isolines_pn_label(points, sigma))
    [
        for(y = [0:len(labeled_pts) - 2])
            [
                 for(x = [0:len(labeled_pts[0]) - 2])
                 let(
                    p0 = labeled_pts[y][x],
                    p1 = labeled_pts[y + 1][x],
                    p2 = labeled_pts[y + 1][x + 1],
                    p3 = labeled_pts[y][x + 1],
                    cell_pts = [p0, p1, p2, p3],
                    isolines_lt = _isolines_of(cell_pts, sigma)
                 )
                 if(isolines_lt != [])
                 each isolines_lt
           ]
    ];               

/*
    ISOLINES Impl End ============================
*/

/*
    ISOBANDS Impl Begin ============================
*/

function _isobands_tri_label(pts, lower, upper) =
    [
        for(row = pts)
        [
            for(p = row) 
            let(label = 
                p[2] < lower ? "0" : 
                p[2] >= lower && p[2] < upper ? "1" : "2"
            )
            [p[0], p[1], p[2], label]
        ]
    ]; 
    
function _isobands_corner_value(cell_pts) =
    str(cell_pts[1][3], cell_pts[2][3], cell_pts[3][3], cell_pts[0][3]); 

// single triangle
function _case2221_isobands(cell_pts, sigma) = [
    [
        [cell_pts[0][0], cell_pts[0][1], cell_pts[0][2]],
        interpolated_pt(cell_pts[0], cell_pts[3], sigma),
        interpolated_pt(cell_pts[0], cell_pts[1], sigma)
    ]
];

function _case2212_isobands(cell_pts, sigma) = [
    [
        interpolated_pt(cell_pts[0], cell_pts[3], sigma),
        [cell_pts[3][0], cell_pts[3][1], cell_pts[3][2]],
        interpolated_pt(cell_pts[2], cell_pts[3], sigma)
    ]
];

function _case2122_isobands(cell_pts, sigma) = [
    [
        interpolated_pt(cell_pts[1], cell_pts[2], sigma),
        interpolated_pt(cell_pts[2], cell_pts[3], sigma),
        [cell_pts[2][0], cell_pts[2][1], cell_pts[2][2]]
    ]
];
    
function _case1222_isobands(cell_pts, sigma) = [
    [
        interpolated_pt(cell_pts[0], cell_pts[1], sigma),
        interpolated_pt(cell_pts[1], cell_pts[2], sigma),
        [cell_pts[1][0], cell_pts[1][1], cell_pts[1][2]]
    ]
];

function _case0001_isobands(cell_pts, sigma) = 
    _case2221_isobands(cell_pts, sigma);
    
function _case0010_isobands(cell_pts, sigma) = 
    _case2212_isobands(cell_pts, sigma);
    
function _case0100_isobands(cell_pts, sigma) = 
    _case2122_isobands(cell_pts, sigma);

function _case1000_isobands(cell_pts, sigma) = 
    _case1222_isobands(cell_pts, sigma);
    
 // single trapezoid
function _case2220_isobands(cell_pts, lower, upper) = [
    [
        interpolated_pt(cell_pts[0], cell_pts[1], lower),
        interpolated_pt(cell_pts[0], cell_pts[3], lower),
        interpolated_pt(cell_pts[0], cell_pts[3], upper),
        interpolated_pt(cell_pts[0], cell_pts[1], upper)
    ]
];

function _case2202_isobands(cell_pts, lower, upper) = [
    [
        interpolated_pt(cell_pts[0], cell_pts[3], upper),
        interpolated_pt(cell_pts[0], cell_pts[3], lower),
        interpolated_pt(cell_pts[2], cell_pts[3], lower),
        interpolated_pt(cell_pts[2], cell_pts[3], upper)
    ]
];

function _case2022_isobands(cell_pts, lower, upper) = [
    [
        interpolated_pt(cell_pts[0], cell_pts[1], upper),
        interpolated_pt(cell_pts[1], cell_pts[2], upper),
        interpolated_pt(cell_pts[1], cell_pts[2], lower),
        interpolated_pt(cell_pts[0], cell_pts[1], lower)
    ]
];
    
function _case0222_isobands(cell_pts, lower, upper) = [
    [
        interpolated_pt(cell_pts[1], cell_pts[2], upper),
        interpolated_pt(cell_pts[2], cell_pts[3], upper),
        interpolated_pt(cell_pts[2], cell_pts[3], lower),
        interpolated_pt(cell_pts[1], cell_pts[2], lower)
    ]
];
    
function _case0002_isobands(cell_pts, lower, upper) = 
    _case2220_isobands(cell_pts, upper, lower);

function _case0020_isobands(cell_pts, lower, upper) = 
    _case2202_isobands(cell_pts, upper, lower);
    
function _case0200_isobands(cell_pts, lower, upper) = 
    _case2022_isobands(cell_pts, upper, lower);

function _case2000_isobands(cell_pts, lower, upper) = 
    _case0222_isobands(cell_pts, upper, lower);
    
// single rectangle    
function _case0011_isobands(cell_pts, sigma) = [
    [
        [cell_pts[0][0], cell_pts[0][1], cell_pts[0][2]],
        [cell_pts[3][0], cell_pts[3][1], cell_pts[3][2]],
        interpolated_pt(cell_pts[2], cell_pts[3], sigma),
        interpolated_pt(cell_pts[0], cell_pts[1], sigma)
    ]
];
    
function _case0110_isobands(cell_pts, sigma) = [
    [
        interpolated_pt(cell_pts[0], cell_pts[3], sigma),
        [cell_pts[3][0], cell_pts[3][1], cell_pts[3][2]],
        [cell_pts[2][0], cell_pts[2][1], cell_pts[2][2]],
        interpolated_pt(cell_pts[1], cell_pts[2], sigma)
    ]
];

function _case1100_isobands(cell_pts, sigma) = [
    [
        interpolated_pt(cell_pts[0], cell_pts[1], sigma),
        interpolated_pt(cell_pts[2], cell_pts[3], sigma),
        [cell_pts[2][0], cell_pts[2][1], cell_pts[2][2]],
        [cell_pts[1][0], cell_pts[1][1], cell_pts[1][2]]
    ]
];

function _case1001_isobands(cell_pts, sigma) = [
    [
        [cell_pts[0][0], cell_pts[0][1], cell_pts[0][2]],
        interpolated_pt(cell_pts[0], cell_pts[3], sigma),
        interpolated_pt(cell_pts[1], cell_pts[2], sigma),
        [cell_pts[1][0], cell_pts[1][1], cell_pts[1][2]]
    ]
];

function _case2211_isobands(cell_pts, sigma) = 
    _case0011_isobands(cell_pts, sigma);
    
function _case2112_isobands(cell_pts, sigma) = 
    _case0110_isobands(cell_pts, sigma);    

function _case1122_isobands(cell_pts, sigma) = 
    _case1100_isobands(cell_pts, sigma);        

function _case1221_isobands(cell_pts, sigma) = 
    _case1001_isobands(cell_pts, sigma);   
        
function _case2200_isobands(cell_pts, lower, upper) = [
    [
        interpolated_pt(cell_pts[0], cell_pts[1], lower),
        interpolated_pt(cell_pts[2], cell_pts[3], lower),
        interpolated_pt(cell_pts[2], cell_pts[3], upper),
        interpolated_pt(cell_pts[0], cell_pts[1], upper)
    ]
];

function _case2002_isobands(cell_pts, lower, upper) = [
    [
        interpolated_pt(cell_pts[0], cell_pts[3], upper),
        interpolated_pt(cell_pts[0], cell_pts[3], lower),
        interpolated_pt(cell_pts[1], cell_pts[2], lower),
        interpolated_pt(cell_pts[1], cell_pts[2], upper)
    ]
];
        
function _case0022_isobands(cell_pts, lower, upper) = 
    _case2200_isobands(cell_pts, upper, lower);

function _case0220_isobands(cell_pts, lower, upper) = 
    _case2002_isobands(cell_pts, upper, lower);

// single hexagon
function _case0211_isobands(cell_pts, lower, upper) = [
    [
        [cell_pts[0][0], cell_pts[0][1], cell_pts[0][2]],
        [cell_pts[3][0], cell_pts[3][1], cell_pts[3][2]],
        interpolated_pt(cell_pts[2], cell_pts[3], upper),
        interpolated_pt(cell_pts[1], cell_pts[2], upper),
        interpolated_pt(cell_pts[1], cell_pts[2], lower),
        interpolated_pt(cell_pts[0], cell_pts[1], lower)
    ]
];
    
function _case2110_isobands(cell_pts, lower, upper) = [
    [
        interpolated_pt(cell_pts[0], cell_pts[1], lower),
        interpolated_pt(cell_pts[0], cell_pts[3], lower),
        [cell_pts[3][0], cell_pts[3][1], cell_pts[3][2]],
        [cell_pts[2][0], cell_pts[2][1], cell_pts[2][2]],
        interpolated_pt(cell_pts[1], cell_pts[2], upper),
        interpolated_pt(cell_pts[0], cell_pts[1], upper)
    ]
];

function _case1102_isobands(cell_pts, lower, upper) = [
    [
        interpolated_pt(cell_pts[0], cell_pts[1], upper),
        interpolated_pt(cell_pts[0], cell_pts[3], upper),
        interpolated_pt(cell_pts[0], cell_pts[3], lower),
        interpolated_pt(cell_pts[2], cell_pts[3], lower),
        [cell_pts[2][0], cell_pts[2][1], cell_pts[2][2]],
        [cell_pts[1][0], cell_pts[1][1], cell_pts[1][2]]
    ]
];

function _case1021_isobands(cell_pts, lower, upper) = [
    [
        [cell_pts[0][0], cell_pts[0][1], cell_pts[0][2]],    
        interpolated_pt(cell_pts[0], cell_pts[3], upper),
        interpolated_pt(cell_pts[2], cell_pts[3], upper),
        interpolated_pt(cell_pts[2], cell_pts[3], lower),
        interpolated_pt(cell_pts[1], cell_pts[2], lower),
        [cell_pts[1][0], cell_pts[1][1], cell_pts[1][2]]
    ]
];
    
function _case2011_isobands(cell_pts, lower, upper) = 
    _case0211_isobands(cell_pts, upper, lower);    

function _case0112_isobands(cell_pts, lower, upper) = 
    _case2110_isobands(cell_pts, upper, lower);    
    
function _case1120_isobands(cell_pts, lower, upper) = 
    _case1102_isobands(cell_pts, upper, lower);    
    
function _case1201_isobands(cell_pts, lower, upper) = 
    _case1021_isobands(cell_pts, upper, lower);    
    
function _case2101_isobands(cell_pts, lower, upper) = [
    [
        [cell_pts[0][0], cell_pts[0][1], cell_pts[0][2]],    
        interpolated_pt(cell_pts[0], cell_pts[3], lower),
        interpolated_pt(cell_pts[2], cell_pts[3], lower),
        [cell_pts[2][0], cell_pts[2][1], cell_pts[2][2]],
        interpolated_pt(cell_pts[1], cell_pts[2], upper),
        interpolated_pt(cell_pts[0], cell_pts[1], upper)
    ]
];    

function _case0121_isobands(cell_pts, lower, upper) = 
    _case2101_isobands(cell_pts, upper, lower);   
    
function _case1012_isobands(cell_pts, lower, upper) = [
    [
        interpolated_pt(cell_pts[0], cell_pts[3], upper),
        [cell_pts[3][0], cell_pts[3][1], cell_pts[3][2]],  
        interpolated_pt(cell_pts[2], cell_pts[3], lower),
        interpolated_pt(cell_pts[1], cell_pts[2], lower),
        [cell_pts[1][0], cell_pts[1][1], cell_pts[1][2]],  
        interpolated_pt(cell_pts[0], cell_pts[1], upper)
    ]
];        
    
function _case1210_isobands(cell_pts, lower, upper) = 
    _case1012_isobands(cell_pts, upper, lower);   

// single pentagon
function _case1211_isobands(cell_pts, sigma) = [
    [
        [cell_pts[0][0], cell_pts[0][1], cell_pts[0][2]],
        [cell_pts[3][0], cell_pts[3][1], cell_pts[3][2]],
        interpolated_pt(cell_pts[2], cell_pts[3], sigma),
        interpolated_pt(cell_pts[1], cell_pts[2], sigma),
        [cell_pts[1][0], cell_pts[1][1], cell_pts[1][2]]
    ]
];

function _case2111_isobands(cell_pts, sigma) = [
    [
        [cell_pts[0][0], cell_pts[0][1], cell_pts[0][2]],
        [cell_pts[3][0], cell_pts[3][1], cell_pts[3][2]],
        [cell_pts[2][0], cell_pts[2][1], cell_pts[2][2]],        
        interpolated_pt(cell_pts[1], cell_pts[2], sigma),
        interpolated_pt(cell_pts[0], cell_pts[1], sigma)
    ]
];

function _case1112_isobands(cell_pts, sigma) = [
    [
        interpolated_pt(cell_pts[0], cell_pts[3], sigma),   
        [cell_pts[3][0], cell_pts[3][1], cell_pts[3][2]],
        [cell_pts[2][0], cell_pts[2][1], cell_pts[2][2]],
        [cell_pts[1][0], cell_pts[1][1], cell_pts[1][2]],        
        interpolated_pt(cell_pts[0], cell_pts[1], sigma)
    ]
];   

function _case1121_isobands(cell_pts, sigma) = [
    [
        [cell_pts[0][0], cell_pts[0][1], cell_pts[0][2]],    
        interpolated_pt(cell_pts[0], cell_pts[3], sigma),   
        interpolated_pt(cell_pts[2], cell_pts[3], sigma), 
        [cell_pts[2][0], cell_pts[2][1], cell_pts[2][2]],
        [cell_pts[1][0], cell_pts[1][1], cell_pts[1][2]]
    ]
];   
    
function _case1011_isobands(cell_pts, sigma) = 
    _case1211_isobands(cell_pts, sigma);  

function _case0111_isobands(cell_pts, sigma) = 
    _case2111_isobands(cell_pts, sigma);   

function _case1110_isobands(cell_pts, sigma) = 
    _case1112_isobands(cell_pts, sigma);   

function _case1101_isobands(cell_pts, sigma) = 
    _case1121_isobands(cell_pts, sigma);       

function _case1200_isobands(cell_pts, lower, upper) = [
    [
        interpolated_pt(cell_pts[0], cell_pts[1], lower),
        interpolated_pt(cell_pts[2], cell_pts[3], lower),
        interpolated_pt(cell_pts[2], cell_pts[3], upper),
        interpolated_pt(cell_pts[1], cell_pts[2], upper),
        [cell_pts[1][0], cell_pts[1][1], cell_pts[1][2]]
    ]
];     

function _case0120_isobands(cell_pts, lower, upper) = [
    [
        interpolated_pt(cell_pts[0], cell_pts[3], lower),
        interpolated_pt(cell_pts[0], cell_pts[3], upper),
        interpolated_pt(cell_pts[2], cell_pts[3], upper),
        [cell_pts[2][0], cell_pts[2][1], cell_pts[2][2]],
        interpolated_pt(cell_pts[1], cell_pts[2], lower)
    ]
];     
    
function _case0012_isobands(cell_pts, lower, upper) = [
    [
        interpolated_pt(cell_pts[0], cell_pts[3], upper),
        [cell_pts[3][0], cell_pts[3][1], cell_pts[3][2]],
        interpolated_pt(cell_pts[2], cell_pts[3], lower),
        interpolated_pt(cell_pts[0], cell_pts[1], lower),
        interpolated_pt(cell_pts[0], cell_pts[1], upper)
    ]
];   

function _case2001_isobands(cell_pts, lower, upper) = [
    [
        [cell_pts[0][0], cell_pts[0][1], cell_pts[0][2]],
        interpolated_pt(cell_pts[0], cell_pts[3], lower),
        interpolated_pt(cell_pts[1], cell_pts[2], lower),
        interpolated_pt(cell_pts[1], cell_pts[2], upper),
        interpolated_pt(cell_pts[0], cell_pts[1], upper)
    ]
];       
    
function _case1022_isobands(cell_pts, lower, upper) = 
    _case1200_isobands(cell_pts, upper, lower);

function _case2102_isobands(cell_pts, lower, upper) = 
    _case0120_isobands(cell_pts, upper, lower);

function _case2210_isobands(cell_pts, lower, upper) = 
    _case0012_isobands(cell_pts, upper, lower);

function _case0221_isobands(cell_pts, lower, upper) = 
    _case2001_isobands(cell_pts, upper, lower);    
    
function _case1002_isobands(cell_pts, lower, upper) = [
    [
        interpolated_pt(cell_pts[0], cell_pts[3], upper),
        interpolated_pt(cell_pts[0], cell_pts[3], lower),
        interpolated_pt(cell_pts[1], cell_pts[2], lower),
        [cell_pts[1][0], cell_pts[1][1], cell_pts[1][2]],
        interpolated_pt(cell_pts[0], cell_pts[1], upper)
    ]
];   

function _case2100_isobands(cell_pts, lower, upper) = [
    [
        interpolated_pt(cell_pts[0], cell_pts[1], lower),
        interpolated_pt(cell_pts[2], cell_pts[3], lower),
        [cell_pts[2][0], cell_pts[2][1], cell_pts[2][2]],
        interpolated_pt(cell_pts[1], cell_pts[2], upper),
        interpolated_pt(cell_pts[0], cell_pts[1], upper)
    ]
]; 
    
function _case0210_isobands(cell_pts, lower, upper) = [
    [
        interpolated_pt(cell_pts[0], cell_pts[3], lower),
        [cell_pts[3][0], cell_pts[3][1], cell_pts[3][2]], 
        interpolated_pt(cell_pts[2], cell_pts[3], upper),
        interpolated_pt(cell_pts[1], cell_pts[2], upper),
        interpolated_pt(cell_pts[1], cell_pts[2], lower)
    ]
]; 

function _case0021_isobands(cell_pts, lower, upper) = [
    [
        [cell_pts[0][0], cell_pts[0][1], cell_pts[0][2]], 
        interpolated_pt(cell_pts[0], cell_pts[3], upper),
        interpolated_pt(cell_pts[2], cell_pts[3], upper),
        interpolated_pt(cell_pts[2], cell_pts[3], lower), interpolated_pt(cell_pts[0], cell_pts[1], lower)
    ]
]; 
    
function _case1220_isobands(cell_pts, lower, upper) = 
    _case1002_isobands(cell_pts, upper, lower);

function _case0122_isobands(cell_pts, lower, upper) = 
    _case2100_isobands(cell_pts, upper, lower);

function _case2012_isobands(cell_pts, lower, upper) = 
    _case0210_isobands(cell_pts, upper, lower);

function _case2201_isobands(cell_pts, lower, upper) = 
    _case0021_isobands(cell_pts, upper, lower);        
    
// Saddles
function _case2020_isobands(cell_pts, lower, upper) = 
    let(mdpz = (cell_pts[0][2] + cell_pts[1][2] + cell_pts[2][2] + cell_pts[3][2]) / 4)
    mdpz < lower ? [
        [
            interpolated_pt(cell_pts[0], cell_pts[1], lower),
            interpolated_pt(cell_pts[1], cell_pts[2], lower),
            interpolated_pt(cell_pts[1], cell_pts[2], upper), interpolated_pt(cell_pts[0], cell_pts[1], upper)
        ],
        [
            interpolated_pt(cell_pts[0], cell_pts[3], lower),
            interpolated_pt(cell_pts[0], cell_pts[3], upper),
            interpolated_pt(cell_pts[2], cell_pts[3], upper), interpolated_pt(cell_pts[2], cell_pts[3], lower)
        ]
    ] :
    mdpz >= lower && mdpz < upper ? [
        [
            interpolated_pt(cell_pts[0], cell_pts[1], lower),
            interpolated_pt(cell_pts[0], cell_pts[3], lower),
            interpolated_pt(cell_pts[0], cell_pts[3], upper),
            interpolated_pt(cell_pts[2], cell_pts[3], upper),
            interpolated_pt(cell_pts[2], cell_pts[3], lower),
            interpolated_pt(cell_pts[1], cell_pts[2], lower),
            interpolated_pt(cell_pts[1], cell_pts[2], upper),
            interpolated_pt(cell_pts[0], cell_pts[1], upper)
        ]
    ] : [
        [
            interpolated_pt(cell_pts[0], cell_pts[1], lower),
            interpolated_pt(cell_pts[0], cell_pts[3], lower),
            interpolated_pt(cell_pts[0], cell_pts[3], upper), interpolated_pt(cell_pts[0], cell_pts[1], upper)
        ],
        [
            interpolated_pt(cell_pts[1], cell_pts[2], upper),
            interpolated_pt(cell_pts[2], cell_pts[3], upper),
            interpolated_pt(cell_pts[2], cell_pts[3], lower), interpolated_pt(cell_pts[1], cell_pts[2], lower)
        ]        
    ];
    
function _case0202_isobands(cell_pts, lower, upper) = 
    let(mdpz = (cell_pts[0][2] + cell_pts[1][2] + cell_pts[2][2] + cell_pts[3][2]) / 4)
    mdpz < lower ? [
        [
            interpolated_pt(cell_pts[0], cell_pts[1], upper),
            interpolated_pt(cell_pts[0], cell_pts[3], upper),
            interpolated_pt(cell_pts[0], cell_pts[3], lower), interpolated_pt(cell_pts[0], cell_pts[1], lower)
        ],
        [
            interpolated_pt(cell_pts[1], cell_pts[2], lower),
            interpolated_pt(cell_pts[2], cell_pts[3], lower),
            interpolated_pt(cell_pts[2], cell_pts[3], upper), interpolated_pt(cell_pts[1], cell_pts[2], upper)
        ]        
    ] :
    mdpz >= lower && mdpz < upper ? [
        [
            interpolated_pt(cell_pts[0], cell_pts[1], upper),
            interpolated_pt(cell_pts[0], cell_pts[3], upper),
            interpolated_pt(cell_pts[0], cell_pts[3], lower),
            interpolated_pt(cell_pts[2], cell_pts[3], lower),
            interpolated_pt(cell_pts[2], cell_pts[3], upper),
            interpolated_pt(cell_pts[1], cell_pts[2], upper),
            interpolated_pt(cell_pts[1], cell_pts[2], lower),
            interpolated_pt(cell_pts[0], cell_pts[1], lower)
        ]
    ] : [
        [
            interpolated_pt(cell_pts[0], cell_pts[1], upper),
            interpolated_pt(cell_pts[1], cell_pts[2], upper),
            interpolated_pt(cell_pts[1], cell_pts[2], lower), interpolated_pt(cell_pts[0], cell_pts[1], lower)
        ],
        [
            interpolated_pt(cell_pts[0], cell_pts[3], upper),
            interpolated_pt(cell_pts[0], cell_pts[3], lower),
            interpolated_pt(cell_pts[2], cell_pts[3], lower), interpolated_pt(cell_pts[2], cell_pts[3], upper)
        ]
    ];

function _case0101_isobands(cell_pts, sigma) = 
    let(mdpz = (cell_pts[0][2] + cell_pts[1][2] + cell_pts[2][2] + cell_pts[3][2]) / 4)
    mdpz < sigma ? [
        [
            [cell_pts[0][0], cell_pts[0][1], cell_pts[0][2]],
            interpolated_pt(cell_pts[0], cell_pts[3], sigma),
            interpolated_pt(cell_pts[0], cell_pts[1], sigma)
        ],
        [
            interpolated_pt(cell_pts[2], cell_pts[3], sigma),
            [cell_pts[2][0], cell_pts[2][1], cell_pts[2][2]],
            interpolated_pt(cell_pts[1], cell_pts[2], sigma)
        ]        
    ] : [
        [
            [cell_pts[0][0], cell_pts[0][1], cell_pts[0][2]],
            interpolated_pt(cell_pts[0], cell_pts[3], sigma),
            interpolated_pt(cell_pts[2], cell_pts[3], sigma),
            [cell_pts[2][0], cell_pts[2][1], cell_pts[2][2]],
            interpolated_pt(cell_pts[1], cell_pts[2], sigma),
            interpolated_pt(cell_pts[0], cell_pts[1], sigma)
        ]
    ];

function _case1010_isobands(cell_pts, sigma) = 
    let(mdpz = (cell_pts[0][2] + cell_pts[1][2] + cell_pts[2][2] + cell_pts[3][2]) / 4)
    mdpz < sigma ? [
        [
            interpolated_pt(cell_pts[0], cell_pts[1], sigma),
            interpolated_pt(cell_pts[1], cell_pts[2], sigma),
            [cell_pts[1][0], cell_pts[1][1], cell_pts[1][2]]
        ],
        [
            interpolated_pt(cell_pts[0], cell_pts[3], sigma),
            [cell_pts[3][0], cell_pts[3][1], cell_pts[3][2]],
            interpolated_pt(cell_pts[2], cell_pts[3], sigma)
        ]        
    ] : [
        [
            interpolated_pt(cell_pts[0], cell_pts[3], sigma),
            [cell_pts[3][0], cell_pts[3][1], cell_pts[3][2]],
            interpolated_pt(cell_pts[2], cell_pts[3], sigma),
            interpolated_pt(cell_pts[1], cell_pts[2], sigma),
            [cell_pts[1][0], cell_pts[1][1], cell_pts[1][2]],
            interpolated_pt(cell_pts[0], cell_pts[1], sigma)
        ]
    ];    

function _case2121_isobands(cell_pts, sigma) = 
    let(mdpz = (cell_pts[0][2] + cell_pts[1][2] + cell_pts[2][2] + cell_pts[3][2]) / 4)
    mdpz < sigma ? [
        [
            [cell_pts[0][0], cell_pts[0][1], cell_pts[0][2]],
            interpolated_pt(cell_pts[0], cell_pts[3], sigma),
            interpolated_pt(cell_pts[2], cell_pts[3], sigma),
            [cell_pts[2][0], cell_pts[2][1], cell_pts[2][2]],
            interpolated_pt(cell_pts[1], cell_pts[2], sigma),
            interpolated_pt(cell_pts[0], cell_pts[1], sigma)
        ]
    ] : [
        [
            [cell_pts[0][0], cell_pts[0][1], cell_pts[0][2]],
            interpolated_pt(cell_pts[0], cell_pts[3], sigma),
            interpolated_pt(cell_pts[0], cell_pts[1], sigma)
        ],
        [
            interpolated_pt(cell_pts[2], cell_pts[3], sigma),
            [cell_pts[2][0], cell_pts[2][1], cell_pts[2][2]],
            interpolated_pt(cell_pts[1], cell_pts[2], sigma)
        ]        
    ];        

function _case1212_isobands(cell_pts, sigma) = 
    let(mdpz = (cell_pts[0][2] + cell_pts[1][2] + cell_pts[2][2] + cell_pts[3][2]) / 4)
    mdpz < sigma ? [
        [
            interpolated_pt(cell_pts[0], cell_pts[3], sigma),
            [cell_pts[3][0], cell_pts[3][1], cell_pts[3][2]],
            interpolated_pt(cell_pts[2], cell_pts[3], sigma),
            interpolated_pt(cell_pts[1], cell_pts[2], sigma),
            [cell_pts[1][0], cell_pts[1][1], cell_pts[1][2]],
            interpolated_pt(cell_pts[0], cell_pts[1], sigma)
        ]
    ] : [
        [
            interpolated_pt(cell_pts[0], cell_pts[1], sigma),
            interpolated_pt(cell_pts[1], cell_pts[2], sigma),
            [cell_pts[1][0], cell_pts[1][1], cell_pts[1][2]]
        ],
        [
            interpolated_pt(cell_pts[0], cell_pts[3], sigma),
            [cell_pts[3][0], cell_pts[3][1], cell_pts[3][2]],
            interpolated_pt(cell_pts[2], cell_pts[3], sigma)
        ]        
    ];            

function _case2120_isobands(cell_pts, lower, upper) = 
    let(mdpz = (cell_pts[0][2] + cell_pts[1][2] + cell_pts[2][2] + cell_pts[3][2]) / 4)
    mdpz < upper ? [
        [
            interpolated_pt(cell_pts[0], cell_pts[3], lower),
            interpolated_pt(cell_pts[0], cell_pts[3], upper),
            interpolated_pt(cell_pts[2], cell_pts[3], upper),
            [cell_pts[2][0], cell_pts[2][1], cell_pts[2][2]],
            interpolated_pt(cell_pts[1], cell_pts[2], upper),
            interpolated_pt(cell_pts[0], cell_pts[1], upper),
            interpolated_pt(cell_pts[0], cell_pts[1], lower)
        ]     
    ] : [
        [
            interpolated_pt(cell_pts[0], cell_pts[3], lower),
            interpolated_pt(cell_pts[0], cell_pts[3], upper),
            interpolated_pt(cell_pts[0], cell_pts[1], upper), interpolated_pt(cell_pts[0], cell_pts[1], lower)
        ],
        [
            interpolated_pt(cell_pts[2], cell_pts[3], upper),
            [cell_pts[2][0], cell_pts[2][1], cell_pts[2][2]],
            interpolated_pt(cell_pts[1], cell_pts[2], upper)
        ]
    ];
    
function _case0102_isobands(cell_pts, lower, upper) = 
    let(mdpz = (cell_pts[0][2] + cell_pts[1][2] + cell_pts[2][2] + cell_pts[3][2]) / 4)
    mdpz < lower ? [
        [
            interpolated_pt(cell_pts[0], cell_pts[3], upper),
            interpolated_pt(cell_pts[0], cell_pts[3], lower),
            interpolated_pt(cell_pts[0], cell_pts[1], lower), interpolated_pt(cell_pts[0], cell_pts[1], upper)
        ],
        [
            interpolated_pt(cell_pts[2], cell_pts[3], lower),
            [cell_pts[2][0], cell_pts[2][1], cell_pts[2][2]],
            interpolated_pt(cell_pts[1], cell_pts[2], lower)
        ]
    ] : [
        [
            interpolated_pt(cell_pts[0], cell_pts[3], upper),
            interpolated_pt(cell_pts[0], cell_pts[3], lower),
            interpolated_pt(cell_pts[2], cell_pts[3], lower),
            [cell_pts[2][0], cell_pts[2][1], cell_pts[2][2]],
            interpolated_pt(cell_pts[1], cell_pts[2], lower),
            interpolated_pt(cell_pts[0], cell_pts[1], lower),
            interpolated_pt(cell_pts[0], cell_pts[1], upper)
        ]     
    ];    

function _case2021_isobands(cell_pts, lower, upper) = 
    let(mdpz = (cell_pts[0][2] + cell_pts[1][2] + cell_pts[2][2] + cell_pts[3][2]) / 4)
    mdpz < upper ? [
        [
            [cell_pts[0][0], cell_pts[0][1], cell_pts[0][2]],
            interpolated_pt(cell_pts[0], cell_pts[3], upper),
            interpolated_pt(cell_pts[2], cell_pts[3], upper),
            interpolated_pt(cell_pts[2], cell_pts[3], lower),
            interpolated_pt(cell_pts[1], cell_pts[2], lower),
            interpolated_pt(cell_pts[1], cell_pts[2], upper),
            interpolated_pt(cell_pts[0], cell_pts[1], upper)
        ]     
    ] : [
        [
            [cell_pts[0][0], cell_pts[0][1], cell_pts[0][2]],
            interpolated_pt(cell_pts[0], cell_pts[3], upper),
            interpolated_pt(cell_pts[0], cell_pts[1], upper)
        ],
        [
            interpolated_pt(cell_pts[2], cell_pts[3], upper),
            interpolated_pt(cell_pts[2], cell_pts[3], lower),
            interpolated_pt(cell_pts[1], cell_pts[2], lower),
            interpolated_pt(cell_pts[1], cell_pts[2], upper)
        ]
    ];
    
function _case0201_isobands(cell_pts, lower, upper) = 
    let(mdpz = (cell_pts[0][2] + cell_pts[1][2] + cell_pts[2][2] + cell_pts[3][2]) / 4)
    mdpz < lower ? [
        [
            [cell_pts[0][0], cell_pts[0][1], cell_pts[0][2]],
            interpolated_pt(cell_pts[0], cell_pts[3], lower),
            interpolated_pt(cell_pts[0], cell_pts[1], lower)
        ],
        [
            interpolated_pt(cell_pts[2], cell_pts[3], lower),
            interpolated_pt(cell_pts[2], cell_pts[3], upper),
            interpolated_pt(cell_pts[1], cell_pts[2], upper),
            interpolated_pt(cell_pts[1], cell_pts[2], lower)
        ]
    ] : [
        [
            [cell_pts[0][0], cell_pts[0][1], cell_pts[0][2]],
            interpolated_pt(cell_pts[0], cell_pts[3], lower),
            interpolated_pt(cell_pts[2], cell_pts[3], lower),
            interpolated_pt(cell_pts[2], cell_pts[3], upper),
            interpolated_pt(cell_pts[1], cell_pts[2], upper),
            interpolated_pt(cell_pts[1], cell_pts[2], lower),
            interpolated_pt(cell_pts[0], cell_pts[1], lower)
        ]     
    ];    
 
function _case1202_isobands(cell_pts, lower, upper) = 
    let(mdpz = (cell_pts[0][2] + cell_pts[1][2] + cell_pts[2][2] + cell_pts[3][2]) / 4)
    mdpz < upper ? [
        [
            interpolated_pt(cell_pts[0], cell_pts[3], upper),
            interpolated_pt(cell_pts[0], cell_pts[3], lower),
            interpolated_pt(cell_pts[2], cell_pts[3], lower),
            interpolated_pt(cell_pts[2], cell_pts[3], upper),
            interpolated_pt(cell_pts[1], cell_pts[2], upper),
            [cell_pts[1][0], cell_pts[1][1], cell_pts[1][2]],
            interpolated_pt(cell_pts[0], cell_pts[1], upper)
        ]     
    ] : [
        [
            interpolated_pt(cell_pts[0], cell_pts[1], upper),
            interpolated_pt(cell_pts[1], cell_pts[2], upper),
            [cell_pts[1][0], cell_pts[1][1], cell_pts[1][2]]
        ],
        [
            interpolated_pt(cell_pts[0], cell_pts[3], upper),
            interpolated_pt(cell_pts[0], cell_pts[3], lower),
            interpolated_pt(cell_pts[2], cell_pts[3], lower),
            interpolated_pt(cell_pts[2], cell_pts[3], upper)
        ]
    ];

function _case1020_isobands(cell_pts, lower, upper) = 
    let(mdpz = (cell_pts[0][2] + cell_pts[1][2] + cell_pts[2][2] + cell_pts[3][2]) / 4)
    mdpz < lower ? [
        [
            interpolated_pt(cell_pts[0], cell_pts[1], lower),
            interpolated_pt(cell_pts[1], cell_pts[2], lower),
            [cell_pts[1][0], cell_pts[1][1], cell_pts[1][2]]
        ],
        [
            interpolated_pt(cell_pts[0], cell_pts[3], lower),
            interpolated_pt(cell_pts[0], cell_pts[3], upper),
            interpolated_pt(cell_pts[2], cell_pts[3], upper),
            interpolated_pt(cell_pts[2], cell_pts[3], lower)
        ]
    ] : [
        [
            interpolated_pt(cell_pts[0], cell_pts[3], lower),
            interpolated_pt(cell_pts[0], cell_pts[3], upper),
            interpolated_pt(cell_pts[2], cell_pts[3], upper),
            interpolated_pt(cell_pts[2], cell_pts[3], lower),
            interpolated_pt(cell_pts[1], cell_pts[2], lower),
            [cell_pts[1][0], cell_pts[1][1], cell_pts[1][2]],
            interpolated_pt(cell_pts[0], cell_pts[1], lower)
        ]     
    ];    
    
function _case0212_isobands(cell_pts, lower, upper) = 
    let(mdpz = (cell_pts[0][2] + cell_pts[1][2] + cell_pts[2][2] + cell_pts[3][2]) / 4)
    mdpz < upper ? [
        [
            interpolated_pt(cell_pts[0], cell_pts[3], upper),
            [cell_pts[3][0], cell_pts[3][1], cell_pts[3][2]],
            interpolated_pt(cell_pts[2], cell_pts[3], upper),
            interpolated_pt(cell_pts[1], cell_pts[2], upper),
            interpolated_pt(cell_pts[1], cell_pts[2], lower),
            interpolated_pt(cell_pts[0], cell_pts[1], lower),
            interpolated_pt(cell_pts[0], cell_pts[1], upper)
        ]     
    ] : [
        [
            interpolated_pt(cell_pts[0], cell_pts[1], upper),
            interpolated_pt(cell_pts[1], cell_pts[2], upper),
            interpolated_pt(cell_pts[1], cell_pts[2], lower),
            interpolated_pt(cell_pts[0], cell_pts[1], lower)
        ],
        [
            interpolated_pt(cell_pts[0], cell_pts[3], upper),
            [cell_pts[3][0], cell_pts[3][1], cell_pts[3][2]],
            interpolated_pt(cell_pts[2], cell_pts[3], upper)
        ]
    ];    
    
function _case2010_isobands(cell_pts, lower, upper) = 
    let(mdpz = (cell_pts[0][2] + cell_pts[1][2] + cell_pts[2][2] + cell_pts[3][2]) / 4)
    mdpz < lower ? [
        [
            interpolated_pt(cell_pts[0], cell_pts[1], lower),
            interpolated_pt(cell_pts[1], cell_pts[2], lower),
            interpolated_pt(cell_pts[1], cell_pts[2], upper),
            interpolated_pt(cell_pts[0], cell_pts[1], upper)
        ],
        [
            interpolated_pt(cell_pts[0], cell_pts[3], lower),
            [cell_pts[3][0], cell_pts[3][1], cell_pts[3][2]],
            interpolated_pt(cell_pts[2], cell_pts[3], lower)
        ]
    ] : [
        [
            interpolated_pt(cell_pts[0], cell_pts[3], lower),
            [cell_pts[3][0], cell_pts[3][1], cell_pts[3][2]],
            interpolated_pt(cell_pts[2], cell_pts[3], lower),
            interpolated_pt(cell_pts[1], cell_pts[2], lower),
            interpolated_pt(cell_pts[1], cell_pts[2], upper),
            interpolated_pt(cell_pts[0], cell_pts[1], upper),
            interpolated_pt(cell_pts[0], cell_pts[1], lower)
        ]     
    ];        
 
function _isobands_of(cell_pts, lower, upper) =    
    let(cv = _isobands_corner_value(cell_pts))
    // no contour
    cv == "0000" ? [] : 
    // single square
    cv == "1111" ? [[for(i = 3; i >= 0; i = i - 1) [cell_pts[i][0], cell_pts[i][1]]]] :
    // single triangle
    cv == "2221" ? _case2221_isobands(cell_pts, upper) :
    cv == "2212" ? _case2212_isobands(cell_pts, upper) :
    cv == "2122" ? _case2122_isobands(cell_pts, upper) :
    cv == "1222" ? _case1222_isobands(cell_pts, upper) :
    cv == "0001" ? _case0001_isobands(cell_pts, lower) :
    cv == "0010" ? _case0010_isobands(cell_pts, lower) :
    cv == "0100" ? _case0100_isobands(cell_pts, lower) :
    cv == "1000" ? _case1000_isobands(cell_pts, lower) :
    // single trapezoid
    cv == "2220" ? _case2220_isobands(cell_pts, lower, upper) :
    cv == "2202" ? _case2202_isobands(cell_pts, lower, upper) :
    cv == "2022" ? _case2022_isobands(cell_pts, lower, upper) :
    cv == "0222" ? _case0222_isobands(cell_pts, lower, upper) :   
    cv == "0002" ? _case0002_isobands(cell_pts, lower, upper) :       
    cv == "0020" ? _case0020_isobands(cell_pts, lower, upper) :
    cv == "0200" ? _case0200_isobands(cell_pts, lower, upper) :    
    cv == "2000" ? _case2000_isobands(cell_pts, lower, upper) :     
    // single rectangle  
    cv == "0011" ? _case0011_isobands(cell_pts, lower) :
    cv == "0110" ? _case0110_isobands(cell_pts, lower) :
    cv == "1100" ? _case1100_isobands(cell_pts, lower) : 
    cv == "1001" ? _case1001_isobands(cell_pts, lower) :
    cv == "2211" ? _case2211_isobands(cell_pts, upper) :
    cv == "2112" ? _case2112_isobands(cell_pts, upper) :  
    cv == "1122" ? _case1122_isobands(cell_pts, upper) :
    cv == "1221" ? _case1221_isobands(cell_pts, upper) :
    cv == "2200" ? _case2200_isobands(cell_pts, lower, upper) :
    cv == "2002" ? _case2002_isobands(cell_pts, lower, upper) :    
    cv == "0022" ? _case0022_isobands(cell_pts, lower, upper) :     
    cv == "0220" ? _case0220_isobands(cell_pts, lower, upper) :     
    // single hexagon
    cv == "0211" ? _case0211_isobands(cell_pts, lower, upper) :   
    cv == "2110" ? _case2110_isobands(cell_pts, lower, upper) :       
    cv == "1102" ? _case1102_isobands(cell_pts, lower, upper) :      
    cv == "1021" ? _case1021_isobands(cell_pts, lower, upper) :     
    cv == "2011" ? _case2011_isobands(cell_pts, lower, upper) :     
    cv == "0112" ? _case0112_isobands(cell_pts, lower, upper) :     
    cv == "1120" ? _case1120_isobands(cell_pts, lower, upper) :        
    cv == "1201" ? _case1201_isobands(cell_pts, lower, upper) :       
    cv == "2101" ? _case2101_isobands(cell_pts, lower, upper) :        
    cv == "0121" ? _case0121_isobands(cell_pts, lower, upper) :      
    cv == "1012" ? _case1012_isobands(cell_pts, lower, upper) :       
    cv == "1210" ? _case1210_isobands(cell_pts, lower, upper) :     
    // single pentagon    
    cv == "1211" ? _case1211_isobands(cell_pts, upper) :
    cv == "2111" ? _case2111_isobands(cell_pts, upper) :
    cv == "1112" ? _case1112_isobands(cell_pts, upper) :   
    cv == "1121" ? _case1121_isobands(cell_pts, upper) :
    cv == "1011" ? _case1011_isobands(cell_pts, lower) :
    cv == "0111" ? _case0111_isobands(cell_pts, lower) :
    cv == "1110" ? _case1110_isobands(cell_pts, lower) :   
    cv == "1101" ? _case1101_isobands(cell_pts, lower) :  
    cv == "1200" ? _case1200_isobands(cell_pts, lower, upper) :      
    cv == "0120" ? _case0120_isobands(cell_pts, lower, upper) :   
    cv == "0012" ? _case0012_isobands(cell_pts, lower, upper) :      
    cv == "2001" ? _case2001_isobands(cell_pts, lower, upper) :    
    cv == "1022" ? _case1022_isobands(cell_pts, lower, upper) :      
    cv == "2102" ? _case2102_isobands(cell_pts, lower, upper) :   
    cv == "2210" ? _case2210_isobands(cell_pts, lower, upper) :      
    cv == "0221" ? _case0221_isobands(cell_pts, lower, upper) :
    cv == "1002" ? _case1002_isobands(cell_pts, lower, upper) :      
    cv == "2100" ? _case2100_isobands(cell_pts, lower, upper) :   
    cv == "0210" ? _case0210_isobands(cell_pts, lower, upper) :    
    cv == "0021" ? _case0021_isobands(cell_pts, lower, upper) :        
    cv == "1220" ? _case1220_isobands(cell_pts, lower, upper) :      
    cv == "0122" ? _case0122_isobands(cell_pts, lower, upper) :   
    cv == "2012" ? _case2012_isobands(cell_pts, lower, upper) :    
    cv == "2201" ? _case2201_isobands(cell_pts, lower, upper) : 
    // Saddles
    cv == "2020" ? _case2020_isobands(cell_pts, lower, upper) :
    cv == "0202" ? _case0202_isobands(cell_pts, lower, upper) :
    cv == "0101" ? _case0101_isobands(cell_pts, lower) :
    cv == "1010" ? _case1010_isobands(cell_pts, lower) :
    cv == "2121" ? _case2121_isobands(cell_pts, upper) :    
    cv == "1212" ? _case1212_isobands(cell_pts, upper) : 
    cv == "2120" ? _case2120_isobands(cell_pts, lower, upper) :    
    cv == "0102" ? _case0102_isobands(cell_pts, lower, upper) :   
    cv == "2021" ? _case2021_isobands(cell_pts, lower, upper) : 
    cv == "0201" ? _case0201_isobands(cell_pts, lower, upper) : 
    cv == "1202" ? _case1202_isobands(cell_pts, lower, upper) :      
    cv == "1020" ? _case1020_isobands(cell_pts, lower, upper) :  
    cv == "0212" ? _case0212_isobands(cell_pts, lower, upper) :  
    cv == "2010" ? _case2010_isobands(cell_pts, lower, upper) :  
    // no contour
    []; // 2222
    
function _marching_squares_isobands(points, lower, upper) = 
    let(labeled_pts = _isobands_tri_label(points, lower, upper))
    [
        for(y = [0:len(labeled_pts) - 2])
            [
                 for(x = [0:len(labeled_pts[0]) - 2])
                 let(
                    p0 = labeled_pts[y][x],
                    p1 = labeled_pts[y + 1][x],
                    p2 = labeled_pts[y + 1][x + 1],
                    p3 = labeled_pts[y][x + 1],
                    cell_pts = [p0, p1, p2, p3],
                    isobands_lt = _isobands_of(cell_pts, lower, upper)
                 )
                 if(isobands_lt != [])
                 each isobands_lt
           ]
    ];
    
/*
    ISOBANDS Impl End ============================
*/
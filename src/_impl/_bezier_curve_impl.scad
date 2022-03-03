function _combi(n, k) =
    let(  
        bi_coef = [      
               [1],     // n = 0: for padding
              [1,1],    // n = 1: for Linear curves, how about drawing a line directly?
             [1,2,1],   // n = 2: for Quadratic curves
            [1,3,3,1]   // n = 3: for Cubic Bézier curves
        ]  
    )
    n < 4 ? bi_coef[n][k] : 
    k == 0 ? 1 : (_combi(n, k - 1) * (n - k + 1) / k);
        
function bezier_curve_coordinate(t, pn, n, i = 0) = 
    i == n + 1 ? 0 : 
        (_combi(n, i) * pn[i] * pow(1 - t, n - i) * pow(t, i) + 
            bezier_curve_coordinate(t, pn, n, i + 1));
        
function _bezier_curve_point2(t, points) = 
    let(n = len(points) - 1) 
    [
        bezier_curve_coordinate(
            t, 
            [for(p = points) p.x], 
            n
        ),
        bezier_curve_coordinate(
            t,  
            [for(p = points) p.y], 
            n
        )
    ];

function _bezier_curve_point3(t, points) = 
    let(n = len(points) - 1) 
    [
        bezier_curve_coordinate(
            t, 
            [for(p = points) p.x], 
            n
        ),
        bezier_curve_coordinate(
            t,  
            [for(p = points) p.y], 
            n
        ),
        bezier_curve_coordinate(
            t, 
            [for(p = points) p.z], 
            n
        )
    ];

function _bezier_curve_impl(t_step, points) = 
    let(t_end = ceil(1 / t_step)) 
    len(points[0]) == 3 ? 
        [each [for(t = 0; t < t_end; t = t + 1) _bezier_curve_point3(t * t_step, points)], _bezier_curve_point3(1, points)] :
        [each [for(t = 0; t < t_end; t = t + 1) _bezier_curve_point2(t * t_step, points)], _bezier_curve_point2(1, points)];

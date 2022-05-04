use <../util/sum.scad>;

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
        
function bezier_curve_coordinate(t, pn, n, i) = 
    let(one_t = 1 - t)
    sum([for(j = [0:n]) _combi(n, j) * pn[j][i] * one_t ^ (n - j) * t ^ j]);
         
function _bezier_curve(range, t, points, n) = 
    [for(i = range) bezier_curve_coordinate(t, points, n, i)];

function _bezier_curve_impl(t_step, points) = 
    let(
        t_end = ceil(1 / t_step), 
        n = len(points) - 1, 
        range = [0:len(points[0]) - 1]
    ) 
    [
        each [for(t = 0; t < t_end; t = t + 1) _bezier_curve(range, t * t_step, points, n)], 
        _bezier_curve(range, 1, points, n)
    ];

function __outer_points_shape_star(r1, r2, n) = 
    let(a_step = 360 / n)
    [
        for(i = 0; i < n; i = i + 1) 
        let(a = 90 + a_step * i)
        [r1 * cos(a), r1 * sin(a)]
    ];

function __inner_points_shape_star(r1, r2, n) = 
    let(a_step = 360 / n)
    [
        for(i = 0; i < n; i = i + 1) 
        let(a = 90 + a_step * (i + 0.5))
        [r2 * cos(a), r2 * sin(a)]
    ];
    
function _shape_star_impl(r1, r2, n) = 
    let(
       outer_points = __outer_points_shape_star(r1, r2, n),
       inner_points = __inner_points_shape_star(r1, r2, n)
    )
   [for(i = [0:len(outer_points) - 1]) each [outer_points[i], inner_points[i]]];
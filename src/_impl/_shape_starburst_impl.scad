function __outer_points_shape_starburst(r1, r2, n) = 
    let(
        a = 360 / n
    )
    [for(i = 0; i < n; i = i + 1) [r1 * cos(a * i), r1 * sin(a * i)]];

function __inner_points_shape_starburst(r1, r2, n) = 
    let (
        a = 360 / n,
        half_a = a / 2
    )
    [for(i = 0; i < n; i = i + 1) [r2 * cos(a * i + half_a), r2 * sin(a * i + half_a)]];
    
function _shape_starburst_impl(r1, r2, n) = 
   let(
       outer_points = __outer_points_shape_starburst(r1, r2, n),
       inner_points = __inner_points_shape_starburst(r1, r2, n),
       leng = len(outer_points)
    )
   [for(i = 0; i < leng; i = i + 1) each [outer_points[i], inner_points[i]]];
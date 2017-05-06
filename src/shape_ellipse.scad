/**
* shape_ellipse.scad
*
* Returns shape points and triangle indexes of an ellipse.
* They can be used with xxx_extrude modules of dotSCAD.
* The shape points can be also used with the built-in polygon module. 
* 
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-shape_ellipse.html
*
**/

function shape_ellipse(axes) =
    let(
        frags = $fn > 0 ? 
            ($fn >= 3 ? $fn : 3) : 
            max(min(360 / $fa, axes[0] * 6.28318 / $fs), 5),
        step_a = 360 / frags,
        shape_pts = [
            for(a = [0:step_a:360 - step_a]) 
                [axes[0] * cos(a), axes[1] * sin(a)]
        ],
        triangles = [for(i = [1:len(shape_pts) - 2]) [0, i, i + 1]]
    )
    [
        shape_pts,
        triangles
    ];
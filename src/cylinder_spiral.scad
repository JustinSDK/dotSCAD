/**
* cylinder_spiral.scad
*
* Get all points on the path of a spiral around a cylinder. 
* Its $fa, $fs and $fn parameters are consistent with the cylinder module.
* It depends on the circle_path module so you have to include circle_path.scad.
* 
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-cylinder_spiral.html
*
**/ 

function cylinder_spiral(radius, levels, level_dist, 
                         vt_dir = "SPI_DOWN", rt_dir = "CT_CLK") = 
    let(
        points = circle_path(radius),
        leng = len(points),
        offset_z = level_dist / _frags(radius),
        v_dir = (vt_dir == "SPI_DOWN" ? -1 : 1),
        r_dir = (rt_dir == "CT_CLK" ? 1 : -1)
    ) [
        for(l = [0:levels - 1])
            for(i = [0:leng - 1])
                r_dir == 1 ? [     // COUNT_CLOCKWISE
                    points[i][0], 
                    points[i][1],
                    v_dir * (l * level_dist + offset_z * i)
                ] : (             //  CLOCKWISE
                        i == 0 ? [
                            points[0][0],
                            points[0][1],
                            v_dir * l * level_dist
                        ] : [
                            points[leng - i][0], 
                            points[leng - i][1], 
                            v_dir * (l * level_dist + offset_z * i)
                        ]
                )
    ];
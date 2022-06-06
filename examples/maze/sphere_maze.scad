use <matrix/m_rotation.scad>
use <maze/mz_square.scad>
use <maze/mz_squarewalls.scad>
use <ptf/ptf_sphere.scad>

r = 10;
rows = 24;
columns = 18;
cell_width = .5;
wall_thickness = .5;   
wall_height = 1.5;
pole_offset = cell_width * 2.5;

module sphere_maze() {
    function _angles(p) = 
        let(
            dx = p[0],
            dy = p[1],
            dz = p[2],
            ya = atan2(dz, sqrt(dx * dx + dy * dy)),
            za = atan2(dy, dx)
        ) [0, -ya, za];

    module _polyline(points) {
        leng = len(points);
        
        module _line(index) {
            point1 = points[index - 1];
            point2 = points[index];

            hull() {
                rotate(_angles(point1))
                translate([r, 0, 0])
                    cube([wall_height, wall_thickness, wall_thickness], center = true);

                rotate(_angles(point2))
                translate([r, 0, 0])
                    cube([wall_height, wall_thickness, wall_thickness], center = true);
            }
        }

        module _polyline_inner(index) {
            if(index < leng) {
                _line(index);
                _polyline_inner(index + 1);
            }
        }

        _polyline_inner(1);
    }


    size = [rows * cell_width, columns * cell_width + pole_offset * 2];
    cells = mz_square(rows, columns, y_wrapping = true);

    p_offset = [cell_width * rows, pole_offset, 0];
    mr = m_rotation(90);

    walls = mz_squarewalls(cells, cell_width, bottom_border = false);
    for(wall_pts = walls) {  
        rxpts = [
            for(p = wall_pts) 
                ptf_sphere(size, mr * [p[0], p[1], 0, 0] + p_offset, r)
        ];
        _polyline(rxpts);
    }
}

function _angles(p) = 
    let(
        dx = p[0],
        dy = p[1],
        dz = p[2],
        ya = atan2(dz, sqrt(dx * dx + dy * dy)),
        za = atan2(dy, dx)
    ) [0, -ya, za];

sphere_maze();
color("black") 
rotate([0, 90, 0]) 
    sphere(r);
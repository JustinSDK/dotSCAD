use <maze/mz_square.scad>
use <maze/mz_squarewalls.scad>
use <polyline2d.scad>
use <noise/nz_perlin2.scad>
use <util/choose.scad>

rows = 30;
columns = 30;
cell_width = 3;
wall_thickness = 1.5;
moutain_height = 30;
base_height = 3;
seed = 35;
smoothing  = 25;

island_maze();

module island_maze() {
    dirs = function(x, y, cells, seed) 
           let(
               nz = nz_perlin2(x * cell_width / smoothing, y * cell_width / smoothing, seed),
               sd = y * len(cells[0]) + x + seed,
               h = choose([[0, 2], [2, 0]], seed = sd),
               v = choose([[1, 3], [3, 1]], seed = sd)
           )
           nz > 0 ? concat(h, v) : concat(v, h);

    cells = mz_square(rows, columns, seed = seed, directions = dirs);
    walls = mz_squarewalls(cells, cell_width);

    color("green")
    for(wall = walls) {
        for(i = [0:len(wall) - 2]) {
            p1 = wall[i];
            p2 = wall[i + 1];
            h1 = nz_perlin2(p1.x / smoothing , p1.y / smoothing , seed);
            h2 = nz_perlin2(p2.x / smoothing , p2.y / smoothing , seed);
            hull() {
               linear_extrude(h1 > 0 ? h1 * moutain_height + base_height : base_height)
                translate(p1)
                    square(wall_thickness);
                
               linear_extrude(h2 > 0 ? h2 * moutain_height + base_height : base_height)
                translate(p2)
                    square(wall_thickness);
            }
        }
    }

    if($preview) {
        color("blue")
        translate([wall_thickness, wall_thickness] / 2)
        for(wall = walls) {
            linear_extrude(base_height)
            polyline2d(wall, wall_thickness, joinStyle = "JOIN_MITER");
        }
    }
}
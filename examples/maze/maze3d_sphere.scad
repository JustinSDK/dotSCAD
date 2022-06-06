use <maze/mz_cube.scad>
use <maze/mz_cube_initialize.scad>
use <maze3d.scad>

radius = 6;  
cell_width = 15;
road_width = 6;
$fn = 4;  // [4, 8, 12]

maze3d_sphere();

module maze3d_sphere() {
    function mask_sphere(radius) = 
        let(range = [-radius: radius - 1])
        [
            for(z = range)
            [
                for(y = range)
                [
                    for(x = range)
                    let(v = [x, y, z])
                    if(v * v < radius ^ 2) 1
                    else 0
                ]
            ]
            
        ];
        
    mz = mz_cube_initialize(mask = mask_sphere(radius));
    cells = mz_cube(start = [radius, radius, radius] / 2, init_cells = mz);
    draw_3dmaze(cells, cell_width, road_width);
}
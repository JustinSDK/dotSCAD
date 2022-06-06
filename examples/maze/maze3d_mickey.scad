use <maze/mz_cube.scad>
use <maze/mz_cube_initialize.scad>
use <maze3d.scad>

face_radius = 9;  
cell_width = 15;
road_width = 6;
$fn = 4;  // [4, 8, 12]

maze3d_mickey();

module maze3d_mickey() {
    function mask_sphere(face_radius) = 
        let(
            range = [-face_radius * 1.5: face_radius * 1.5 - 1],
            ear_p1 = [face_radius * .95, 0, -face_radius * .85],
            ear_p2 = [-face_radius * .95, 0, -face_radius * .85],
            ear_r = face_radius / 1.75
        )
        [
            for(z = range)
            [
                for(y = range)
                [
                    for(x = range)
                    let(v = [x, y, z], v1 = v - ear_p1, v2 = v - ear_p2)
                    if(v * v < face_radius ^ 2 || v1 * v1 < ear_r ^ 2 || v2 * v2 < ear_r ^ 2) 1
                    else 0
                ]
            ]
            
        ];
        

    mz = mz_cube_initialize(mask = mask_sphere(face_radius));
    cells = mz_cube(start = [face_radius, face_radius, face_radius], init_cells = mz);
    
    draw_3dmaze(cells, cell_width, road_width);
}
use <experimental/surface_grapher.scad>;
use <experimental/tf_sphere.scad>;

module sphere_surface(levels, radius, thickness, angle = [180, 360], invert = false) {
    columns = len(levels);
    rows = len(levels[0]);
    
    size = [columns - 1, rows - 1];

    surface1 = [
        for(r = [0:rows - 1]) 
        [
            for(c = [0:columns - 1]) 
            let(lv = invert ? 255 - levels[c][r] : levels[c][r])
            [c, r, lv / 255 * thickness]
        ]
    ];

    surface2 = [
        for(r = [0:rows - 1]) 
        [
            for(c = [0:columns - 1]) 
            [c, r, 0]
        ]
    ];

    surface_grapher(
        [
            for(row = surface1) 
            [
                for(p = row) tf_sphere(size, p, radius + thickness, angle)
            ]
        ]
        ,
        [
            for(row = surface2) 
            [
                for(p = row) tf_sphere(size, p, radius, angle)
            ]
        ]
    );
}
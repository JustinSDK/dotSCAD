use <_impl/_foliage_scroll_impl.scad>

function foliage_scroll(width, height, max_spirals, init_radius, min_radius, angle_step = 10, done = 0) =
    let(
        init_spirals = [
            spiral([init_radius, 0], init_radius, 180),
            spiral([-init_radius, 0], init_radius, 0)
        ]
    )
    [
        for(spiral = _foliage_scroll(width, height, init_spirals, max_spirals, min_radius, angle_step, done))
        spiral_path(spiral)
    ];


use <polyline_join.scad>

width = 400;
height = 400;
max_spirals = 100; 
angle_step = 10; 
min_radius = 10; 
init_radius = rands(min_radius * 2, min_radius * 4, 1)[0];

for(spiral = foliage_scroll(width, height, max_spirals, init_radius, min_radius)) {
    polyline_join(spiral)
        circle(min_radius / 5);
}
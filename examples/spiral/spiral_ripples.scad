use <noise/nz_cell.scad>
use <golden_spiral.scad>
use <noise/nz_perlin2.scad>
use <surface/sf_thicken.scad>
use <util/radians.scad>

amplitude = 2;
angle_step = 30;
voxel_step = 0.2;
wave_smoothness = 2;
thickness = 0.5;
dist = "euclidean"; // [euclidean, manhattan, chebyshev, border] 
seed = 51;

spiral_ripples();

module spiral_ripples() {
    phi = (1 + sqrt(5)) / 2;
    degrees = 720;
    points = [
        for(d = [0:angle_step:degrees])
        let(
            theta = radians(d),
            r = pow(phi, theta * 2 / PI)
        )
        r * [cos(d), sin(d)]
    ];

    sf = [
        for(y = [-45:voxel_step:30]) 
        [
            for(x = [-40:voxel_step:70]) 
            let(
                nz = nz_cell(points, [x, y], dist),
                n = amplitude * nz_perlin2(nz / wave_smoothness, nz / wave_smoothness, seed)
            )
            [x, y, n]
        ]
    ];

    sf_thicken(sf, thickness);
}
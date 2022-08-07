use <util/degrees.scad>
use <polyline_join.scad>
use <bezier_curve.scad>
use <util/reverse.scad>

radius = 10;
thickness = .5;
model_scale = 5;

stop = 50;
sample_rate = 250;
number_of_waves = 1; // n harmonically related number_of_waves 

freq = .1;
amplitude = 2;
harmonic_fn = function(x, n) amplitude * sin(degrees((2 * n + 1) * freq * 2 * PI * x)) / (2 * n + 1);

main_curve = reverse(
    bezier_curve(
        1 / sample_rate, 
        [[0, 0], [15, 8], [10, 15], [-5, 20], [5, stop]]
    )
);
    
for(i = [1:3]) {
    $fn = 2 * i + 2;
    translate([i * radius * 25, 0]) 
    scale(model_scale)
        fourier_vase(
            radius, 
            thickness, 
            stop, 
            sample_rate, 
            number_of_waves * i, 
            harmonic_fn, 
            main_curve
        );
}

module fourier_vase(radius, thickness, stop, sample_rate, number_of_waves, harmonic_fn, main_curve) {
    function x(y, n = 0) =
        n == number_of_waves ? 0 : harmonic_fn(y, n) + x(y, n + 1);

    wave_pts = [
        for(y = [0:stop / sample_rate:stop]) 
        [x(y), y]
    ];
    
    pts = [
        [0, 0],
        each is_undef(main_curve) ? [
            for(i = [0:len(wave_pts) - 1]) 
            [radius + wave_pts[i].x, wave_pts[i].y]
        ] : [
            for(i = [0:len(wave_pts) - 1]) 
            [radius + wave_pts[i].x + main_curve[i].x, wave_pts[i].y]],
        [0, stop]
    ];

    translate([0, 0, stop])
    mirror([0, 0, 1])
    difference() {
        rotate_extrude()
            polygon(pts);

        rotate_extrude()
            offset(-thickness)
                polygon(pts);
        
        translate([0, 0, -1])
        linear_extrude(thickness + 1.001)
            circle(radius * 2);

        linear_extrude(stop - thickness)
            circle(thickness * 2);
    }
}
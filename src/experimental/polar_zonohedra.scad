use <ptf/ptf_rotate.scad>;
use <sweep.scad>;

module polar_zonohedra(n){
    spiral = [
        for(r=[0:n])
        let(p = ptf_rotate([10, 0, PI * 10 * r / n], [0, 0, -360 * r / n]) - [10, 0, 0])
        [p[0], p[1], p[2] * 1.75]
    ];

    sections = [
        for(i=[0:n])
            [for(p = spiral) ptf_rotate(p, [0, 0, 360 * i /  n])]
    ];

    sweep(sections);
}

for(n = [4:8]) {
    translate([50 * (n - 4), 0, 0])
        polar_zonohedra(n);
}
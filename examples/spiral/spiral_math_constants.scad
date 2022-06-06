use <fibonacci_lattice.scad>
use <polyline_join.scad>
use <polyhedron_hull.scad>

n = 150;
radius = 12;
constants = [
    "π3.141592653589793238462643383279502884197169399375105820974944592307816406286",
	"τ6.2831853071795864769252867665590057683943387987502116419498891846156328",
	"φ1.6180339887498948482045868343656381177203091798057628621354486227052604",
	"e2.7182818284590452353602874713526624977572470936999595749669676277240766303535"
];

font_name = "Arial Black";
font_size = 2.5;
txt_extrude = radius * 0.5;
txt_scale = 1.5;

spiral_math_constants(n, radius, constants, font_name, font_size, txt_extrude, txt_scale);

module spiral_math_constants(n, radius, constants, font_name, font_size, txt_extrude, txt_scale) {

	pts = fibonacci_lattice(n, radius);

	polyhedron_hull(pts * 0.9);

	spirals = [for(j = [0:7]) 
		[for(i = j; i < len(pts); i = i + 8) pts[i]]
	];

	module constant_on_spiral(constant, spiral) {
		for(i = [0:len(spiral) - 1]) {
			x = spiral[i].x;
			y = spiral[i].y;
			z = spiral[i].z;
			ya = atan2(z, sqrt(x * x + y * y));
			za = atan2(y, x);

			render() 
			translate(spiral[i])
			rotate([0, -ya, za])
			rotate([90, 0, -90])
			linear_extrude(txt_extrude, scale = txt_scale)
			mirror([-1, 0, 0])
				text(constant[i], size = font_size, font = font_name, valign = "center", halign = "center");
		}
	}

	for(i = [0:2:6]) {
		constant_on_spiral(constants[i / 2], spirals[i + 1]);
	}

	for(i = [0:2:6]) {
		polyline_join(spirals[i] * 0.9)
		    sphere(.5, $fn = 4); 
	}
}
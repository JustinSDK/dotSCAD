use <util/rand.scad>
use <polyhedra/geom_icosahedron.scad>
use <noise/nz_worley3.scad>
use <noise/nz_perlin3.scad>

radius = 150;
detail = 30;
amplitude = radius / 3.75;
grid_w = radius / 3;
dist = "border"; // [euclidean, manhattan, chebyshev, border]=
seed = 21;

ripple_sphere(radius, detail, amplitude, dist, grid_w, seed);

module ripple_sphere(radius, detail, amplitude, dist = "border", grid_w, seed) {
    sample_scale = 0.005;
    points_faces = geom_icosahedron(1, detail);

	points = points_faces[0];
    
    d = radius * 2;
    f1 = 2;
    f2 = amplitude / 75;
	noises = [
        for(p = points / f1)
        let(
            pnz = (p + p * nz_worley3(p.x * f1, p.y * f1, p.z * f1, seed, grid_w, dist)[3] * f2) 
        )
        [
            p.x * (d + nz_perlin3(pnz.x, p.y, p.z, seed) * amplitude),
            p.y * (d + nz_perlin3(p.x, pnz.y, p.z, seed) * amplitude),
            p.z * (d + nz_perlin3(p.x, p.y, pnz.z, seed) * amplitude)
        ]
    ];
    
	polyhedron(
		noises, 
		points_faces[1]
	);
}
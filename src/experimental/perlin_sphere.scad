use <util/rand.scad>;
use <noise/nz_perlin3.scad>;
use <polyhedra/geom_icosahedron.scad>;

radius = 30;
detail = 15;
amplitude = 10;
period = 1;
	
perlin_sphere(radius, detail, amplitude, period);

module perlin_sphere(radius, detail, amplitude, period = 1, seed = undef) {
    points_faces = geom_icosahedron(1, detail);
	points = points_faces[0];
	faces = points_faces[1];

	sd = is_undef(seed) ? floor(rand(0, 256)) : seed % 256;
    noisy_points = [
		for(p = points) 
		p * (radius + nz_perlin3(p.x, p.y, p.z, sd) * amplitude)
	];    
	
	polyhedron(noisy_points, faces);
}
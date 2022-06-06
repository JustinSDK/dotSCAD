use <util/rand.scad>
use <noise/_impl/_pnoise3_impl.scad>
use <polyhedra/geom_icosahedron.scad>

radius = 30;
detail = 20;
amplitude = 10;
period = 2;
	
perlin_sphere(radius, detail, amplitude, period);

module perlin_sphere(radius, detail, amplitude, period = 1, seed = undef) {
    points_faces = geom_icosahedron(1, detail);
	points = points_faces[0];
	faces = points_faces[1];

	sd = is_undef(seed) ? floor(rand(0, 256)) : seed % 256;
    noisy_points = [
		for(p = points) 
		p * (radius + _pnoise3(p.x * period, p.y * period, p.z * period, sd) * amplitude)
	];    
	
	polyhedron(noisy_points, faces);
}
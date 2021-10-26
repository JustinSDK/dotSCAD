use <util/map/hashmap.scad>;
use <util/map/hashmap_get.scad>;
use <polyhedra/geom_tetrahedron.scad>;
use <polyhedra/geom_hexahedron.scad>;
use <polyhedra/geom_octahedron.scad>;
use <polyhedra/geom_dodecahedron.scad>;
use <polyhedra/geom_icosahedron.scad>;
use <experimental/polyhedron_frame.scad>;

number_of_faces = 8; // [3, 6, 8, 12, 20]
radius = 10;
deep = 1;
outer_thickness = .5;
inner_thickness = .5;
detail = 1;

platonic_solid_frame(number_of_faces, radius, deep, outer_thickness, inner_thickness, detail);

module platonic_solid_frame(number_of_faces, radius, deep, outer_thickness, inner_thickness, detail) {
	polyhedra = hashmap([
		[3, function(r, d) geom_tetrahedron(r, d)],
		[6, function(r, d) geom_hexahedron(r, d)],
		[8, function(r, d) geom_octahedron(r, d)],
		[12, function(r, d) geom_dodecahedron(r, d)],
		[20, function(r, d) geom_icosahedron(r, d)],
	]);

	f_polyhedron = hashmap_get(polyhedra, number_of_faces);

	geom = f_polyhedron(radius, detail);

	polyhedron_frame(
	    geom[0], 
		geom[1], 
		deep, 
		outer_thickness, 
		inner_thickness, 
		[for(p = geom[0]) p / norm(p)]
	);
}

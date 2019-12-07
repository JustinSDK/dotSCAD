use <soccer_polyhedron.scad>;

r = 30;
thickness = 2.5;
spacing = 0.4;
half = true; 
flat_inner = true;

color("gold")
intersection() {
    difference() {
        sphere(r);
        if(flat_inner) {
            soccer_polyhedron(r - thickness, spacing = 0);
        }
        else {
            sphere(r - thickness);
        }
    }
    soccer_polyhedron(r * 1.5, spacing = spacing, jigsaw_base = true, half = half);
}
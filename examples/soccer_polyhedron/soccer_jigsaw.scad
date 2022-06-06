use <soccer_polyhedron.scad>

style = "POLYHEDRON"; // [SPHERE, POLYHEDRON]
r = 30;
thickness = 4;
spacing = 0.4;
half = true; 
flat_inner = true;

color("gold")
intersection() {
    difference() {
        if(style == "SPHERE") {
            sphere(r);
        }
        else {
            soccer_polyhedron(r, spacing = 0);
        }

        if(flat_inner) {
            soccer_polyhedron(r - thickness, spacing = 0);
        }
        else {
            sphere(r - thickness);
        }
    }
    soccer_polyhedron(r * 1.5, spacing = spacing, jigsaw_base = true, half = half);
}
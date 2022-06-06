use <unittest.scad>
include <stereographic_extrude.scad>

module test_stereographic_extrude_rs(outer_sphere_r, inner_sphere_r) {
    assertEqualPoint([16.6667, 15.0756], [outer_sphere_r, inner_sphere_r]);
}

module test_stereographic_extrude() {
    echo("==== test_stereographic_extrude ====");

    dimension = 100;

    stereographic_extrude(shadow_side_leng = dimension)
       text(
            "M", size = dimension, 
            valign = "center", halign = "center"
       );

}

test_stereographic_extrude();
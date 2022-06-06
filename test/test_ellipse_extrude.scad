use <unittest.scad>
include <ellipse_extrude.scad>

module test_ellipse_extrude_fzc(child_fs, pre_zs, center_offset) {
    expected_fs =  [1, 0.996917, 0.987688, 0.97237, 0.951057, 0.92388, 0.891007, 0.85264, 0.809017, 0.760406, 0.707107, 0.649448, 0.587785, 0.522499, 0.45399, 0.382683, 0.309017, 0.233445, 0.156434, 0.0784591, 0];
    
    expected_zs = [0, 0.392295, 0.782172, 1.16723, 1.54508, 1.91342, 2.26995, 2.61249, 2.93893, 3.24724, 3.53553, 3.80203, 4.04508, 4.2632, 4.45503, 4.6194, 4.75528, 4.86185, 4.93844, 4.98459, 5];
    
    for(i = [0:len(expected_fs) - 1]) {
        assertEqualNum(expected_fs[i], child_fs[i]);
    }
    
    for(i = [0:len(expected_zs) - 1]) {
        assertEqualNum(expected_zs[i], pre_zs[i]);
    }
    
    
    assertEqualPoint([0, 0, 0], center_offset);
} 

module test_ellipse_extrude() {
    echo("==== test_ellipse_extrude ====");
    
    semi_minor_axis = 5;
    
    ellipse_extrude(semi_minor_axis) 
        circle(semi_minor_axis * 2);
}

test_ellipse_extrude();
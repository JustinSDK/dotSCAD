use <util/spherical_coordinate.scad>

module test_spherical_coordinate() {
    echo("==== test_spherical_coordinate ====");
    coord = spherical_coordinate([100, 100, 100]);
    r = round(coord[0]);
    theta = round(coord[1]);
    phi = round(coord[2]);
    assert([r, theta, phi] == [173, 45, 55]);  
}

test_spherical_coordinate();
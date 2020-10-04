module polyhedron_hull(points) {
    // a workaround
    hull() polyhedron(points, [[for(i=[0:len(points)-1]) i]]);
}
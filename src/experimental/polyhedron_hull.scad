module polyhedron_hull(points) {
    // a workaround from http://forum.openscad.org/missing-features-tc30187.html
    hull() polyhedron(points, [[for(i=[0:len(points)-1]) i]]);

    // Will I implement Convex Hulls (3D)?
    // https://www.cs.jhu.edu/~misha/Spring16/10.pdf
}
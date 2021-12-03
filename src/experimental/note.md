to_do:

- deprecate paths2sections(paths) -> rails2sections(rails)
- deprecate hull_polyline2d, hull_polyline3d -> polyline_join
- deprecate shape_starburst, shape_pentagram -> shape_star
- deprecate starburst -> polyhedra/star

- angle_between adds a ccw param.

- doc: sf add convexity

- new: polyline_join, select, polyhedra/superellipsoid, polyhedra/dodecahedron, polyhedra/hexahedron, polyhedra/icosahedron, polyhedra/octahedron, polyhedra/tetrahedron

release:


# Preview

## 2D/3D Function

 Signature | Description
--|--
[**rails2sections**(rails)](https://openhome.cc/eGossip/OpenSCAD/lib3x-rails2sections.html) | create sections along rails.

## Transformation

 Signature | Description
--|--
[**select**(i)](https://openhome.cc/eGossip/OpenSCAD/lib3x-select.html) | select module objects.
[**polyline_join**(points)](https://openhome.cc/eGossip/OpenSCAD/lib3x-polyline_join.html) | place a join on each point. Hull each pair of joins and union all convex hulls.

## 2D Shape

 Signature | Description
--|--
[**shape_star**([outer_radius, inner_radius, n])](https://openhome.cc/eGossip/OpenSCAD/lib3x-shape_star.html) | create a 2D star.

## Polyhedra

 Signature | Description
--|--
[**polyhedra/star**([outerRadius, innerRadius, height, n])](https://openhome.cc/eGossip/OpenSCAD/lib3x-polyhedra_star.html) | create a 3D star.
[**polyhedra/polar_zonohedra**(n[, theta])](https://openhome.cc/eGossip/OpenSCAD/lib3x-polyhedra_polar_zonohedra.html) | create a [polar zonohedra](https://mathworld.wolfram.com/PolarZonohedron.html).
[**polyhedra/tetrahedron**(radius[, detail])](https://openhome.cc/eGossip/OpenSCAD/lib3x-polyhedra_tetrahedron.html) | create a tetrahedron.
[**polyhedra/hexahedron**(radius[, detail])](https://openhome.cc/eGossip/OpenSCAD/lib3x-polyhedra_hexahedron.html) | create a hexahedron.
[**polyhedra/octahedron**(radius[, detail])](https://openhome.cc/eGossip/OpenSCAD/lib3x-polyhedra_octahedron.html) | create a octahedron.
[**polyhedra/dodecahedron**(radius[, detail])](https://openhome.cc/eGossip/OpenSCAD/lib3x-polyhedra_dodecahedron.html) | create a dodecahedron.
[**polyhedra/icosahedron**(radius[, detail])](https://openhome.cc/eGossip/OpenSCAD/lib3x-polyhedra_icosahedron.html) | create a icosahedron.
[**polyhedra/superellipsoid**(radius[, detail])](https://openhome.cc/eGossip/OpenSCAD/lib3x-polyhedra_superellipsoid.html) | create a superellipsoid.

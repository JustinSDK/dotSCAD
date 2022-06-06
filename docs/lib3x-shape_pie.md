# shape_pie

Returns shape points of a pie (circular sector) shape. They can be used with xxx_extrude modules of dotSCAD. The shape points can be also used with the built-in polygon module. 

## Parameters

- `radius` : The radius of the circle.
- `angle` : A single value or a 2 element vector which defines the central angle. The first element of the vector is the beginning angle in degrees, and the second element is the ending angle.
- `$fa`, `$fs`, `$fn` : Check [the circle module](https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/Using_the_2D_Subsystem#circle) for more details.

## Examples

	use <shape_pie.scad>
	
	shape_pts = shape_pie(10, [45, 315], $fn = 24);
    polygon(shape_pts);

![shape_pie](images/lib3x-shape_pie-1.JPG)

    use <shape_pie.scad>
    use <helix_extrude.scad>

    shape_pts = shape_pie(10, [45, 315], $fn = 8);

    helix_extrude(shape_pts, 
        radius = 40, 
        levels = 5, 
        level_dist = 20
    );

![shape_pie](images/lib3x-shape_pie-2.JPG)

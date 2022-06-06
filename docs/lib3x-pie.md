# pie

Creates a pie (circular sector). Its `$fa`, `$fs` and `$fn` are consistent with the `circle` module.

## Parameters

- `radius` : The radius of the circle.
- `angle` : A single value or a 2 element vector which defines the central angle. The first element of the vector is the beginning angle in degrees, and the second element is the ending angle.
- `$fa`, `$fs`, `$fn` : Check [the circle module](https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/Using_the_2D_Subsystem#circle) for more details.

## Examples

    use <pie.scad>

    pie(radius = 20, angle = [210, 310]);   
    translate([-15, 0, 0]) 
        pie(radius = 20, angle = [45, 135]);  
    translate([15, 0, 0]) 
        pie(radius = 20, angle = [45, 135], $fn = 12);  

![pie](images/lib3x-pie-1.JPG)


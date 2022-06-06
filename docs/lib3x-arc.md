# arc

Creates an arc. You can pass a 2 element vector to define the central angle. Its `$fa`, `$fs` and `$fn` parameters are consistent with the `circle` module. 

## Parameters

- `radius` : The radius of the circle.
- `angle` : A single value or a 2 element vector which defines the central angle. The first element of the vector is the beginning angle in degrees, and the second element is the ending angle.
- `width` : The width of the arc. Default to 1.
- `width_mode` : The default value is `"LINE_CROSS"`. The arc line will move outward by `width / 2` and inward by `width / 2`. If it's `"LINE_OUTWARD"`, The arc line moves outward by `width`. The `"LINE_INWARD"` moves the arc line inward by `width`.
- `$fa`, `$fs`, `$fn` : Check [the circle module](https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/Using_the_2D_Subsystem#circle) for more details.


## Examples
  
    use <arc.scad>
    
    $fn = 24;
    arc(radius = 20, angle = [45, 290], width = 2);
    %circle(r = 20); 

![arc](images/lib3x-arc-1.JPG)

    use <arc.scad>
    
    $fn = 24;
    arc(radius = 20, angle = [45, 290], width = 2, width_mode = "LINE_OUTWARD");
    %circle(r = 20); 

![arc](images/lib3x-arc-2.JPG)

    use <arc.scad>
    
    $fn = 24;
    arc(radius = 20, angle = [45, 290], width = 2, width_mode = "LINE_INWARD");
    %circle(r = 20); 

![arc](images/lib3x-arc-3.JPG)




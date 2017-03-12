# circular_sector

Create a circular sector. You can pass a 2 element vector to define the central angle. It provides a `fn` parameter consistent with the `$fn` parameter of the `circle` module.

## Parameters

- `radius` : The radius of the circle.
- `angles` : A 2 element vector which defines the central angle. The first element of the vector is the beginning angle in degrees, and the second element is the ending angle.
- `fn` : The `$fn` value used by the `circle` module internally. The default value is 24.

## Examples

    circular_sector(radius = 20, angles = [-50, -150]);  
    translate([-15, 0, 0]) circular_sector(radius = 20, angles = [45, 135]);  
    translate([15, 0, 0]) circular_sector(radius = 20, angles = [45, 135], fn = 12);  

![circular_sector](images/lib-circular_sector-1.JPG)


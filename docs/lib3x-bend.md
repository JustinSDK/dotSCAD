# bend

Bends a 3D object into an arc shape.

## Parameters

- `size` : The size of a cube which can contain the target object.
- `angle` : The central angle of the arc shape. The radius of the arc is calculated automatically.
- `frags` : Number of fragments. The target object will be cut into `frags` fragments and recombined into an arc shape. The default value is 24.

## Examples

The containing cube of the target object should be laid down on the x-y plane. For example.

    use <bend.scad>

	x = 9.25;
	y = 9.55;
	z = 1;  
	       
	%cube(size = [x, y, z]);
	linear_extrude(z) text("A");

![bend](images/lib3x-bend-1.JPG)

Once you have the size of the containing cube, you can use it as the `size` argument of the `bend` module.

    use <bend.scad>

	x = 9.25;
	y = 9.55;
	z = 1;  
	       
	*cube(size = [x, y, z]);
	
	bend(size = [x, y, z], angle = 270)
	linear_extrude(z) 
		text("A");

![bend](images/lib3x-bend-2.JPG)

The arc shape is smoother if the `frags` value is larger. 

    use <bend.scad>
	
	x = 9.25;
	y = 9.55;
	z = 1;  
	
	bend(size = [x, y, z], angle = 270, frags = 360)
	linear_extrude(z) 
		text("A");

![bend](images/lib3x-bend-3.JPG)

This module is especially useful when you want to create things such as [PNG to pen holder](https://www.thingiverse.com/thing:1589493).

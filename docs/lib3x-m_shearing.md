# m_shearing

Generate a 4x4 transformation matrix which can pass into `multmatrix` to shear all child elements along the X-axis, Y-axis, or Z-axis in 3D.

**Since:** 1.1

## Parameters

- `sx` : An array `[SHy, SHz]`. The new coordinates of child elements are `(x + SHy * y + SHz * z, y, z)`.
- `sy` : An array `[SHx, SHz]`. The new coordinates of child elements are `(x, y + SHx * x + SHz * z, z)`.
- `sz` : An array `[SHx, SHy]`. The new coordinates of child elements are `(x, y, z + SHx * x + SHy * y)`.

## Examples

	use <matrix/m_shearing.scad>

	color("red") {
		multmatrix(m_shearing(sx = [1, 0]))
			cube(1);
			
		translate([2, 0, 0]) 
		multmatrix(m_shearing(sx = [0, 1]))
			cube(1);
			
		translate([4, 0, 0]) 
		multmatrix(m_shearing(sx = [1, 1]))
			cube(1);
	}

	translate([0, -3, 0]) color("green") {
		multmatrix(m_shearing(sy = [1, 0]))
			cube(1);
			
		translate([2, 0, 0]) 
		multmatrix(m_shearing(sy = [0, 1]))
			cube(1);
			
		translate([4, 0, 0]) 
		multmatrix(m_shearing(sy = [1, 1]))
			cube(1);
	}

	translate([0, -5, 0]) color("blue") {
		multmatrix(m_shearing(sz = [1, 0]))
			cube(1);
			
		translate([2, 0, 0]) 
		multmatrix(m_shearing(sz = [0, 1]))
			cube(1);
			
		translate([4, 0, 0]) 
		multmatrix(m_shearing(sz = [1, 1]))
			cube(1);
	}

![m_shearing](images/lib3x-m_shearing-1.JPG)


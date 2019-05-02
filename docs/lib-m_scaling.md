# m_scaling

Generate a 4x4 transformation matrix which can pass into `multmatrix` to scale its child elements using the specified vector.

## Parameters

- `v` : Elements will be scaled using the vector.

## Examples

	include <m_scaling.scad>;

	cube(10);
	translate([15, 0, 0]) 
		multmatrix(m_scaling([0.5, 1, 2]))
			cube(10);

![m_scaling](images/lib-m_scaling-1.JPG)


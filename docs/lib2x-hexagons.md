# hexagons

A hexagonal structure is useful in many situations. This module creates hexagons in a hexagon.

## Parameters

- `radius` : The radius of every hexagon.
- `spacing` : The length of the gap between hexagons.
- `levels` : How many levels if counting from the center?

## Examples

	use <hexagons.scad>;
	
	radius = 20;
	spacing = 2;
	levels = 2;
	
	hexagons(radius, spacing, levels);

![hexagons](images/lib2x-hexagons-1.JPG)

	use <hexagons.scad>;
	
	radius = 20;
	spacing = 2;
	levels = 3;
	
	hexagons(radius, spacing, levels);


![hexagons](images/lib2x-hexagons-2.JPG)
/**
* swap.scad
*
* @copyright Justin Lin, 2021
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-swap.html
*
**/ 

function swap(lt, i, j) =
    i == j ? lt :
    let(
	    leng = len(lt),
		ab = i < j ? [i, j] : [j, i],
		a = ab[0],
		b = ab[1]
	) 
	[
		each [for(idx = 0; idx < a; idx = idx + 1) lt[idx]],
		lt[b],
		each [for(idx = a + 1; idx < b; idx = idx + 1) lt[idx]],
		lt[a],
		each [for(idx = b + 1; idx < leng; idx = idx + 1) lt[idx]]
	];
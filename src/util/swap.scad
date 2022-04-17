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
		for(i = [0:leng - 1])
		if(i == a) lt[b] 
		else if(i == b) lt[a]
		else lt[i]
	];
use <../tri_delaunay.scad>;
use <../../util/map/hashmap_get.scad>;

function indicesOfCell(iTris, triIndices) = 
	_indicesOfCell(iTris, triIndices, len(iTris), [], iTris[0][0]);

function _indicesOfCell(iTris, triIndices, leng, indices, vi, i = 0) =
    i == leng ? indices :
	let(
	    t = iTris[search([vi], iTris)[0]],
		nIndices = concat(indices, hashmap_get(triIndices, t))
	)
	_indicesOfCell(iTris, triIndices, leng, nIndices, t[1], i + 1);

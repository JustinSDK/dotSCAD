use <../tri_delaunay.scad>;
use <../../util/map/hashmap_get.scad>;
use <../../util/find_index.scad>;

function indicesOfCell(iTris, triIndices, indicesOfCell) = 
    let(
	    vi = iTris[0][0],
		indices = [],
		leng = len(iTris)
	)
	_indicesOfCell(iTris, triIndices, leng, indices, vi, indicesOfCell);

function _indicesOfCell(iTris, triIndices, leng, indices, vi, indicesOfCell, i = 0) =
    i == leng ? indices :
	let(
	    t = iTris[find_index(iTris, function(t) t[0] == vi)],
		nIndices = concat(indices, hashmap_get(triIndices, t, hash = indicesOfCell))
	)
	_indicesOfCell(iTris, triIndices, leng, nIndices, t[1], indicesOfCell, i + 1);

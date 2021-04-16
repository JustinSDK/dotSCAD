use <experimental/tri_delaunay.scad>;
use <util/map/hashmap_get.scad>;
use <util/find_index.scad>;

function delaunay_coords(d) = d[0];
function delaunay_triangles(d) = d[1];
function delaunay_circles(d) = d[2];
	
function indicesOfCell(iTris, triIndices) = 
    let(
	    vi = iTris[0][0],
		indices = [],
		leng = len(iTris)
	)
	_indicesOfCell(iTris, triIndices, leng, indices, vi);

function _indicesOfCell(iTris, triIndices, leng, indices, vi, i = 0) =
    i == leng ? indices :
	let(
	    t = iTris[find_index(iTris, function(t) t[0] == vi)],
		nIndices = concat(indices, hashmap_get(triIndices, t))
	)
	_indicesOfCell(iTris, triIndices, leng, nIndices, t[1], i + 1);

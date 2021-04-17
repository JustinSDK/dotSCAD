use <_tri_delaunay_comm_impl.scad>;
use <experimental/tri_circumcircle.scad>;
use <util/map/hashmap.scad>;
use <util/map/hashmap_get.scad>;
use <util/map/hashmap_del.scad>;
use <util/map/hashmap_keys.scad>;
use <util/map/hashmap_put.scad>;
use <util/some.scad>;
use <util/has.scad>;
use <util/slice.scad>;
use <util/find_index.scad>;

function cc_center(cc) = cc[0];
function cc_rr(cc) = cc[2];

function delaunay_init(center, width, height) =
    let(
		halfW = width * 0.5,
		halfH = height * 0.5,
		coords = [
		    center + [-halfW, -halfH],
			center + [-halfW,  halfH],
			center + [ halfW,  halfH],
			center + [ halfW, -halfH],
		],
		t1 = [0, 1, 3], // indices
		t2 = [2, 3, 1],
		triangles = hashmap([
		        [t1, [t2, undef, undef]],
				[t2, [t1, undef, undef]]
		    ]
		),
		circles = hashmap([
		        [t1, tri_circumcircle([for(i = t1) coords[i]])],
				[t2, tri_circumcircle([for(i = t2) coords[i]])]
		    ]
		)
	)
	[coords, triangles, circles];

function delaunay_addpoint(d, p) =
    let(
	    idx = len(delaunay_coords(d)),
		ndelaunay = delaunayAddCoords(d, p),
		badTriangles = delaunayBadTriangles(ndelaunay, p),
		boundaries = delaunayBoundaries(ndelaunay, badTriangles),
		ndelaunay2 = delBadTriangles(ndelaunay, badTriangles),
		newTriangles = [
		    for(b = boundaries) [
			    [idx, b[0][0], b[0][1]], // t
				b[0],                    // edge
				b[1]                     // delaunayTri
			]
		]
	)
	adjustNeighbors(ndelaunay2, newTriangles);

function adjustNeighbors(d, newTriangles) = 
    let(
	    coords = delaunay_coords(d),
		nts = [
			for(nt = newTriangles)
			[nt[0], [nt[2], undef, undef]]
		],
	    ncs = [
		    for(nt = newTriangles)
			[nt[0], tri_circumcircle([for(i = nt[0]) coords[i]])]
		],
		nd = [
		    coords, 
			hashmap_puts(delaunay_triangles(d), nts), 
			hashmap_puts(delaunay_circles(d), ncs),
		],
		leng = len(newTriangles),
		aDtrid = _adjustNeighborsDtri(nd, newTriangles, leng)
	)
	_adjustNeighborsOtri(aDtrid, newTriangles, leng);

function hashmap_puts(m, kv_lt) = _hashmap_puts(m, kv_lt, len(kv_lt));

function _hashmap_puts(m, kv_lt, leng, i = 0) =
    i == leng ? m :
	let(kv = kv_lt[i])
	_hashmap_puts(hashmap_put(m, kv[0], kv[1]), kv_lt, leng, i + 1);

function _adjustNeighborsOtri(d, newTriangles, leng, i = 0) = 
    i == leng ? d :
	let(
	    t = newTriangles[i][0],
		nbr1 = newTriangles[(i + 1) % leng][0],
		nbr2 = newTriangles[i > 0 ? i - 1 : leng + i - 1][0],
		triangles = delaunay_triangles(d),
		v = hashmap_get(triangles, t),
		nTriangles = hashmap_put(hashmap_del(triangles, t), t, [v[0], nbr1, nbr2]),
		nd = [delaunay_coords(d), nTriangles, delaunay_circles(d)]
	)
	_adjustNeighborsOtri(nd, newTriangles, leng, i + 1);
 
function _adjustNeighborsDtri(d, newTriangles, leng, i = 0) =
    i == leng ? d :
    let(
	    t = newTriangles[i][0],
		edge = newTriangles[i][1],
		delaunayTri = newTriangles[i][2]
	)
	delaunayTri != undef ? 
	let(
	    neighbors = hashmap_get(delaunay_triangles(d), delaunayTri),
		nbri = find_index(neighbors, function(nbr) nbr != undef && has(nbr, edge[1]) && has(nbr, edge[0])),
		nd = nbri == -1 ? d : updateNbrs(d, delaunayTri, concat(slice(neighbors, 0, nbri), [t], slice(neighbors, nbri + 1)))
	)
    _adjustNeighborsDtri(nd, newTriangles, leng, i + 1) :
	_adjustNeighborsDtri(d, newTriangles, leng, i + 1);
	
function updateNbrs(d, delaunayTri, neighbors) =
    let(
	    coords = delaunay_coords(d),
	    triangles = delaunay_triangles(d),
		circles = delaunay_circles(d),
		nTriangles = hashmap_put(hashmap_del(triangles, delaunayTri), delaunayTri, neighbors)
	)
	[coords, nTriangles, circles];
	
function delaunayAddCoords(d, p) = 
    [
	    concat(delaunay_coords(d), [p]), 
		delaunay_triangles(d), 
		delaunay_circles(d)
	];

function delaunayBadTriangles(d, p) = 
    let(
	     triangles = delaunay_triangles(d),
		 circles = delaunay_circles(d)
	) 
	[
        for(t = hashmap_keys(triangles))
	        if(inCircumcircle(t, p, circles))
	            t
    ];

/* 
    is p in t?
    t: triangle indices
	circles: a hashmap
*/
function inCircumcircle(t, p, circles) = 
    let(
	    c = hashmap_get(circles, t),
		v = cc_center(c) - p,
		rr = v[0] ^ 2 + v[1] ^ 2
	)
	rr <= cc_rr(c);

function delaunayBoundaries(d, badTriangles) = 
    let(
	    boundaries = [],
		t = badTriangles[0],
		vi = 0
	)
	_delaunayBoundaries(d, badTriangles, boundaries, t, vi);

function _delaunayBoundaries(d, badTriangles, boundaries, t, vi) = 
    let(
	    triangles = delaunay_triangles(d),
	    opTri = hashmap_get(triangles, t)[vi]
	)
	some(badTriangles, function(tri) tri == opTri) ?
		let(
		    i = find_index(hashmap_get(triangles, opTri), function(tri) tri == t),
			nvi = (i + 1) % 3,
			nt = opTri
		)
		_delaunayBoundaries(d, badTriangles, boundaries, nt, nvi) : 
	    let(
		    nboundaries = concat(boundaries, [[
			    [t[(vi + 1) % 3], t[vi > 0 ? vi - 1 : (vi + 2)]], // edge
				opTri                                             // delaunayTri
			]]),
			nvi = (vi + 1) % 3,
			v1 = nboundaries[0][0][0],
			v2 = nboundaries[len(nboundaries) - 1][0][1]
		)
		v1 == v2 ? nboundaries : _delaunayBoundaries(d, badTriangles, nboundaries, t, nvi);

function delBadTriangles(d, badTriangles) = 
	[
		delaunay_coords(d), 
		hashmap_dels(delaunay_triangles(d), badTriangles), 
		hashmap_dels(delaunay_circles(d), badTriangles)
	];
	
function hashmap_dels(m, keys) = _hashmap_dels(m, keys, len(keys));

function _hashmap_dels(m, keys, leng, i = 0) = 
    i == leng ? m :
	_hashmap_dels(hashmap_del(m, keys[i]), keys, leng, i + 1);

function _tri_delaunay(d, points, leng, i = 0) =
    i == leng ? d :
	_tri_delaunay(delaunay_addpoint(d, points[i]), points, leng, i + 1);
use <_tri_delaunay_comm_impl.scad>;
use <../../util/map/hashmap.scad>;
use <../../util/map/hashmap_get.scad>;
use <../../util/map/hashmap_del.scad>;
use <../../util/map/hashmap_keys.scad>;
use <../../util/map/hashmap_put.scad>;
use <../../util/some.scad>;
use <../../util/has.scad>;
use <../../util/find_index.scad>;

function _tri_circumcircle(shape_pts) =
   let(
      p0 = shape_pts[0],
      p1 = shape_pts[1],
      p2 = shape_pts[2],
      v0 = p1 - p0,
      d0 = (p1 + p0) / 2 * v0,
      v1 = p2 - p1,
      d1 = (p2 + p1) / 2 * v1,
      det = -cross(v0 , v1)
   )
   det == 0 ? undef : 
             let(
                 x = (d1 * v0[1] - d0 * v1[1]) / det,
                 y = (d0 * v1[0] - d1 * v0[0]) / det,
                 center = [x, y],
                 v = p0 - center,
                 rr = v[0] ^ 2 + v[1] ^ 2
             )
             [center, rr];

function cc_center(cc) = cc[0];
function cc_rr(cc) = cc[1];

function delaunay_init(center, width, height, leng_points, _indices_hash) =
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
		number_of_buckets = ceil(leng_points * 0.5),
		triangles = hashmap([
		        [t1, [t2, undef, undef]],
				[t2, [t1, undef, undef]]
		    ],
			hash = _indices_hash,
			number_of_buckets = number_of_buckets
		),
		circles = hashmap([
		        [t1, _tri_circumcircle([for(i = t1) coords[i]])],
				[t2, _tri_circumcircle([for(i = t2) coords[i]])]
		    ],
			hash = _indices_hash,
			number_of_buckets = number_of_buckets
		)
	)
	[coords, triangles, circles];

function delaunay_addpoint(d, p, _indices_hash) =
    let(
	    idx = len(delaunay_coords(d)),
		ndelaunay = delaunayAddCoords(d, p),
		badTriangles = delaunayBadTriangles(ndelaunay, p, _indices_hash),
		boundaries = delaunayBoundaries(ndelaunay, badTriangles, _indices_hash),
		ndelaunay2 = delBadTriangles(ndelaunay, badTriangles, _indices_hash),
		newTriangles = [
		    for(b = boundaries) [
			    [idx, b[0][0], b[0][1]], // t
				b[0],                    // edge
				b[1]                     // delaunayTri
			]
		]
	)
	adjustNeighbors(ndelaunay2, newTriangles, _indices_hash);

function adjustNeighbors(d, newTriangles, _indices_hash) = 
    let(
	    coords = delaunay_coords(d),
		nts = [
			for(nt = newTriangles)
			[nt[0], [nt[2], undef, undef]]
		],
	    ncs = [
		    for(nt = newTriangles)
			[nt[0], _tri_circumcircle([for(i = nt[0]) coords[i]])]
		],
		nd = [
		    coords, 
			hashmap_puts(delaunay_triangles(d), nts, _indices_hash), 
			hashmap_puts(delaunay_circles(d), ncs, _indices_hash),
		],
		leng = len(newTriangles),
		aDtrid = _adjustNeighborsDtri(nd, newTriangles, leng, _indices_hash)
	)
	_adjustNeighborsOtri(aDtrid, newTriangles, leng, _indices_hash);

function hashmap_puts(m, kv_lt, _indices_hash) = _hashmap_puts(m, kv_lt, len(kv_lt), _indices_hash);

function _hashmap_puts(m, kv_lt, leng, _indices_hash, i = 0) =
    i == leng ? m :
	let(kv = kv_lt[i])
	_hashmap_puts(hashmap_put(m, kv[0], kv[1], hash = _indices_hash), kv_lt, leng, _indices_hash, i + 1);

function _adjustNeighborsOtri(d, newTriangles, leng, _indices_hash, i = 0) = 
    i == leng ? d :
	let(
	    t = newTriangles[i][0],
		nbr1 = newTriangles[(i + 1) % leng][0],
		nbr2 = newTriangles[i > 0 ? i - 1 : leng + i - 1][0],
		triangles = delaunay_triangles(d),
		v = hashmap_get(triangles, t, hash = _indices_hash),
		nTriangles = hashmap_put(hashmap_del(triangles, t, hash = _indices_hash), t, [v[0], nbr1, nbr2], hash = _indices_hash),
		nd = [delaunay_coords(d), nTriangles, delaunay_circles(d)]
	)
	_adjustNeighborsOtri(nd, newTriangles, leng, _indices_hash, i + 1);
 
function _adjustNeighborsDtri(d, newTriangles, leng, _indices_hash, i = 0) =
    i == leng ? d :
    let(
	    t = newTriangles[i][0],
		edge = newTriangles[i][1],
		delaunayTri = newTriangles[i][2]
	)
	delaunayTri != undef ? 
	let(
	    neighbors = hashmap_get(delaunay_triangles(d), delaunayTri, hash = _indices_hash),
		leng_nbrs = len(neighbors),
		nbri = find_index(neighbors, function(nbr) nbr != undef && has(nbr, edge[1]) && has(nbr, edge[0])),
		nd = nbri == -1 ? d : updateNbrs(d, delaunayTri, [
			for(j = 0; j < leng_nbrs; j = j + 1)
			    j == nbri ? t : neighbors[j]
		], _indices_hash)
	)
    _adjustNeighborsDtri(nd, newTriangles, leng, _indices_hash, i + 1) :
	_adjustNeighborsDtri(d, newTriangles, leng, _indices_hash, i + 1);
	
function updateNbrs(d, delaunayTri, neighbors, _indices_hash) =
    let(
	    coords = delaunay_coords(d),
	    triangles = delaunay_triangles(d),
		circles = delaunay_circles(d),
		nTriangles = hashmap_put(
			hashmap_del(triangles, delaunayTri, hash = _indices_hash), 
			delaunayTri, neighbors, hash = _indices_hash
		)
	)
	[coords, nTriangles, circles];
	
function delaunayAddCoords(d, p) = 
    [
	    concat(delaunay_coords(d), [p]), 
		delaunay_triangles(d), 
		delaunay_circles(d)
	];

function delaunayBadTriangles(d, p, _indices_hash) = 
    let(
	     triangles = delaunay_triangles(d),
		 circles = delaunay_circles(d)
	) 
	[
        for(t = hashmap_keys(triangles))
	        if(inCircumcircle(t, p, circles, _indices_hash))
	            t
    ];

/* 
    is p in t?
    t: triangle indices
	circles: a hashmap
*/
function inCircumcircle(t, p, circles, _indices_hash) = 
    let(
	    c = hashmap_get(circles, t, hash = _indices_hash),
		v = cc_center(c) - p,
		rr = v[0] ^ 2 + v[1] ^ 2
	)
	rr <= cc_rr(c);

function delaunayBoundaries(d, badTriangles, _indices_hash) = 
    let(
	    boundaries = [],
		t = badTriangles[0],
		vi = 0
	)
	_delaunayBoundaries(d, badTriangles, boundaries, t, vi, _indices_hash);

function _delaunayBoundaries(d, badTriangles, boundaries, t, vi, _indices_hash) = 
    let(
	    triangles = delaunay_triangles(d),
	    opTri = hashmap_get(triangles, t, hash = _indices_hash)[vi]
	)
	some(badTriangles, function(tri) tri == opTri) ?
		let(
		    i = find_index(hashmap_get(triangles, opTri, hash = _indices_hash), function(tri) tri == t),
			nvi = (i + 1) % 3,
			nt = opTri
		)
		_delaunayBoundaries(d, badTriangles, boundaries, nt, nvi, _indices_hash) : 
	    let(
		    nboundaries = concat(boundaries, [[
			    [t[(vi + 1) % 3], t[vi > 0 ? vi - 1 : (vi + 2)]], // edge
				opTri                                             // delaunayTri
			]]),
			nvi = (vi + 1) % 3,
			v1 = nboundaries[0][0][0],
			v2 = nboundaries[len(nboundaries) - 1][0][1]
		)
		v1 == v2 ? nboundaries : _delaunayBoundaries(d, badTriangles, nboundaries, t, nvi, _indices_hash);

function delBadTriangles(d, badTriangles, _indices_hash) = 
	[
		delaunay_coords(d), 
		hashmap_dels(delaunay_triangles(d), badTriangles, _indices_hash), 
		hashmap_dels(delaunay_circles(d), badTriangles, _indices_hash)
	];
	
function hashmap_dels(m, keys, _indices_hash) = _hashmap_dels(m, keys, len(keys), _indices_hash);

function _hashmap_dels(m, keys, leng, _indices_hash, i = 0) = 
    i == leng ? m :
	_hashmap_dels(hashmap_del(m, keys[i], hash = _indices_hash), keys, leng, _indices_hash, i + 1);

function _tri_delaunay(d, points, leng, _indices_hash, i = 0) =
    i == leng ? d :
	_tri_delaunay(
		delaunay_addpoint(d, points[i], _indices_hash), 
	points, leng, _indices_hash, i + 1);
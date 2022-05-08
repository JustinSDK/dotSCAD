function _in_triangle(p0, p1, p2, p) =
    let(
        v0 = p0 - p,
        v1 = p1 - p,
        v2 = p2 - p,
        c0 = cross(v0, v1),
        c1 = cross(v1, v2),
        c2 = cross(v2, v0)
    )
    (c0 > 0 && c1 > 0 && c2 > 0) || (c0 < 0 && c1 < 0 && c2 < 0);

function _snipable(shape_pts, u, v, w, n, indices, epsilon = 0.0001) =
    let(
        a = shape_pts[indices[u]],
        b = shape_pts[indices[v]],
        c = shape_pts[indices[w]]
    )
    epsilon <= cross(b - a, c - a) && _snipable_sub(shape_pts, n, u, v, w, a, b, c, indices);
    
function _snipable_sub(shape_pts, n, u, v, w, a, b, c, indices, p = 0) = 
    p == n || (
        (((p == u) || (p == v) || (p == w)) && _snipable_sub(shape_pts, n, u, v, w, a, b, c, indices, p + 1)) || 
        (_snipable_sub(shape_pts, n, u, v, w, a, b, c, indices, p + 1) && !_in_triangle(a, b, c, shape_pts[indices[p]]))
    );

// remove the elem at idx v from indices  
function _remove_v(indices, v, num_of_vertices) = 
    let(nv_minuns_one = num_of_vertices - 1)
    v == 0 ? [for(i = 1; i <= nv_minuns_one; i = i + 1) indices[i]] : 
    let(n_indices = [for(i = 0; i < v; i = i + 1) indices[i]])
    v == nv_minuns_one ? n_indices : concat(n_indices, [for(i = v + 1; i <= nv_minuns_one; i = i + 1) indices[i]]);
    
function _zero_or_value(num_of_vertices, value) = num_of_vertices <= value ? 0 : value;

function _triangulate_real_triangulate_sub(shape_pts, collector, indices, v, num_of_vertices, count, epsilon) = 
    let(
        // idxes of three consecutive vertices
        u = _zero_or_value(num_of_vertices, v),     
        vi = _zero_or_value(num_of_vertices, u + 1), 
        w = _zero_or_value(num_of_vertices, vi + 1) 
    )
    _snipable(shape_pts, u, vi, w, num_of_vertices, indices, epsilon) ? 
        _snip(shape_pts, collector, indices, u, vi, w, num_of_vertices, count, epsilon) : 
        _real_triangulate(shape_pts, collector, indices, vi, num_of_vertices, count, epsilon);
        
function _snip(shape_pts, collector, indices, u, v, w, num_of_vertices, count, epsilon) = 
    let(new_nv = num_of_vertices - 1)
    _real_triangulate( 
        shape_pts, 
        [each collector, [indices[u], indices[v], indices[w]]],  
        _remove_v(indices, v, num_of_vertices),
        v, 
        new_nv,
        2 * new_nv,
        epsilon
    );

function _real_triangulate(shape_pts, collector, indices, v, num_of_vertices, count, epsilon) = 
    count <= 0 ? [] : 
    num_of_vertices == 2 ? collector : 
                           _triangulate_real_triangulate_sub(shape_pts, collector, indices, v, num_of_vertices, count - 1,  epsilon);
    
function _tri_ear_clipping_impl(shape_pts,  epsilon) =
    let(
        num_of_vertices = len(shape_pts),
        v = num_of_vertices - 1,
        count = 2 * num_of_vertices        
    )
    num_of_vertices < 3 ? [] : _real_triangulate(shape_pts, [], [each [0:v]], v, num_of_vertices, count, epsilon);
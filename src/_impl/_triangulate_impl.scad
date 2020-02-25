function _triangulate_in_triangle(p0, p1, p2, p) =
    let(
        v0 = p0 - p,
        v1 = p1 - p,
        v2 = p2 - p,
        c0 = cross(v0, v1),
        c1 = cross(v1, v2),
        c2 = cross(v2, v0)
    )
    (c0 > 0 && c1 > 0 && c2 > 0) || (c0 < 0 && c1 < 0 && c2 < 0);

function _triangulate_snipable(shape_pts, u, v, w, n, indices, epsilon = 0.0001) =
    let(
        a = shape_pts[indices[u]],
        b = shape_pts[indices[v]],
        c = shape_pts[indices[w]],
        ax = a[0],
        ay = a[1],
        bx = b[0],
        by = b[1],
        cx = c[0],
        cy = c[1],
        determinant = cross([bx - ax, by - ay],  [cx - ax, cy - ay])
    )
    epsilon > determinant ? 
        false : _triangulate_snipable_sub(shape_pts, n, u, v, w, a, b, c, indices);
    
function _triangulate_snipable_sub(shape_pts, n, u, v, w, a, b, c, indices, p = 0) = 
    p == n ? true : (
        ((p == u) || (p == v) || (p == w)) ? _triangulate_snipable_sub(shape_pts, n, u, v, w, a, b, c, indices, p + 1) : (
            _triangulate_in_triangle(a, b, c, shape_pts[indices[p]]) ? 
                false : _triangulate_snipable_sub(shape_pts, n, u, v, w, a, b, c, indices, p + 1)
        )
    );

// remove the elem at idx v from indices  
function _triangulate_remove_v(indices, v, num_of_vertices) = 
    let(
        nv_minuns_one = num_of_vertices - 1
    )
    v == 0 ? [for(i = 1; i <= nv_minuns_one; i = i + 1) indices[i]] : (
        v == nv_minuns_one ? [for(i = 0; i < v; i = i + 1) indices[i]] : concat(
            [for(i = 0; i < v; i = i + 1) indices[i]], 
            [for(i = v + 1; i <= nv_minuns_one; i = i + 1) indices[i]]
        )
    );
    
function _triangulate_zero_or_value(num_of_vertices, value) = 
    num_of_vertices <= value ? 0 : value;

function _triangulate_real_triangulate_sub(shape_pts, collector, indices, v, num_of_vertices, count, epsilon) = 
    let(
        // idxes of three consecutive vertices
        u = _triangulate_zero_or_value(num_of_vertices, v),     
        vi = _triangulate_zero_or_value(num_of_vertices, u + 1), 
        w = _triangulate_zero_or_value(num_of_vertices, vi + 1) 
    )
    _triangulate_snipable(shape_pts, u, vi, w, num_of_vertices, indices, epsilon) ? 
        _triangulate_snip(shape_pts, collector, indices, u, vi, w, num_of_vertices, count, epsilon) : 
        _triangulate_real_triangulate(shape_pts, collector, indices, vi, num_of_vertices, count, epsilon);
        
function _triangulate_snip(shape_pts, collector, indices, u, v, w, num_of_vertices, count, epsilon) = 
    let(
        a = indices[u],
        b = indices[v],
        c = indices[w],
        new_nv = num_of_vertices - 1
    )
    _triangulate_real_triangulate( 
        shape_pts, 
        concat(collector, [[a, b, c]]),  
        _triangulate_remove_v(indices, v, num_of_vertices),
        v, 
        new_nv,
        2 * new_nv,
        epsilon
    );

function _triangulate_real_triangulate(shape_pts, collector, indices, v, num_of_vertices, count, epsilon) = 
    count <= 0 ? [] : (
        num_of_vertices == 2 ? 
            collector : _triangulate_real_triangulate_sub(shape_pts, collector, indices, v, num_of_vertices, count - 1,  epsilon)
    );
    
function _triangulate_impl(shape_pts,  epsilon) =
    let(
        num_of_vertices = len(shape_pts),
        v = num_of_vertices - 1,
        indices = [for(vi = 0; vi <= v; vi = vi + 1) vi],
        count = 2 * num_of_vertices        
    )
    num_of_vertices < 3 ? [] : _triangulate_real_triangulate(shape_pts, [], indices, v, num_of_vertices, count, epsilon);
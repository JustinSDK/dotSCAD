use <../util/sorted.scad>
use <../util/some.scad>
use <../matrix/m_replace.scad>

org = [0, 0, 0];

function normal(pts, f) = 
    let(p = pts[f[0]]) cross(pts[f[1]] - p, pts[f[2]] - p);

function _fst_v1(pts, leng, p, i) =
    i == leng || (pts[i] - p) != org ? i : _fst_v1(pts, leng, p, i + 1);
  
function _fst_v2(pts, leng, v1, p, i) = 
    i == leng || cross(pts[v1] - p, pts[i] - p) != org ? i : _fst_v2(pts, leng, v1, p, i + 1);

function _fst_v3(pts, leng, n, d, p, i) =
    i == leng ? [i, d] :
    let(nd = n * (pts[i] - p))
    nd != 0 ? [i, nd] : _fst_v3(pts, leng, n, nd, p, i + 1);

function next_vis(i, pts, cur_faces, cur_faces_leng, next, vis, j = 0) = 
    j == cur_faces_leng ? [next, vis] :
    let(
        f = cur_faces[j],
        f0 = f[0],
        f1 = f[1],
        f2 = f[2],
        d = (pts[f0] - pts[i]) * normal(pts, f),
        nx = d >= 0 ? [each next, f] : next,
        s = sign(d),
        vis1 = m_replace(vis, f0, f1, s),
        vis2 = m_replace(vis1, f1, f2, s),
        vis3 = m_replace(vis2, f2, f0, s)
    )
    next_vis(i, pts, cur_faces, cur_faces_leng, nx, vis3, j + 1);
    
function next2(i, cur_faces, cur_faces_leng, vis, next, j = 0) = 
    j == cur_faces_leng ? next : 
    let(
        f = cur_faces[j],
        a = f[0],
        b = f[1],
        c = f[2],
        vis_a = vis[a],
        vis_b = vis[b],
        vis_c = vis[c],
        nx1 = vis_a[b] < 0 && vis_a[b] != vis_b[a] ? 
            [each next, [a, b, i]] : next,
        nx2 = vis_b[c] < 0 && vis_b[c] != vis_c[b] ? 
            [each nx1, [b, c, i]] : nx1,        
        nx3 = vis_c[a] < 0 && vis_c[a] != vis_a[c] ? 
            [each nx2, [c, a, i]] : nx2                    
    )
    next2(i, cur_faces, cur_faces_leng, vis, nx3, j + 1);

function _all_faces(v0123, pts, pts_leng, vis, cur_faces, i = 0) =
    i == pts_leng ? cur_faces :
    let(
        vis_faces = some(v0123, function(vi) i == vi) ? [vis, cur_faces] :
            let(
                cur_faces_leng = len(cur_faces),
                nv = next_vis(i, pts, cur_faces, cur_faces_leng, [], vis),
                nx1 = nv[0],
                vis1 = nv[1],
                nx2 = next2(i, cur_faces, cur_faces_leng, vis1, nx1)
            ) 
            [vis1, nx2]
    )
    _all_faces(v0123, pts, pts_leng, vis_faces[0], vis_faces[1], i + 1);

function _convex_hull3(pts) = 
    let(
        sorted_pts = sorted(pts),
        leng = len(sorted_pts),
        p0 = sorted_pts[0],
        v0 = 0,
        v1 =  _fst_v1(sorted_pts, leng, p0, v0 + 1),
        v2 = assert(v1 < leng, "common points") 
             _fst_v2(sorted_pts, leng, v1, p0, v1 + 1),
        n = assert(v2 < leng, "collinear points") 
            cross(sorted_pts[v1] - p0, sorted_pts[v2] - p0),
        v3_d = _fst_v3(sorted_pts, leng, n, 0, p0, v2 + 1),
        v3 = v3_d[0],
        d = assert(v3 < leng, "coplanar points")
            v3_d[1],
        fst_tetrahedron = d > 0 ? [
                [v1, v0, v2],
                [v0, v1, v3],
                [v1, v2, v3],
                [v2, v0, v3]
            ] 
            : 
            [
                [v0, v1, v2],
                [v1, v0, v3],
                [v2, v1, v3],
                [v0, v2, v3]
            ],
        zeros = [for(j = [0:leng - 1]) 0],
        init_vis = [for(i = [0:leng - 1]) zeros],
        faces = _all_faces([v0, v1, v2, v3], sorted_pts, leng, init_vis, fst_tetrahedron), // counter-clockwise
        reversed = [
            for(face = faces)      // OpenSCAD requires clockwise.
            [face[2], face[1], face[0]]
        ]
    )
    [
        sorted_pts,
        reversed   
    ];
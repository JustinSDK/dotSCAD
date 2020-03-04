function _voronoi2d_lines_tri_vertex(tri, p) = 
    tri[0] == p || tri[1] == p || tri[2] == p;

function _voronoi2d_lines_tri_same(tri1, tri2) = 
    _voronoi2d_lines_tri_vertex(tri1, tri2[0]) && _voronoi2d_lines_tri_vertex(tri1, tri2[1]) && _voronoi2d_lines_tri_vertex(tri1, tri2[2]);

function _voronoi2d_lines_tri_coedge(tri1, tri2) =
    let(
        n1 = _voronoi2d_lines_tri_vertex(tri2, tri1[0]) ? 1 : 0,
        n2 = _voronoi2d_lines_tri_vertex(tri2, tri1[1]) ? 1 : 0,
        n = n1 + n2
    )
    (n > 1) || ((n + (_voronoi2d_lines_tri_vertex(tri2, tri1[2]) ? 1 : 0)) > 1);
    
function _voronoi2d_lines_tri_neighbors_impl(tris, me, leng, nbrs = [], i = 0) = 
    len(nbrs) == 3 || i == leng ? nbrs :
    !_voronoi2d_lines_tri_same(me, tris[i]) && _voronoi2d_lines_tri_coedge(me, tris[i]) ? _voronoi2d_lines_tri_neighbors_impl(tris, me, leng, concat(nbrs, [tris[i]]), i + 1) :
    _voronoi2d_lines_tri_neighbors_impl(tris, me, leng, nbrs, i + 1);
        
function _voronoi2d_lines_tri_neighbors(tris, me) = 
    _voronoi2d_lines_tri_neighbors_impl(tris, me, len(tris));       

function _voronoi2d_lines_line_has(line, p) =
    p == line[0] || p == line[1];

function _voronoi2d_lines_same_line(line1, line2) =
    _voronoi2d_lines_line_has(line1, line2[0]) && _voronoi2d_lines_line_has(line1, line2[1]);

function _voronoi2d_lines_lines_has(lines, line, leng, i = 0) = 
    i == leng ? false :
    _voronoi2d_lines_same_line(lines[i], line) ? true : _voronoi2d_lines_lines_has(lines, line, leng, i + 1);

function _voronoi2d_lines_dedup_lines_impl(src, dest, leng, i = 0) = 
    i == leng ? dest :
    _voronoi2d_lines_lines_has(dest, src[i], len(dest)) ? _voronoi2d_lines_dedup_lines_impl(src, dest, leng, i + 1) : _voronoi2d_lines_dedup_lines_impl(src, concat(dest, [src[i]]), leng, i + 1);

function _voronoi2d_lines_dedup_lines(lines) = _voronoi2d_lines_dedup_lines_impl(lines, [], len(lines));

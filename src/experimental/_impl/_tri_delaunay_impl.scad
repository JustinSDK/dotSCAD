use <experimental/tri_circumcircle.scad>;

// [max, min, min, max]      
function _tri_delaunay_boundIndices(points, leng, indices, i = 0) =
    let(
        bounds = i < leng - 1 ? _tri_delaunay_boundIndices(points, leng, indices, i + 1)
                              : [undef, undef, undef, undef],
        p0 = points[indices[0]],
        p1 = points[indices[1]],
        p2 = points[i],
        c_circle = tri_circumcircle([p0, p1, p2]),
        r = c_circle[1],
        cside = c_circle == [] ? undef : cross(p1 - p0, c_circle[0] - p1),
        pside = cross(p1 - p0, p2 - p1),
        pdot = (p2 - p0) * (p2 - p1)
    )
    pdot < 0 && 0 == pside  ? [-1, 1, 1, -1] :
    c_circle == [] ? bounds :
    pside > 0 && cside > 0  ? [bounds[0], bounds[1], bounds[2], bounds[3] ? min(bounds[3], r) : r]  :
    pside > 0 && cside <= 0 ? [bounds[0], bounds[1], bounds[2] ? max(bounds[2], r) : r, bounds[3]] :
    pside <= 0 && cside > 0 ? [bounds[0], bounds[1] ? max(bounds[1],r) : r, bounds[2], bounds[3]] :
                              [bounds[0] ? min(bounds[0], r) : r, bounds[1], bounds[2], bounds[3]]; // is_undef(cside) also returns this

function _tri_delaunay_try_triangle(points, indices_boundIndices, i) = 
   let(
      indices = indices_boundIndices[0],
      bounds = indices_boundIndices[1],
      p0 = points[indices[0]],
      p1 = points[indices[1]],
      p2 = points[i],
      c_circle = tri_circumcircle([p0, p1, p2]),
      r = c_circle[1],
      cside = c_circle == [] ? undef : cross(p1 - p0, c_circle[0] - p1)
   )
   c_circle == [] ? undef : 
   (cside > 1  && (!bounds[2] && (!bounds[1] || r>=bounds[1]) && (!bounds[3] || r<=bounds[3]))) ||
   (cside <= 1 && (!bounds[1] && (!bounds[2] || r>=bounds[2]) && (!bounds[0] || r<=bounds[0]))) ? concat(indices, [i]) :
   undef;
   
function _tri_delaunay_triangleIndices(points, leng, indices_boundIndices, triangles, i = 0) =
   let(
      indices = indices_boundIndices[0],
      newtriangle = _tri_delaunay_try_triangle(points, indices_boundIndices, i),
      newtriangles = newtriangle ? concat(triangles, [newtriangle]) : triangles
   )
   i <= indices[1] ? _tri_delaunay_triangleIndices(points, leng, indices_boundIndices, [], indices[1] + 1) : 
   i< leng - 1 ? _tri_delaunay_triangleIndices(points, leng, indices_boundIndices, newtriangles,i + 1) :
   newtriangles;
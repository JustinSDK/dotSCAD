function tri_circumcircle(points) =
   let(
      p0 = points[0],
      p1 = points[1],
      p2 = points[2],
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
                 r = norm(v),
                 rr = pow(v[0], 2) + pow(v[1], 2)
             )
             [center, r, rr];
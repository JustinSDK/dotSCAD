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
   det == 0? [] : 
             let(
                 x = (d1 * v0[1] - d0 * v1[1]) / det,
                 y = (d0 * v1[0] - d1 * v0[0]) / det,
                 r = norm(p0 - [x,y])
             )
             [[x,y], r];
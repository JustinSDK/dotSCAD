use <experimental/_impl/_tri_delaunay_impl.scad>;
use <experimental/flat.scad>;

function tri_delaunay(points)=
   let(
      leng = len(points),
      indices_lt = [for(i=[0:leng - 3]) for(j = [i + 1:leng - 2]) [i, j]],
      indices_boundIndices_lt = [
          for(indices = indices_lt) 
              [indices, _tri_delaunay_boundIndices(points, leng, indices)]
      ]
   )
   flat(
       [
           for(indices_boundIndices = indices_boundIndices_lt) 
               _tri_delaunay_triangleIndices(points, leng, indices_boundIndices, [])
       ]
   );
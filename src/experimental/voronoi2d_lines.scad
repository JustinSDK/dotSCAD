use <experimental/_impl/_voronoi2d_lines_impl.scad>;
use <experimental/tri_delaunay.scad>;
use <experimental/tri_circumcircle.scad>;

function voronoi2d_lines(points) = 
    let(
        tris = [
            for(idxes = tri_delaunay(points))
            [points[idxes[0]], points[idxes[1]], points[idxes[2]]]
        ],
        lines = [for(me = tris) 
        let(
            nbrs = _voronoi2d_lines_tri_neighbors(tris, me),
            circumcircle_cpts = [
                for(nbr = concat([me], nbrs))
                tri_circumcircle(nbr)[0]
            ],
            leng = len(circumcircle_cpts),
            lines = leng <= 1 ? [] :
            [
                for(i = [1:len(circumcircle_cpts) - 1])
                [circumcircle_cpts[0], circumcircle_cpts[i]]
            ]
        )
            each lines
        ]
    )
    _voronoi2d_lines_dedup_lines(lines); 
use <../__comm__/__lines_from.scad>;
use <../__comm__/__line_intersection.scad>;
    
function _bijection_inward_edge_normal(edge) =  
    let(
        pt1 = edge[0],
        pt2 = edge[1],
        dx = pt2.x - pt1.x,
        dy = pt2.y - pt1.y,
        edge_leng = norm([dx, dy])
    )
    [-dy / edge_leng, dx / edge_leng];

function _bijection_outward_edge_normal(edge) = -1 * _bijection_inward_edge_normal(edge);

function _bijection_offset_edge(edge, dx, dy) = 
    let(
        pt1 = edge[0],
        pt2 = edge[1],
        dxy = [dx, dy]
    )
    [pt1 + dxy, pt2 + dxy];
    
function _bijection__bijection_offset_edges(edges, d) = 
    [ 
        for(edge = edges)
        let(ow_normal_d = _bijection_outward_edge_normal(edge) * d)
        _bijection_offset_edge(edge, ow_normal_d.x, ow_normal_d.y)
    ];

function _bijection_offset_impl(pts, d, epsilon) = 
    let(
        es = __lines_from(pts, true), 
        offset_es = _bijection__bijection_offset_edges(es, d),
        leng = len(offset_es),
        leng_minus_one = leng - 1,
        last_p = __line_intersection2(offset_es[leng_minus_one], offset_es[0], epsilon)
    )
    [
        if(last_p != [] && last_p == last_p) last_p,
        each [
            for(i = 0; i < leng_minus_one; i = i + 1)
            let(
                this_edge = offset_es[i],
                next_edge = offset_es[i + 1],
                p = __line_intersection2(this_edge, next_edge, epsilon)
            )
            // p == p to avoid [nan, nan], because [nan, nan] != [nan, nan]
            assert(p != [] && p == p, "bijection_offset failed. Parallel or conincident edges found")
            p
        ]
    ];
    
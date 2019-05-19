function _bijection_edges_from(pts) = 
    let(leng = len(pts))
    concat(
        [for(i = [0:leng - 2]) [pts[i], pts[i + 1]]], 
        [[pts[len(pts) - 1], pts[0]]]
    );
    
// 往內的法向量
function _bijection_inward_edge_normal(edge) =  
    let(
        pt1 = edge[0],
        pt2 = edge[1],
        dx = pt2[0] - pt1[0],
        dy = pt2[1] - pt1[1],
        edge_leng = norm([dx, dy])
    )
    [-dy / edge_leng, dx / edge_leng];

// 往外的法向量   
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
        let(
            ow_normal = _bijection_outward_edge_normal(edge),
            dx = ow_normal[0] * d,
            dy = ow_normal[1] * d
        )
        _bijection_offset_edge(edge, dx, dy)
    ];
    

function _bijection__bijection__bijection_offset_edges_intersection(edge1, edge2) = 
    let(
        den = (edge2[1][1] - edge2[0][1]) * (edge1[1][0] - edge1[0][0]) - (edge2[1][0] - edge2[0][0]) * (edge1[1][1] - edge1[0][1])
    )
    // when den is 0, they are parallel or conincident edges
    den == 0 ? [] : _bijection_offset__bijection__bijection__bijection_offset_edges_intersection_sub(edge1, edge2, den);

function _bijection_offset__bijection__bijection__bijection_offset_edges_intersection_sub(edge1, edge2, den) = 
    let(
        ua = ((edge2[1][0] - edge2[0][0]) * (edge1[0][1] - edge2[0][1]) - (edge2[1][1] - edge2[0][1]) * (edge1[0][0] - edge2[0][0])) / den
    ) 
    [
        edge1[0][0] + ua * (edge1[1][0] - edge1[0][0]),
        edge1[0][1] + ua * (edge1[1][1] - edge1[0][1])
    ];

function bijection_offset(pts, d) = 
    let(
        es = _bijection_edges_from(pts), 
        offset_es = _bijection__bijection_offset_edges(es, d),
        leng = len(offset_es),
        last_p = _bijection__bijection__bijection_offset_edges_intersection(offset_es[leng - 1], offset_es[0])
    )
    concat(
        [
            for(i = [0:leng - 2]) 
            let(
                this_edge = offset_es[i],
                next_edge = offset_es[i + 1],
                p = _bijection__bijection__bijection_offset_edges_intersection(this_edge, next_edge)
            )
            // p == p to avoid [nan, nan], because [nan, nan] != [nan, nan]
            if(p != [] && p == p) p
        ],
        last_p != [] && last_p == last_p ? [last_p] : []
    );
    
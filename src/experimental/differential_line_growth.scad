use <_impl/_differential_line_growth.scad>

function differential_line_growth(points, option, times) = 
    let(
        init_nodes = [
            for(p = points)
            node(p, option)
        ],
        nodes_lt = [
            for(i = 0, line = _differential_line_growth(init_nodes); 
                i < times; 
                i = i + 1, 
                line = _differential_line_growth(line)
            )
            line
        ]
    )
    [for(node = nodes_lt[times - 1]) position_of(node)];
    
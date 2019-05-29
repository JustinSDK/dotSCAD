function __edges_from(pts, closed = true) = 
    let(leng = len(pts))
    concat(
        [for(i = [0:leng - 2]) [pts[i], pts[i + 1]]], 
        closed ? [[pts[len(pts) - 1], pts[0]]] : []
    );
    
function px_sphere(radius, filled = false, thickness = 1) = 
    let(range = [-radius: radius - 1])
    filled ? [
        for(z = range)
            for(y = range)        
               for(x = range)
                   let(v = [x, y, z])
                   if(norm(v) < radius) v
    ] :
    let(ishell = radius * radius - 2 * thickness * radius)
    [
        for(z = range)
            for(y = range)        
               for(x = range)
                   let(
                       v = [x, y, z],
                       leng = norm(v)
                   )
                   if(leng < radius && (leng * leng) > ishell) v    
    ];
    
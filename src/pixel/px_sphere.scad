function px_sphere(radius, filled = true) = 
    let(range = [-radius: radius - 1])
    filled ? [
        for(x = range)
            for(y = range)        
               for(z = range)
                   let(v = [x, y, z])
                   if(norm(v) < radius) v
    ] :
    let(ishell = radius * radius - 2 * radius)
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
    
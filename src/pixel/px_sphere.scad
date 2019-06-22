function px_sphere(radius, filled = true) = 
    filled ? [
        for(x = -radius; x < radius; x = x + 1)
            for(y = -radius; y < radius; y = y + 1)        
               for(z = -radius; z < radius; z = z + 1)
                   let(v = [x, y, z])
                   if(norm(v) < radius) v
    ] :
    let(ishell = radius * radius - 2 * radius)
    [
        for(x = -radius; x < radius; x = x + 1)
            for(y = -radius; y < radius; y = y + 1)        
               for(z = -radius; z < radius; z = z + 1)
                   let(
                       v = [x, y, z],
                       leng = norm(v)
                   )
                   if(leng < radius && (leng * leng) > ishell) v    
    ];
    
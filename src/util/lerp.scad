function lerp(p0, p1, amt) = 
    let(
        v = p1 - p0,
        leng = len(p0)
    )
    [for(i = 0; i < leng; i = i + 1) p0[i] + v[i] * amt];
function lerp(v1, v2, amt) = 
    let(
        v = v2 - v1,
        leng = len(v1)
    )
    [for(i = 0; i < leng; i = i + 1) v1[i] + v[i] * amt];
function _pnoise1(x, n, gradients) =
    let(
        lo = floor(x),
        hi = (lo + 1) % n,
        dist = x - lo,
        loPos = gradients[lo] * dist,
        hiPos = -gradients[hi] * (1 - dist),
        u = pow(dist, 3) * (dist * (dist * 6 - 15) + 10)
    )
    loPos * (1 - u) + hiPos * u;
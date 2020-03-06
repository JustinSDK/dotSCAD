function _pnoise_fade(t) = pow(t, 3) * (t * (t * 6 - 15) + 10);

function _pnoise1(x, n, gradients) =
    let(
        lo = floor(x),
        hi = (lo + 1) % n,
        t = x - lo,
        loPos = gradients[lo] * t,
        hiPos = -gradients[hi] * (1 - t),
        u = _pnoise_fade(t)
    )
    loPos * (1 - u) + hiPos * u;
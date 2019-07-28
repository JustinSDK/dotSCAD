function _bspline_curve_knots(n, degree) = 
    let(end = n + degree + 1)
    [for(i = 0; i < end; i = i + 1) i];
    
function _bspline_curve_weights(n) = [for(i = 0; i < n; i = i + 1) 1];

function _bspline_curve_ts(ot, degree, knots) = 
    let(
        domain = [degree, len(knots) - 1 - degree],
        low  = knots[domain[0]],
        high = knots[domain[1]],
        t = ot * (high - low) + low,
        s = _bspline_curve_s(domain[0], domain[1], t, knots)
    )
    [t, s];
    
function _bspline_curve_s(s, end, t, knots) =
    t >= knots[s] && t <= knots[s+1] ? 
        s : _bspline_curve_s(s + 1, end, t, knots);

function _bspline_curve_alpha(i, l, t, degree, knots) = 
    (t - knots[i]) / (knots[i + degree + 1 - l] - knots[i]);

function _bspline_curve_nvi(v, i, l, t, degree, knots) =
    let(
        alpha = _bspline_curve_alpha(i, l, t, degree, knots)
    )
    [[for(j = 0; j< 4; j = j + 1) ((1 - alpha) * v[i - 1][j] + alpha * v[i][j])]];

function _bspline_curve_nvl(v, l, s, t, degree, knots, i) = 
    i == (s - degree - 1 + l) ? v :
    let(
        nvi = _bspline_curve_nvi(v, i, l, t, degree, knots),
        nv = concat(
            [for(j = 0; j < i; j = j + 1) v[j]],
            nvi,
            [for(j = i + 1; j < len(v); j = j + 1) v[j]]
        )
    )
    _bspline_curve_nvl(nv, l, s, t, degree, knots, i - 1);

function _bspline_curve_v(v, s, t, degree, knots, l = 1) = 
    l > degree + 1 ? v : 
      let(nv = _bspline_curve_nvl(v, l, s, t, degree, knots, s))
      _bspline_curve_v(nv, s, t, degree, knots, l + 1);
        
function _bspline_curve_interpolate(t, degree, points, knots, weights) =
    let(
        n = len(points),
        kts = is_undef(knots) ? _bspline_curve_knots(n, degree) : knots,
        wts = is_undef(weights) ? _bspline_curve_weights(n) : weights,
        v = [
            for(i = 0; i < n; i = i + 1) 
            let(p = points[i] * wts[i])
            [p[0], p[1], p[2], wts[i]]
        ],
        ts = _bspline_curve_ts(t, degree, kts),
        nt = ts[0],
        s = ts[1],
        nv = _bspline_curve_v(v, s, nt, degree, kts)
    )
    [for(i = 0; i < 3; i = i + 1) nv[s][i] / nv[s][3]];
    
function bspline_curve(t_step, degree, points, knots, weights) = 
    [
        for(t = 0; t < 1; t = t + t_step) 
        _bspline_curve_interpolate(t, degree, points, knots, weights)
    ];    
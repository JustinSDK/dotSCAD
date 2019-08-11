/**
* bspline_curve.scad
*
* @copyright Justin Lin, 2019
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib2-bspline_curve.html
*
**/

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
        d = len(points[0]),
        n = len(points),
        kts = is_undef(knots) ? _bspline_curve_knots(n, degree) : knots,
        wts = is_undef(weights) ? _bspline_curve_weights(n) : weights,
        v = [
            for(i = 0; i < n; i = i + 1) 
            let(p = points[i] * wts[i])
            concat([for(j = 0; j < d; j = j + 1) p[j]], [wts[i]])
        ],
        ts = _bspline_curve_ts(t, degree, kts),
        s = ts[1],
        nv = _bspline_curve_v(v, s, ts[0], degree, kts)
    )
    [for(i = 0; i < d; i = i + 1) nv[s][i] / nv[s][d]];
    
function bspline_curve(t_step, degree, points, knots, weights) = 
    let(n = len(points))
    assert(degree >= 1, "degree cannot be less than 1 (linear)")
    assert(degree <= n - 1, "degree must be less than or equal to len(points) - 1")
    assert(is_undef(knots) || (len(knots) == n + degree + 1), "len(knots) must be equals to len(points) + degree + 1")
    [
        for(t = 0; t < 1; t = t + t_step) 
        _bspline_curve_interpolate(t, degree, points, knots, weights)
    ];    
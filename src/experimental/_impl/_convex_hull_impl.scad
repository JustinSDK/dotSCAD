use <util/slice.scad>;

// oa->ob ct_clk : greater than 0
function _dir(o, a, b) =
    let(
        ox = o[0],
        oy = o[1],
        ax = a[0],
        ay = a[1],
        bx = b[0],
        by = b[1]
    )
    (ax - ox) * (by - oy) - (ay - oy) * (bx - ox);

function _lower_m(chain, p, m) = 
    (m >= 2 && _dir(chain[m - 2], chain[m - 1], p) <= 0) ? _lower_m(chain, p, m - 1) : m;

function lower_chain(points, leng, chain, m, i) =
    i == leng ? chain : 
        let(
            current_m = _lower_m(chain, points[i], m)
        )
        lower_chain(
            points,
            leng,
            concat(slice(chain, 0, current_m), [points[i]]),
            current_m + 1,
            i + 1
        );
            
function _upper_m(chain, p, m, t) =
    (m >= t && _dir(chain[m - 2], chain[m - 1], p) <= 0) ?
        _upper_m(chain, p, m - 1, t) : m;
        
function _upper_chain(points, chain, m, t, i) =
    i < 0 ? chain :
        let(
            current_m = _upper_m(chain, points[i], m, t)
        )
        _upper_chain(
            points,
            concat(slice(chain, 0, current_m), [points[i]]),
            current_m + 1,
            t,
            i - 1
        );

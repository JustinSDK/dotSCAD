function _midpt_smooth_sub(points, iend, closed) = 
    [
        each [
            for(i = 0; i < iend; i = i + 1) 
                (points[i] + points[i + 1]) / 2
        ],
        if(closed) (points[iend] + points[0]) / 2
    ];

function _midpt_smooth_impl(points, n, closed) =
    let(smoothed = _midpt_smooth_sub(points, len(points) - 1, closed))
    n == 1 ? smoothed : _midpt_smooth_impl(smoothed, n - 1, closed);
use <../../matrix/m_replace.scad>
use <../../util/every.scad>
use <../../util/find_index.scad>

function sampling(size, r, start, k, sd) =
    let(
        w = r / sqrt(2),
        rows = floor(size.y / w),
        columns = floor(size.x / w),
        pts = is_undef(start) ? [[rands(0, size.x, 1, sd)[0], rands(0, size.y, 1, sd + 1)[0]]] : 
              is_num(start[0]) ? [start] : start,
        active = pts,
        pij = [for(pt = pts) [floor(pt.x / w), floor(pt.y / w), pt]],
        grid = [
            for(j = [0:rows - 1]) 
            [
                for(i = [0:columns - 1])
                let(found = find_index(pij, function(ij) ij[0] == i && ij[1] == j))
                if(found != -1)
                    pij[found][2]
                else 
                    undef
            ]
        ]
    )
    [r, k, w, active, grid, rows, columns, []];
    
function sampling_r(s) = s[0];
function sampling_k(s) = s[1];
function sampling_w(s) = s[2];
function sampling_active(s) = s[3];
function sampling_grid(s) = s[4];
function sampling_rows(s) = s[5];
function sampling_columns(s) = s[6];
function sampling_history(s) = s[7];

function sampling_inRow(s, y) = y > -1 && y < sampling_rows(s);

function sampling_inGrid(s, x, y) = 
    sampling_inRow(s, y) && x > -1 && x < sampling_columns(s);

NBRS = [
    [-1, -1], [0, -1], [1, -1],
    [-1,  0], [0,  0], [1,  0],
    [-1,  1], [0,  1], [1,  1]
];

function sampling_noAdjacentNeighbor(s, sample, x, y) = 
    let(me = [x, y])
    every(
        NBRS,
        function(NBR)
            let(nbr = me + NBR)
            !sampling_inRow(s, nbr.y) ||
                          (let(p = sampling_grid(s)[nbr.y][nbr.x])
                          is_undef(p) ||
                          norm(sample - p) >= sampling_r(s))
    );
    
function sampling_randomSample(s, pos, seed) = 
    let(
        r = sampling_r(s),
        a = rands(0, 360, 1, seed)[0]
    )
    rands(r, 2 * r, 1, seed + 1)[0] * [cos(a), sin(a)] + pos;
    
function sampling_hasActive(s) = len(sampling_active(s)) > 0;

function sampling_kSamples(s, pos, seed) = [
    for(n = [0:sampling_k(s) - 1])
    let(
        sample = sampling_randomSample(s, pos, seed + n),
        w = sampling_w(s),
        x = floor(sample.x / w),
        y = floor(sample.y / w)
    )
    if(sampling_inGrid(s, x, y) && sampling_noAdjacentNeighbor(s, sample, x, y))
    sample
];

function sampling_minDistSample(s, pos, samples) =
    len(samples) == 1 ? samples[0] :
    _sampling_minDistSample(s, pos, samples, samples[0], norm(pos - samples[0]));

function _sampling_minDistSample(s, pos, samples, min_s, min_dist, i = 1) = 
    i == len(samples) ? min_s : 
    let(
        sample = samples[i],
        d = norm(pos - sample),
        params = min_dist > d ? [sample, d] : [min_s, min_dist]
    )
    _sampling_minDistSample(s, pos, samples, params[0], params[1], i + 1);     

function sampling_trySampleFromOneActive(s, seed) =
    let(
        active = sampling_active(s),
        i = floor(rands(0, len(active) - 1, 1, seed)[0]),
        pos = active[i],
        samples = sampling_kSamples(s, pos, seed)
    )
    len(samples) == 0 ? 
        [
            sampling_r(s), 
            sampling_k(s), 
            sampling_w(s), 
            [for(j = [0:len(active) - 1]) if(j != i) active[j]], 
            sampling_grid(s), 
            sampling_rows(s), 
            sampling_columns(s),
            sampling_history(s)
        ]
        :
        let(
            sample = sampling_minDistSample(s, pos, samples),
            nx_active = [each active, sample],
            w = sampling_w(s),
            x = floor(sample.x / w),
            y = floor(sample.y / w),
            nx_grid = m_replace(sampling_grid(s), y, x, sample)
        )
        [
            sampling_r(s), 
            sampling_k(s), 
            w, 
            nx_active, 
            nx_grid, 
            sampling_rows(s), 
            sampling_columns(s),
            [each sampling_history(s), [pos, sample]]
        ];

function _pp_poisson(s, seed, count = 0) =
    !sampling_hasActive(s) ? s : _pp_poisson(sampling_trySampleFromOneActive(s, seed + count), seed, count + 1);
    
use <_impl/_pp_poisson2.scad>

function pp_poisson2(size, r, start = undef, k = 30, seed = undef, history = false) =
    let(
        s = _pp_poisson(sampling(size, r, start, k), is_undef(seed) ? floor(rands(0, 1000, 1)[0]) : seed),
        samples = [
            for(row = sampling_grid(s), sample = row)
            if(!is_undef(sample)) sample
        ]
    )
    history ? [samples, sampling_history(s)] : samples;

/*
use <pp/pp_poisson2.scad>
use <polyline_join.scad>


pts_history = pp_poisson2([100, 100], 5, seed = 1, history = true);
for(p = pts_history[0]) {
    translate(p)
        circle(1);
}

for(h = pts_history[1]) {
    polyline_join(h)
        circle(.5);
}
*/
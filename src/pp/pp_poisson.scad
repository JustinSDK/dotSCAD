use <_impl/_pp_poisson.scad>

function pp_poisson(size, r, start, k = 30, history = false) =
    let(
        s = _pp_poisson(sampling(size, r, start, k)),
        samples = [
            for(row = sampling_grid(s), sample = row)
            if(!is_undef(sample)) sample
        ]
    )
    history ? [samples, sampling_history(s)] : samples;

/*
use <pp/pp_poisson.scad>
use <polyline_join.scad>


pts_history = pp_poisson([100, 100], 5, history = true);
for(p = pts_history[0]) {
    translate(p)
        circle(1);
}

for(h = pts_history[1]) {
    polyline_join(h)
        circle(.5);
}
*/
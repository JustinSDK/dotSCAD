use <_impl/_pp_poisson3.scad>

function pp_poisson3(size, r, start = undef, k = 30, seed = undef, history = false) =
    let(
        sd = is_undef(seed) ? floor(rands(0, 1000, 1)[0]) : seed,
        s = _pp_poisson(sampling(size, r, start, k, sd), sd),
        samples = [
            for(layer = sampling_grid(s), row = layer, sample = row)
            if(!is_undef(sample)) sample
        ]
    )
    history ? [samples, sampling_history(s)] : samples;

/*
use <pp/pp_poisson.scad>
use <polyline_join.scad>

pts_history = pp_poisson3([50, 50, 50], 10, seed = 2, history = true);

for(p = pts_history[0]) {
    translate(p)
        sphere(2);
}

for(h = pts_history[1]) {
    polyline_join(h)
        sphere(1);
}
*/
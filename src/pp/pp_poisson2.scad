/**
* pp_poisson2.scad
*
* @copyright Justin Lin, 2022
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-pp_poisson2.html
*
**/ 

use <_impl/_pp_poisson2.scad>

function pp_poisson2(size, r, start = undef, k = 30, seed = undef, history = false) =
    let(
        sd = is_undef(seed) ? floor(rands(0, 1000, 1)[0]) : seed,
        s = _pp_poisson(sampling(size, r, start, k, sd), sd),
        samples = [
            for(row = sampling_grid(s), sample = row)
            if(!is_undef(sample)) sample
        ]
    )
    history ? [samples, sampling_history(s)] : samples;
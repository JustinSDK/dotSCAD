/**
* pp_poisson3.scad
*
* @copyright Justin Lin, 2022
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-pp_poisson3.html
*
**/ 

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
use <_impl/_tiles_wfc_impl.scad>
use <../util/rand.scad>

// An implementation of [Wave Function Collapse](https://github.com/mxgmn/WaveFunctionCollapse)
// method: how to choose wave element. length or entropy?
function tile_wfc(size, sample, method = "length") =
    let(
        w = size.x,
        h = size.y,
        rangey = [0:h - 1],
        rangex = [0:w - 1],
        nbr_dirs = [
            for(y = rangey)
            [for(x = rangex) neighbor_dirs(x, y, w, h)]
        ],
        // random start
        x = floor(rand(w * 0.25, w * 0.75)),
        y = floor(rand(h * 0.25, h * 0.75)),
		compatibilities = compatibilities_of_tiles(sample),
        wf = wave_function(w, h, weights_of_tiles(sample)),
        all_weights = wf_weights(wf),
		weights = [for(state = wf_eigenstates_at(wf, x, y)) get_state_weight(all_weights, state)],
        first_collasped_propagated = propagate(
			nbr_dirs,
			compatibilities,
			wf_collapse(wf, x, y, weights), 
            [x, y]
        ),
        fstp_states = wf_eigenstates(wf),
        notCollapsedCoords =     [
            for(y = rangey)
            let(y_states = fstp_states[y])
                for(x = rangex) 
                if(len(y_states[x]) != 1) [x, y]
        ]
    )
    generate(nbr_dirs, compatibilities, first_collasped_propagated, notCollapsedCoords, collapsing(method));

/*

sample = [
    ["S",  "S",  "S",  "S",  "S",  "S",  "S",  "S",  "S",  "S",  "S",  "S",  "S"],
    ["S",  "S", "C0", "CN", "CN", "CN", "CN", "CN", "CN", "CN", "C3",  "S",  "S"],
    ["S",  "S", "CW",  "L",  "L",  "L",  "L",  "L",  "L",  "L", "CE",  "S",  "S"],
    ["S",  "S", "CW",  "L",  "L",  "L",  "L",  "L",  "L",  "L", "CE",  "S",  "S"],
    ["S",  "S", "CW",  "L",  "L",  "L",  "L",  "L",  "L",  "L", "CE",  "S",  "S"],
    ["S",  "S", "CW",  "L",  "L",  "L",  "L",  "L",  "L",  "L", "CE",  "S",  "S"],
    ["S",  "S", "CW",  "L",  "L",  "L",  "L",  "L",  "L",  "L", "CE",  "S",  "S"],
    ["S",  "S", "CW",  "L",  "L",  "L",  "L",  "L",  "L",  "L", "CE",  "S",  "S"],
    ["S",  "S", "CW",  "L",  "L",  "L",  "L",  "L",  "L",  "L", "CE",  "S",  "S"],    
    ["S",  "S", "C1", "CS", "CS", "CS", "CS", "CS", "CS", "CS", "C2",  "S",  "S"],
    ["S",  "S",  "S",  "S",  "S",  "S",  "S",  "S",  "S",  "S",  "S",  "S",  "S"]
];

size = [20, 20];

echo(tile_wfc(size, sample));
*/



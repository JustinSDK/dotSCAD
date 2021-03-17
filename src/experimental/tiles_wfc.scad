use <util/flat.scad>;
use <util/has.scad>;
use <util/sum.scad>;
use <util/rand.scad>;
use <util/slice.scad>;
use <util/some.scad>;
use <util/every.scad>;
use <util/map/hashmap.scad>;
use <util/map/hashmap_put.scad>;
use <util/map/hashmap_get.scad>;
use <util/map/hashmap_keys.scad>;
use <util/map/hashmap_values.scad>;
use <util/map/hashmap_entries.scad>;
use <util/set/hashset.scad>;
use <util/set/hashset_has.scad>;

function weights_of_tiles(sample) = 
    let(
	    symbols = flat(sample),
		leng = len(symbols),
		weights = hashmap(number_of_buckets = sqrt(leng))
	)
    _weights_of_tiles(weights, symbols, leng);

function _weights_of_tiles(weights, symbols, leng, i = 0) =
    i == leng ? weights :
	    let(
		    tile = symbols[i],
			w = hashmap_get(weights, tile)
	    )
        w == undef ? 
		    _weights_of_tiles(hashmap_put(weights, tile, 1), symbols, leng, i + 1) :
			_weights_of_tiles(hashmap_put(weights, tile, w + 1), symbols, leng, i + 1);

/* 
    oo-style

    wave_function(width, height, weights)
	    - wf_width(wf)
        - wf_height(wf)
        - wf_weights(wf)
		- wf_eigenstates(wf)
		- wf_eigenstates_at(wf, x, y)
		- wf_is_all_collapsed(wf)
		- wf_remove(wf, x, y, removedStates)
		- wf_collapse(wf, x, y)
		- wf_entropy(wf, x, y)
		- wf_coord_min_entropy(wf)
		- wf_not_collapsed_coords(wf)
*/
function wave_function(width, height, weights) = 
    [width, height, weights, _initialEigenstates(width, height, weights)];	

function _initialEigenstates(width, height, weights) =
	let(
	    keys = hashmap_keys(weights),
        row = [for(x = [0:width - 1]) keys]
	)	
	[for(y = [0:height - 1]) row];

function wf_width(wf) = wf[0];
function wf_height(wf) = wf[1];
function wf_weights(wf) = wf[2];
function wf_eigenstates(wf) = wf[3];
function wf_eigenstates_at(wf, x, y) = wf_eigenstates(wf)[y][x];

function wf_is_all_collapsed(wf) = every(
    wf_eigenstates(wf), 
	function(row) every(row, function(states) len(states) == 1)
);

function wf_remove(wf, x, y, removedStates) = _replaceStatesAt(wf, x, y, [
	for(state = wf_eigenstates_at(wf, x, y)) 
	    if(!has(removedStates, state)) 
		    state
]);

function wf_collapse(wf, x, y) =
    let(
		weights = wf_weights(wf),
		states_xy = wf_eigenstates_at(wf, x, y),
		weights_xy = hashmap([
		for(state = hashmap_keys(weights))
			if(has(states_xy, state))
				[state, hashmap_get(weights, state)]
	    ]),
		totalWeights = sum(hashmap_values(weights_xy)),
		threshold = rand() * totalWeights,
		states_weights = hashmap_entries(weights_xy)
	)		
	_wf_collapse(wf, x, y, states_weights, len(states_weights), threshold);

function _wf_collapse(wf, x, y, states_weights, leng, threshold, i = 0) =
    i == leng ? wf : 
	let(
		state = states_weights[i][0],
		weight = states_weights[i][1],
		t = threshold - weight
	)
	t < 0 ? _oneStateAt(wf, x, y, state) :  _wf_collapse(wf, x, y, states_weights, leng, t, i + 1);

function _oneStateAt(wf, x, y, state) = _replaceStatesAt(wf, x, y, [state]);

// Shannon entropy
function wf_entropy(wf, x, y) = 
    let(
		states = wf_eigenstates_at(wf, x, y),
		weights = wf_weights(wf),
		state_leng = len(states),
		sumOfWeights_sumOfWeightLogWeights = _wf_entropy(weights, states, state_leng, 0, 0),
		sumOfWeights = sumOfWeights_sumOfWeightLogWeights[0],
		sumOfWeightLogWeights = sumOfWeights_sumOfWeightLogWeights[1]
	)
	ln(sumOfWeights) - (sumOfWeightLogWeights / sumOfWeights);

function _wf_entropy(weights, states, state_leng, sumOfWeights, sumOfWeightLogWeights, i = 0) =
i == state_leng ? [sumOfWeights, sumOfWeightLogWeights] :
let(
	opt = states[i],
	weight = hashmap_get(weights, opt)
)
_wf_entropy(weights, states, state_leng, sumOfWeights + weight, sumOfWeightLogWeights + weight * ln(weight), i + 1);

function _replaceStatesAt(wf, x, y, states) = 
    let(
	    eigenstates = wf_eigenstates(wf),
		rowsBeforeY = slice(eigenstates, 0, y),
		rowY = eigenstates[y],
		rowsAfterY = slice(eigenstates, y + 1),	
		statesBeforeX = slice(rowY, 0, x),
		statesAfterX = slice(rowY, x + 1),	
		newRowY = concat(
		    statesBeforeX,
		    [states],
			statesAfterX
		)		
	)
	[
	    wf_width(wf),
		wf_height(wf),
		wf_weights(wf),
		concat(
		    rowsBeforeY,
			[newRowY],
			rowsAfterY
		)
	];

function wf_not_collapsed_coords(wf) = [
	for(y = [0:wf_height(wf) - 1])
		for(x = [0:wf_width(wf) - 1])
			if(len(wf_eigenstates_at(wf, x, y)) != 1)
				[x, y]
];

function wf_coord_min_entropy(wf) = 
    let(
		coords = wf_not_collapsed_coords(wf),
		coords_leng = len(coords),
		entropyCoord = coords[0],
		entropy = wf_entropy(wf, entropyCoord[0], entropyCoord[1]) - (rand() / 1000)
	)
	_wf_coord_min_entropy(wf, coords, coords_leng, entropy, entropyCoord);

function _wf_coord_min_entropy(wf, coords, coords_leng, entropy, entropyCoord, i = 1) = 
    i == coords_leng ? entropyCoord :
	let(
		coord = coords[i],
		noisedEntropy = wf_entropy(wf, coord[0], coord[1]) - (rand() / 1000)
	)
	noisedEntropy < entropy ? _wf_coord_min_entropy(wf, coords, coords_leng, noisedEntropy, coord, i + 1) :
	                          _wf_coord_min_entropy(wf, coords, coords_leng, entropy, entropyCoord, i + 1);


/*
	- tilemap(width, height, sample)
		- tilemap_width(tm)
		- tilemap_height(tm)
		- tilemap_compatibilities(tm)
		- tilemap_wf(tm)
		- tilemap_check_compatibilities(tm, tile1, tile2, direction)
		- tilemap_propagate(tm, x, y)
		- tilemap_generate(tm)
*/

function tilemap(width, height, sample) = [
	width, 
	height, 
	compatibilities_of_tiles(sample), 
	wave_function(width, height, weights_of_tiles(sample))
];

function tilemap_width(tm) = tm[0];
function tilemap_height(tm) = tm[1];
function tilemap_compatibilities(tm) = tm[2];
function tilemap_wf(tm) = tm[3];

function tilemap_check_compatibilities(tm, tile1, tile2, direction) = 
    let(compatibilities = tilemap_compatibilities(tm))
	hashset_has(compatibilities, [tile1, tile2, direction]);

function tilemap_propagate(tm, x, y) = 
    let(stack = [[x, y]]) 
	_tilemap_propagate(tm, stack);

function _tilemap_propagate(tm, stack) =
    len(stack) == 0 ? tm :
	let(
		v_stack = pop(stack),
		current_coord = v_stack[0],
		cs = v_stack[1],
		cx = current_coord[0], 
		cy = current_coord[1],
		current_tiles = wf_eigenstates_at(tilemap_wf(tm), cx, cy),
		dirs = neighbor_dirs(cx, cy, tilemap_width(tm), tilemap_height(tm)),
		tm_stack = _doDirs(tm, cs, cx, cy, current_tiles, dirs, len(dirs))
	)
    _tilemap_propagate(tm_stack[0], tm_stack[1]);

function _doDirs(tm, stack, cx, cy, current_tiles, dirs, leng, i = 0) = 
    i == leng ? [tm, stack] :
	let(
		dir = dirs[i],
		nbrx = cx + dir[0],
		nbry = cy + dir[1],
		wf = tilemap_wf(tm),
		nbr_tiles = wf_eigenstates_at(wf, nbrx, nbry),
		not_compatible_nbr_tiles = [
			for(nbr_tile = nbr_tiles) 
			    if(not_compatible_nbr_tile(tm, current_tiles, nbr_tile, dir)) 
				    nbr_tile
		]
	)
	len(not_compatible_nbr_tiles) == 0 ? _doDirs(tm, stack, cx, cy, current_tiles, dirs, leng, i + 1) :
		let(
			nstack = push(stack, [nbrx, nbry]),
			ntm = [
			    tilemap_width(tm), 
				tilemap_height(tm), 
				tilemap_compatibilities(tm),
				wf_remove(wf, nbrx, nbry, not_compatible_nbr_tiles)
			]
		)
	    _doDirs(ntm, nstack, cx, cy, current_tiles, dirs, leng, i + 1);

function tilemap_generate(tm) =
    let(wf = tilemap_wf(tm))
	wf_is_all_collapsed(wf) ? collapsed_tiles(wf) :
	let(
		coord = wf_coord_min_entropy(wf),
		x = coord[0],
		y = coord[1]
	)
	tilemap_generate(tilemap_propagate([
			tilemap_width(tm),
			tilemap_height(tm),
			tilemap_compatibilities(tm),
			wf_collapse(wf, x, y)
		], x, y));


function neighbor_dirs(x, y, width, height) =
    concat(
		x > 0          ? [[-1,  0]] : [],  // left
		x < width - 1  ? [[ 1,  0]] : [],  // right 
		y > 0          ? [[ 0, -1]] : [],  // top
		y < height - 1 ? [[ 0,  1]] : []   // bottom
	);

function neighbor_compatibilities(sample, x, y, width, height) = 
    let(me = sample[y][x])
	[for(dir = neighbor_dirs(x, y, width, height)) [me, sample[y + dir[1]][x + dir[0]], dir]];

function compatibilities_of_tiles(sample) =
    let(
		width = len(sample[0]), 
		height = len(sample)
	)
	hashset([
		for(y = [0:height - 1])
			for(x = [0:width - 1])
				for(c = neighbor_compatibilities(sample, x, y, width, height))
					c
	]);

function collapsed_tiles(wf) =
    let(
		wf_h = wf_height(wf),
		wf_w = wf_width(wf)
	)
	[
		for(y = [0:wf_h - 1])
		[
			for(x = [0:wf_w - 1])
			    wf_eigenstates_at(wf, x, y)[0]
		]
	];

function not_compatible_nbr_tile(tm, current_tiles, nbr_tile, dir) =
    !some(current_tiles, function(tile) tilemap_check_compatibilities(tm, tile, nbr_tile, dir));

function push(stack, elem) = concat([elem], stack);
function pop(stack) = [stack[0], slice(stack, 1)];

function tiles_wfc(width, height, sample) =
    tilemap_generate(tilemap(width, height, sample));

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

width = 20;
height = 20;

echo(tiles_wfc(width, height, sample));
*/

/*
wf = wave_function(width, height, weights);
assert(wf_width(wf) == width);
assert(wf_height(wf) == height);
assert(wf_is_all_collapsed(wf) == false);
assert(wf_remove(wf, 0, 0, []) == wf);
assert(wf_eigenstates_at(wf_remove(wf, 0, 0, ["CE"]), 0, 0) == ["C0", "C1", "CS", "C2", "C3", "S", "CW", "CN", "L"]);
for(y = [0:height - 1]) {
	for(x = [0:width - 1]) {
		assert(len(wf_eigenstates_at(wf_collapse(wf, x, y), x, y)) == 1);
	}
}
assert(wf_entropy(wf, 0, 0) == 1.458879520793018);
assert(wf_coord_min_entropy(wf_collapse(wf, 0, 0)) != [0, 0]);
*/


/*
tm = tilemap(width, height, sample);
assert(tilemap_check_compatibilities(tm, "S", "C0", [ 1,  0]));
assert(!tilemap_check_compatibilities(tm, "S", "L", [ 1,  0]));
ntm = tilemap_propagate([
	tilemap_width(tm),
	tilemap_height(tm),
	tilemap_compatibilities(tm),
	wf_collapse(wf, 0, 0)
], 0, 0);

assert(wf_eigenstates_at(tilemap_wf(ntm), 0, 1) != wf_eigenstates_at(wf, 0, 1));
*/

use <util/flat.scad>;
use <util/has.scad>;
use <util/sum.scad>;
use <util/rand.scad>;
use <util/slice.scad>;
use <util/every.scad>;
use <util/map/hashmap.scad>;
use <util/map/hashmap_len.scad>;
use <util/map/hashmap_put.scad>;
use <util/map/hashmap_get.scad>;
use <util/map/hashmap_del.scad>;
use <util/map/hashmap_keys.scad>;
use <util/map/hashmap_values.scad>;
use <util/map/hashmap_entries.scad>;

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

function weightsOfTiles(sample) = 
    let(
	    symbols = flat(sample),
		leng = len(symbols),
		weights = hashmap(number_of_buckets = sqrt(leng))
	)
    _weightsOfTiles(weights, symbols, leng);

function _weightsOfTiles(weights, symbols, leng, i = 0) =
    i == leng ? weights :
	    let(
		    tile = symbols[i],
			w = hashmap_get(weights, tile)
	    )
        w == undef ? 
		    _weightsOfTiles(hashmap_put(weights, tile, 1), symbols, leng, i + 1) :
			_weightsOfTiles(hashmap_put(weights, tile, w + 1), symbols, leng, i + 1);
			
function initialEigenstates(width, height, weights) =
	let(
	    keys = hashmap_keys(weights),
        row = [for(x = [0:width - 1]) keys]
	)	
	[for(y = [0:height - 1]) row];

// wave function
function waveFunction(width, height, weights) = 
    [width, height, weights, initialEigenstates(width, height, weights)];	

function wf_width(wf) = wf[0];
function wf_height(wf) = wf[1];
function wf_weights(wf) = wf[2];
function wf_eigenstates(wf) = wf[3];
function wf_eigenstates_at(wf, x, y) = wf_eigenstates(wf)[y][x];

function wf_isAllCollapsed(wf) = every(
    wf_eigenstates(wf), 
	function(row) every(row, function(states) len(states) == 1)
);

function wf_remove(wf, x, y, removedStates) =
    let(
	    eigenstates = wf_eigenstates(wf),
		rowsBeforeY = slice(eigenstates, 0, y),
		rowY = eigenstates[y],
		rowsAfterY = slice(eigenstates, y + 1),
		statesBeforeX = slice(rowY, 0, x),
		states = rowY[x],
		statesAfterX = slice(rowY, x + 1),
		newRowY = concat(
		    statesBeforeX,
		    [[for(state = states) if(!has(removedStates, state)) state]],
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

function _oneStateAt(wf, x, y, state) = 
    let(
	    eigenstates = wf_eigenstates(wf),
		rowsBeforeY = slice(eigenstates, 0, y),
		rowY = eigenstates[y],
		rowsAfterY = slice(eigenstates, y + 1),	
		statesBeforeX = slice(rowY, 0, x),
		states = [state],
		statesAfterX = slice(rowY, x + 1),	
		newRowY = concat(
		    statesBeforeX,
		    [[state]],
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

width = len(sample[0]);
height = len(sample);
weights = weightsOfTiles(sample);

wf = waveFunction(width, height, weights);

assert(wf_width(wf) == width);
assert(wf_height(wf) == height);
assert(wf_eigenstates(wf) == initialEigenstates(width, height, weights));
assert(wf_isAllCollapsed(wf) == false);
assert(wf_remove(wf, 0, 0, []) == wf);
assert(wf_eigenstates_at(wf_remove(wf, 0, 0, ["CE"]), 0, 0) == ["C0", "C1", "CS", "C2", "C3", "S", "CW", "CN", "L"]);
for(y = [0:height - 1]) {
	for(x = [0:width - 1]) {
		assert(len(wf_eigenstates_at(wf_collapse(wf, x, y), x, y)) == 1);
	}
}


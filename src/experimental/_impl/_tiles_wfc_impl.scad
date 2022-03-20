use <util/rand.scad>;
use <util/some.scad>;
use <util/every.scad>;
use <util/sum.scad>;
use <util/map/hashmap.scad>;
use <util/map/hashmap_put.scad>;
use <util/map/hashmap_get.scad>;
use <util/map/hashmap_keys.scad>;
use <util/set/hashset.scad>;
use <util/set/hashset_has.scad>;

function weights_of_tiles(sample) = 
    let(
	    symbols = [for(row = sample) each row],
		leng = len(symbols)
	)
    _weights_of_tiles(hashmap(number_of_buckets = leng), symbols, leng);

function _weights_of_tiles(weights, symbols, leng, i = 0) =
    i == leng ? weights :
	    let(
		    tile = symbols[i],
			w = hashmap_get(weights, tile)
	    )
		_weights_of_tiles(hashmap_put(weights, tile, w == undef ? 1 : w + 1), symbols, leng, i + 1);

/* 
    oo-style

    wave_function(width, height, weights)
	    - wf_width(wf)
        - wf_height(wf)
        - wf_weights(wf)
		- wf_eigenstates(wf)
		- wf_eigenstates_at(wf, x, y)
		- wf_is_all_collapsed(wf, notCollaspedCoords)
		- wf_collapse(wf, x, y)
		- wf_entropy(wf, x, y)
		- wf_coord_min_entropy(wf, notCollaspedCoords)
		- wf_not_collapsed_coords(wf, notCollaspedCoords)
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

function wf_is_all_collapsed(wf, notCollaspedCoords) = 
    is_undef(notCollaspedCoords) ?
	every(
		wf_eigenstates(wf), 
		function(row) every(row, function(states) len(states) == 1)
	) :
	every(notCollaspedCoords, function(coord) len(wf_eigenstates_at(wf, coord.x, coord.y)) == 1);

function wf_collapse(wf, x, y) =
    let(
		weights = wf_weights(wf),
		states_xy = wf_eigenstates_at(wf, x, y),
		weights_xy = [
			for(state = states_xy)
			let(w = hashmap_get(weights, state))
			if(w != undef)
			[state, w]
		],
		leng = len(weights_xy),
		threshold = rand() * sum([for(i = 0; i < leng; i = i + 1) weights_xy[i][1]])
	)		
	_wf_collapse(wf, x, y, weights_xy, len(weights_xy), threshold);

function _wf_collapse(wf, x, y, states_weights, leng, threshold, i = 0) =
    threshold < 0 || i == leng ? wf : 
	let(state_weight = states_weights[i])
	_wf_collapse(
		threshold < state_weight[1] ? _replaceStatesAt(wf, x, y, [state_weight[0]]) : wf, 
		x, y, states_weights, leng, threshold - state_weight[1], i + 1
	);

// Shannon entropy
function wf_entropy(wf, x, y) = 
    let(
		weights = wf_weights(wf),
		states_weights = [for(state = wf_eigenstates_at(wf, x, y)) hashmap_get(weights, state)],
		sumOfWeights = sum(states_weights),
		sumOfWeightLogWeights = sum([for(w = states_weights) w * ln(w)]) 
	)
	ln(sumOfWeights) - (sumOfWeightLogWeights / sumOfWeights);

function _replaceStatesAt(wf, x, y, states) = 
    let(
	    eigenstates = wf_eigenstates(wf),
		rowY = eigenstates[y],
		leng_rowY = len(rowY),	
		leng_eigenstates = len(eigenstates),
		newRowY = [for(i = 0; i < leng_rowY; i = i + 1) i == x ? states : rowY[i]]	
	)
	[
	    wf_width(wf),
		wf_height(wf),
		wf_weights(wf),
		[for(i = 0; i < leng_eigenstates; i = i + 1) i == y ? newRowY : eigenstates[i]]
	];

function wf_not_collapsed_coords(wf, notCollaspedCoords) = 
    is_undef(notCollaspedCoords) ?
	let(rx = [0:wf_width(wf) - 1])
	[
		for(y = [0:wf_height(wf) - 1], x = rx)
		if(len(wf_eigenstates_at(wf, x, y)) != 1) [x, y]
	] :
	[
		for(coord = notCollaspedCoords)
		if(len(wf_eigenstates_at(wf, coord.x, coord.y)) != 1) [coord.x, coord.y]
	];

function wf_coord_min_entropy(wf, notCollaspedCoords) = 
    let(
		coords = wf_not_collapsed_coords(wf, notCollaspedCoords),
		entropyCoord = coords[0],
		entropy = wf_entropy(wf, entropyCoord.x, entropyCoord.y) - (rand() / 1000),
		min_coord = _wf_coord_min_entropy(wf, coords, len(coords), entropy, entropyCoord)
	)
	[min_coord, coords];

function _wf_coord_min_entropy(wf, coords, coords_leng, entropy, entropyCoord, i = 1) = 
    i == coords_leng ? entropyCoord :
	let(
		coord = coords[i],
		noisedEntropy = wf_entropy(wf, coord.x, coord.y) - (rand() / 1000),
		nee = noisedEntropy < entropy ? [noisedEntropy, coord] : [entropy, entropyCoord]
	)
	_wf_coord_min_entropy(wf, coords, coords_leng, nee[0], nee[1], i + 1);


/*
	- tilemap(width, height, sample)
		- tilemap_width(tm)
		- tilemap_height(tm)
		- tilemap_compatibilities(tm)
		- tilemap_wf(tm)
		- tilemap_check_compatibilities(tm, tile1, tile2, direction)
		- tilemap_propagate(tm, x, y)
		- tilemap_generate(tm, notCollaspedCoords)
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
	hashset_has(tilemap_compatibilities(tm), [tile1, tile2, direction]);

function tilemap_propagate(tm, x, y) = 
	_tilemap_propagate(tm, create_stack([x, y]));

function _tilemap_propagate(tm, stack) =
    stack == [] ? tm :
	let(
		current_coord = stack[0],
		cs = stack[1],
		cx = current_coord.x, 
		cy = current_coord.y,
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
		compatible_nbr_tiles = [
			for(nbr_tile = nbr_tiles) 
			if(compatible_nbr_tile(tm, current_tiles, nbr_tile, dir)) nbr_tile
		],
		leng_compatible_nbr_tiles = len(compatible_nbr_tiles),

		tm_stack =
			assert(leng_compatible_nbr_tiles > 0,
					str("(", nbrx, ", ", nbry, ")", 
					" reaches a contradiction. Tiles have all been ruled out by your previous choices. Please try again."))

			leng_compatible_nbr_tiles == len(nbr_tiles) ? 
				[tm, stack] 
				: 
				[   
					[
						tilemap_width(tm), 
						tilemap_height(tm), 
						tilemap_compatibilities(tm),
						_replaceStatesAt(wf, nbrx, nbry, compatible_nbr_tiles)
					], 
					stack_push(stack, [nbrx, nbry])
				]
	)
	_doDirs(tm_stack[0], tm_stack[1], cx, cy, current_tiles, dirs, leng, i + 1);

function tilemap_generate(tm, notCollaspedCoords) =
    let(wf = tilemap_wf(tm))
	wf_is_all_collapsed(wf, notCollaspedCoords) ? collapsed_tiles(wf) :
	let(
		coord_notCollaspedCoords = wf_coord_min_entropy(wf, notCollaspedCoords),
		x = coord_notCollaspedCoords[0].x,
		y = coord_notCollaspedCoords[0].y
	)
	tilemap_generate(tilemap_propagate([
			tilemap_width(tm),
			tilemap_height(tm),
			tilemap_compatibilities(tm),
			wf_collapse(wf, x, y)
		], x, y), coord_notCollaspedCoords[1]);


function neighbor_dirs(x, y, width, height) = [
	if(x > 0)          [-1,  0],   // left
	if(x < width - 1)  [ 1,  0],   // right 
	if(y > 0)          [ 0, -1],   // top
	if(y < height - 1) [ 0,  1]    // bottom
];

function neighbor_compatibilities(sample, x, y, width, height) = 
    let(me = sample[y][x])
	[for(dir = neighbor_dirs(x, y, width, height)) [me, sample[y + dir[1]][x + dir[0]], dir]];

function compatibilities_of_tiles(sample) =
    let(
		width = len(sample[0]), 
		height = len(sample),
		rx = [0:width - 1]
	)
	hashset([
		for(y = [0:height - 1], x = rx)
		each neighbor_compatibilities(sample, x, y, width, height)
	], number_of_buckets = width * height);

function collapsed_tiles(wf) =
    let(
		wf_h = wf_height(wf),
		wf_w = wf_width(wf),
		rx = [0:wf_w - 1]
	)
	[
		for(y = [0:wf_h - 1])
		[for(x = rx) wf_eigenstates_at(wf, x, y)[0]]
	];

function compatible_nbr_tile(tm, current_tiles, nbr_tile, dir) =
    some(current_tiles, function(tile) tilemap_check_compatibilities(tm, tile, nbr_tile, dir));

function create_stack(elem) = [elem, []];
function stack_push(stack, elem) = [elem, stack];
// function stack_pop(stack) = stack;
function stack_len(stack) = 
    is_undef(stack[0]) ? 0 : 1 + stack_len(stack[1]); 
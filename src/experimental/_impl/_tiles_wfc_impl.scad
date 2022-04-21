use <util/rand.scad>;
use <util/some.scad>;
use <util/sum.scad>;
use <util/sorted.scad>;
use <util/contains.scad>;
use <util/set/hashset.scad>;
use <util/set/hashset_elems.scad>;
use <matrix/m_replace.scad>;

function count_from(lt, from, leng_lt) = 
    len([
        for(i = from; i < leng_lt && lt[i] == lt[from]; i = i + 1)
        undef
    ]);
    
function count_items(lt) = 
    let(leng_lt = len(lt))
    [
        for(i = 0, c = count_from(lt, 0, leng_lt); i < leng_lt; i = i + c, c = count_from(lt, i, leng_lt))
        [lt[i], c]
    ];

function weights_of_tiles(sample) = count_items(sorted([for(row = sample) each row]));

/* 
    oo-style

    wave_function(width, height, weights)
	    - wf_width(wf)
        - wf_height(wf)
        - wf_weights(wf)
		- wf_eigenstates(wf)
		- wf_eigenstates_at(wf, x, y)
		- wf_collapse(wf, x, y, weights)
		- wf_entropy_weights(wf, x, y)
		- wf_coord_weights_min_entropy(wf, notCollaspedCoords)
		- wf_not_collapsed_coords(wf, notCollaspedCoords)
*/
function wave_function(width, height, weights) = 
    [width, height, weights, _initialEigenstates(width, height, weights)];	

function _initialEigenstates(width, height, weights) =
	let(
	    keys = [for(weight = weights) weight[0]], 
        row = [for(x = [0:width - 1]) keys]
	)	
	[for(y = [0:height - 1]) row];

function wf_width(wf) = wf[0];
function wf_height(wf) = wf[1];
function wf_weights(wf) = wf[2];
function wf_eigenstates(wf) = wf[3];
function wf_eigenstates_at(wf, x, y) = wf_eigenstates(wf)[y][x];

function get_state_weight(weights, state) = weights[search([state], weights)[0]][1];

function wf_collapse(wf, x, y, weights) =
    let(
		states = wf_eigenstates(wf)[y][x],
		threshold = rand() * sum(weights)
	)		
	_wf_collapse(wf, x, y, states, weights, len(states), threshold);

function _wf_collapse(wf, x, y, states, weights, leng, threshold, i = 0) =
    threshold < 0 || i == leng ? wf :
	let(weight = weights[i]) 
	_wf_collapse(
		threshold < weight ? _replaceStatesAt(wf, x, y, [states[i]]) : wf, 
		x, y, states, weights, leng, threshold - weight, i + 1
	);

// Shannon entropy
function wf_entropy_weights(wf, x, y) = 
    let(
		all_weights = wf_weights(wf),
		weights = [for(state = wf_eigenstates(wf)[y][x]) get_state_weight(all_weights, state)],
		sumOfWeights = sum(weights),
		sumOfWeightLogWeights = sum([for(w = weights) w * ln(w)]) 
	)
	[ln(sumOfWeights) - (sumOfWeightLogWeights / sumOfWeights) - rand() / 1000, weights];

function _replaceStatesAt(wf, x, y, states) = 
	[
	    wf_width(wf),
		wf_height(wf),
		wf_weights(wf),
		m_replace(wf_eigenstates(wf), x, y, states)
	];

function wf_not_collapsed_coords(wf) = 
    let(eigenstates = wf_eigenstates(wf), we = wf_width(wf) - 1, he = wf_height(wf) - 1, rx = [0:we])
    [
		for(y = [0:he], x = rx)
		if(len(eigenstates[y][x]) != 1) [x, y]
	];

function wf_coord_weights_min_entropy(wf, notCollaspedCoords) = 
    let(
		coord_entropy_weights_lt = [
			for(coord = notCollaspedCoords)
			let(x = coord.x, y = coord.y)
			[x, y, wf_entropy_weights(wf, x, y)] 
		],
		min_coord_entropy_weights = _coord_entropy_weights(
			coord_entropy_weights_lt, 
			len(coord_entropy_weights_lt), 
			coord_entropy_weights_lt[0]
		)
	)
    [min_coord_entropy_weights.x, min_coord_entropy_weights.y, min_coord_entropy_weights[2][1]];

function _coord_entropy_weights(coord_entropy_weights_lt, leng, m, i = 1) = 
    i == leng ? m :
	let(cm = coord_entropy_weights_lt[i])
	_coord_entropy_weights(coord_entropy_weights_lt, leng, m[2][0] <= cm[2][0] ? m : cm, i + 1);

function propagate(nbr_dirs, compatibilities, notCollaspedCoords, wf, coord) = 
	_propagate(
		nbr_dirs,
		compatibilities,
		notCollaspedCoords, 
		[wf, create_stack(coord)]
	);

function _propagate(nbr_dirs, compatibilities, notCollaspedCoords, wf_stack) =
    let(wf = wf_stack[0], stack = wf_stack[1])
    stack == [] ? wf :
	let(
		current_coord = stack[0],
		cx = current_coord.x, 
		cy = current_coord.y,
		current_tiles = wf_eigenstates(wf)[cy][cx],
		dirs = nbr_dirs[cy][cx],
		nx_wf_stack = _doDirs(compatibilities, notCollaspedCoords, [wf, stack[1]], current_coord, current_tiles, dirs, len(dirs))
	)
    _propagate(nbr_dirs, compatibilities, notCollaspedCoords, nx_wf_stack);

contradiction_msg = "A contradiction happens. Tiles have all been ruled out by your previous choices. Please try again.";
function _doDirs(compatibilities, notCollaspedCoords, wf_stack, current_coord, current_tiles, dirs, leng, i = 0) = 
    i == leng ? wf_stack :
	let(
		dir = dirs[i],
		nbr = dir + current_coord,
		mx_wf_stack = 
		    contains(notCollaspedCoords, nbr) ?
			(
				let(
					nbr_tiles = wf_eigenstates(wf_stack[0])[nbr.y][nbr.x],
					compatible_nbr_tiles = [
						for(nbr_tile = nbr_tiles) 
						if(compatible_nbr_tile(compatibilities, current_tiles, nbr_tile, dir)) nbr_tile
					],
					leng_compatible_nbr_tiles = len(compatible_nbr_tiles)
				)
				assert(leng_compatible_nbr_tiles > 0, contradiction_msg)
				leng_compatible_nbr_tiles == len(nbr_tiles) ? 
					wf_stack
					: 
					[   
						_replaceStatesAt(wf_stack[0], nbr.x, nbr.y, compatible_nbr_tiles), 
						stack_push(wf_stack[1], nbr)
					]
			)
			: 
			wf_stack
	)
	_doDirs(compatibilities, notCollaspedCoords, mx_wf_stack, current_coord, current_tiles, dirs, leng, i + 1);

function generate(nbr_dirs, compatibilities, wf, notCollaspedCoords) =
	len(notCollaspedCoords) == 0 ? collapsed_tiles(wf) :
	let(
		coord_weights = wf_coord_weights_min_entropy(wf, notCollaspedCoords),
		weights = coord_weights[2],
		nwf = propagate(nbr_dirs, compatibilities, notCollaspedCoords, wf_collapse(wf, coord_weights.x, coord_weights.y, weights), coord_weights)
	)
	generate(nbr_dirs, compatibilities, nwf, wf_not_collapsed_coords(nwf));

function neighbor_dirs(x, y, width, height) = [
	if(x > 0)          [-1,  0],   // left
	if(x < width - 1)  [ 1,  0],   // right 
	if(y > 0)          [ 0, -1],   // top
	if(y < height - 1) [ 0,  1]    // bottom
];

function compatibilities_of_tiles(sample) =
    let(
		width = len(sample[0]), 
		height = len(sample),
		rx = [0:width - 1]
	)
	hashset_elems(hashset([
		for(y = [0:height - 1], x = rx, dir = neighbor_dirs(x, y, width, height))
		[sample[y][x], sample[y + dir.y][x + dir.x], dir] // neighbor_compatibilities
	], number_of_buckets = width * height));

function collapsed_tiles(wf) =
    let(
		wf_h = wf_height(wf),
		wf_w = wf_width(wf),
		rx = [0:wf_w - 1],
		eigenstates = wf_eigenstates(wf)
	)
	[
		for(y = [0:wf_h - 1])
		let(wfy = eigenstates[y])
		[for(x = rx) wfy[x][0]]
	];

function compatible_nbr_tile(compatibilities, current_tiles, nbr_tile, dir) =
    some(current_tiles, function(tile) contains(compatibilities, [tile, nbr_tile, dir]));

function create_stack(elem) = [elem, []];
function stack_push(stack, elem) = [elem, stack];
// function stack_pop(stack) = stack;
function stack_len(stack) = 
    is_undef(stack[0]) ? 0 : 1 + stack_len(stack[1]); 
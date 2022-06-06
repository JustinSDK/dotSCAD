# flat

returns a new list with all sub-list elements concatenated into it recursively up to the specified depth.

**Since:** 2.3

## Parameters

- `lt` : The original list.
- `depth` : Default to 1. The depth level specifying how deep a nested list should be flattened. 

## Examples

	use <util/flat.scad>

	vt = [[[[1, 2], [3, 4]], [[5, 6], [7, 8]]]];

	assert(
		flat([1, 2, [3, 4]]) == [1, 2, 3, 4]
	);

	assert(
		flat([[1, 2], [3, 4]]) == [1, 2, 3, 4]
	);

	assert(
		flat([[[[1, 2], [3, 4]], [[5, 6], [7, 8]]]]) == [[[1, 2], [3, 4]], [[5, 6], [7, 8]]]
	);

	assert(
		flat([[[[1, 2], [3, 4]], [[5, 6], [7, 8]]]], 2) == [[1, 2], [3, 4], [5, 6], [7, 8]]
	);

	assert(
		flat([[[[1, 2], [3, 4]], [[5, 6], [7, 8]]]], 3) == [1, 2, 3, 4, 5, 6, 7, 8]
	);

# bsearch

The `bsearch` function is a general-purpose function to find a value or a list of values in a vector. The vector must be sorted by zyx (from the last index to the first one).

**Since:**  2.3

## Parameters

- `sorted` : The sorted vector.
- `elem` : a list of values.
- `by` : Can be `"x"`、`"y"`、`"z"`, `"idx"` (Default) or `"vt"`. 
- `idx` : When `by` is `"idx"`, the value of `idx` is used. The Default value is 0.

## Examples

	use <util/sort.scad>;
	use <util/bsearch.scad>;

	points = [[1, 1], [3, 4], [7, 2], [5, 2]];
	sorted = sort(points, by = "vt");

	echo(sorted); //  [[1, 1], [5, 2], [7, 2], [3, 4]]
	assert(bsearch(sorted, [5, 4], by = "x") == 1);   
	assert(bsearch(sorted, [5, 4], by = "y") == 3);   
	assert(bsearch(sorted, [7, 2], by = "vt") == 2);
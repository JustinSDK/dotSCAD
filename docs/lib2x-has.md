# has

If `lt` contains `elem`, this function returns `true`. If you want to test elements repeatly, sorting `lt` first and setting `sorted` to `true` will be faster.

**Since:** 2.3

## Parameters

- `lt` : A list of vectors.
- `elem` : A vector.
- `sorted` : If `false` (default), use native `search`. If `true`, `lt` must be sorted by zyx (from the last index to the first one) and `has` will use binary search internally.

## Examples

    use <pixel/px_circle.scad>;
    use <util/sort.scad>;
    use <util/has.scad>;

    pts = px_circle(10);
    assert(has(pts, [2, -10])); 
    assert(!has(pts, [0, 0]));  

    sorted_pts = sort(pts, by = "vt");
    assert(has(sorted_pts, [2, -10]));
    assert(!has(sorted_pts, [0, 0])); 
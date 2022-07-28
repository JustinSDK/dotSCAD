# m_replace

It replaces the aᵢⱼ element of a matrix.

**Since:** 3.3

## Parameters

- `m` : A matrix.
- `i` : The i-th row.
- `j` : The j-th column.
- `value` : The new value.

## Examples

    use <matrix/m_replace.scad>

    original_m = [
        [1, 2, 3, 4],
        [5, 6, 7, 8],
        [9, 10, 11, 12]
    ];

    expected = [
        [1, 2, 3, 4],
        [5, 6, 70, 8],
        [9, 10, 11, 12]
    ];

    actual = m_replace(original_m, 1, 2, 70);

    assert(actual == expected);
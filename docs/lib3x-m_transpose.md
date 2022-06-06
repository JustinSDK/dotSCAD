# m_transpose

It transposes a matrix.

**Since:** 3.1

## Parameters

- `m` : A matrix.

## Examples

    use <matrix/m_transpose.scad>

    original_m = [
        [1, 2, 3, 4],
        [5, 6, 7, 8],
        [9, 10, 11, 12]
    ];

    traget = [
        [1, 5, 9],
        [2, 6, 10],
        [3, 7, 11],
        [4, 8, 12]
    ];

    transposed = m_transpose(original_m);

    assert(transposed == traget);
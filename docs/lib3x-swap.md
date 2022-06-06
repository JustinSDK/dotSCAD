# swap

Swaps two elements in a list.

**Since:** 3.0

## Parameters

- `lt` : The list.
- `i` : The index of one element.
- `j` : The index of the other element

## Examples

    use <util/swap.scad>
    
    assert(swap([10, 20, 30, 40], 1, 3) == [10, 40, 30, 20]);
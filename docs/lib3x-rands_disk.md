# rands_disk

Generate random points over a disk.

**Since:** 3.3

## Parameters

- `radius` : The radius of the disk.
- `value_count` : Number of random numbers to return as a vector.
- `seed_value` : Optional. Seed value for random number generator for repeatable results. 

## Examples

    use <util/rands_disk.scad>

    number = 10000;
    radius = 2;

    points = rands_disk(radius, number);

    for(p = points) {
        translate(p)
            circle(.01);
    }

![rands_disk](images/lib3x-rands_disk-1.JPG)
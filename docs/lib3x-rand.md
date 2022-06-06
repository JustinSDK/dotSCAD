# rand

Random number generator. Generates a pseudo random number.

**Since:** 2.1

## Parameters

- `min_value` : Minimum value of random number range. Default to 0.
- `max_value` : Maximum value of random number range. Default to 1.
- `seed_value` : Optional. Seed value for random number generator for repeatable results. 

## Examples

    use <util/rand.scad>
    
    echo(rand());              
    echo(rand(1, 10));
    echo(rand(seed_value = 4));    

    
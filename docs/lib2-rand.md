# rand

Random number generator. Generates a pseudo random number.

## Parameters

- `min_value` : Minimum value of random number range.
- `max_value` : Maximum value of random number range.
- `seed_value` : Optional. Seed value for random number generator for repeatable results. 

## Examples

    include <util/rand.scad>;
    
    echo(rand());              
    echo(rand(1, 10));
    echo(rand(seed_value = 4));    

    
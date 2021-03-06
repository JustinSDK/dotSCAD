use <../sum.scad>;

function hashmap_len(map) = sum([
    for(bucket = map) 
        len(bucket)		
]);
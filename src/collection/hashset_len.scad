use <../util/sum.scad>;

function hashset_len(set) = sum([
    for(bucket = set) 
        len(bucket)		
]);
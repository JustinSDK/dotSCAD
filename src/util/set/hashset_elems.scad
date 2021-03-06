function hashset_elems(set) = [
    for(bucket = set) 
        for(elem = bucket)
            elem		
];
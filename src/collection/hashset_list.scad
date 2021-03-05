function hashset_list(set) = [
    for(bucket = set) 
        for(elem = bucket)
            elem		
];
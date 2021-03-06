function hashmap_list(map) = [
    for(bucket = map) 
        for(kv = bucket)
            kv
];
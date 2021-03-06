function hashmap_keys(map) = [
    for(bucket = map) 
        for(kv = bucket)
            kv[0]
];
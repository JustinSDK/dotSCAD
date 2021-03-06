function hashmap_values(map) = [
    for(bucket = map) 
        for(kv = bucket)
            kv[1]
];
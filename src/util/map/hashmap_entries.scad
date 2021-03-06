function hashmap_entries(map) = [
    for(bucket = map) 
        for(kv = bucket)
            kv
];
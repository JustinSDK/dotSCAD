function rand(min_value = 0, max_value = 1, seed_value) = 
    is_undef(seed_value) ? rands(min_value, max_value , 1)[0] : rands(min_value, max_value , 1, seed_value)[0];
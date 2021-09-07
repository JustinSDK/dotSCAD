function _pt3_hash(number_of_buckets) = 
    function(p) floor(abs(p * [73856093, 19349669, 83492791])) % number_of_buckets;
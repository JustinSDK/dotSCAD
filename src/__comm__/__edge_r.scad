function __edge_r_begin(orig_r, a, a_step, m) =
    let(half_a_step = a_step / 2)
    orig_r * cos(half_a_step) / cos(m * a_step - half_a_step - a);

function __edge_r_end(orig_r, a, a_step, n) =    
    let(half_a_step = a_step / 2)  
    orig_r * cos(half_a_step) / cos(n * a_step + half_a_step  - a);
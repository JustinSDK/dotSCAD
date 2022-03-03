function __edge_r_begin(orig_r, a, a_step, m) =
    (orig_r * cos(a_step / 2)) / cos((m - 0.5) * a_step - a);

function __edge_r_end(orig_r, a, a_step, n) =      
    (orig_r * cos(a_step / 2)) / cos((n + 0.5) * a_step - a);
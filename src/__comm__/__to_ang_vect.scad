function __to_3_elems_ang_vect(a) =
     let(leng = len(a))
     leng == 3 ? a : 
     leng == 2 ? [each a, 0] : [a.x, 0, 0];

function __to_ang_vect(a) = is_num(a) ? [0, 0, a] : __to_3_elems_ang_vect(a);
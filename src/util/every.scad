use <_impl/_every.scad>;

function every(lt, assert_func) = _every(lt, assert_func, len(lt));
function _every(lt, assert_func, leng, i = 0) = 
    i == leng ? true :
        assert_func(lt[i]) ? _every(lt, assert_func, leng, i + 1) : false;

function every(lt, assert_func) = _every(lt, assert_func, len(lt));
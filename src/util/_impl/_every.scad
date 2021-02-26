function _every(lt, test, leng, i = 0) = 
    i == leng ? true :
        !test(lt[i]) ? false : _every(lt, test, leng, i + 1);
function _every(lt, test, leng, i = 0) = 
    i == leng ? true :
        test(lt[i]) ? _every(lt, test, leng, i + 1) : false;
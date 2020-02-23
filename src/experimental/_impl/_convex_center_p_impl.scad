function _sum(lt, leng, i = 0) =
    i == leng ? [0, 0, 0] : lt[i] + _sum(lt, leng, i + 1);

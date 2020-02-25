function _convex_center_p_sum(lt, leng, i = 0) =
    i == leng ? [0, 0, 0] : lt[i] + _convex_center_p_sum(lt, leng, i + 1);

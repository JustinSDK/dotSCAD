function slice(lt, begin, end) = 
    let(ed = is_undef(end) ? len(lt) : end)
    [for(i = begin; i < ed; i = i + 1) lt[i]];
    
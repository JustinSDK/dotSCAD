function flat(lt, depth = 1) =
    depth == 1 ? [for(row = lt) each row] :
                 [for(row = lt) each flat(row, depth - 1)];
_find_eq_search = function(lt, target, eq)
    let(found = search([target], lt)[0])
    found == [] ? -1 : found;

_find_eq_some = function(lt, target, eq)
    let(
        leng = len(lt),
        indices = [for(i = 0; i < leng && !eq(lt[i], target); i = i + 1) undef],
        leng_indices = len(indices)
    )
    leng_indices == leng ? -1 : leng_indices;
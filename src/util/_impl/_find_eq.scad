function _find_eq(lt, target, eq) = 
    is_undef(eq) ? (
            let(found = search([target], lt)[0])
            found == [] ? -1 : found
        ) : (
            let(
                leng = len(lt),
                indices = [for(i = 0; i < leng && !eq(lt[i], target); i = i + 1) undef],
                leng_indices = len(indices)
            )
            leng_indices == leng ? -1 : leng_indices
        ); 
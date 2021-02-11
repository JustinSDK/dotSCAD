_identity = function(elems) elems;

function _zipAll_sub(lts, list_to, elem_to, head, i = 0) = 
    i > elem_to ? [] :
    concat([head([for(j = [0:list_to]) lts[j][i]])], _zipAll_sub(lts, list_to, elem_to, head, i + 1));

function _zipAll(lts, head = _identity) = _zipAll_sub(lts, len(lts) - 1, len(lts[0]) - 1, head);
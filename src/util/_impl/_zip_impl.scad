function _zipAll_sub(lists, list_to, elem_to, i = 0) = 
    i > elem_to ? [] :
    concat([[for(j = [0:list_to]) lists[j][i]]], _zipAll_sub(lists, list_to, elem_to, i + 1));

function _zipAll(lists) = _zipAll_sub(lists, len(lists) - 1, len(lists[0]) - 1);
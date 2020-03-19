function _zip2(lt1, lt2) =
    [for(i = [0:len(lt1) - 1]) [lt1[i], lt2[i]]];

function _zip3(lt1, lt2, lt3) =
    [for(i = [0:len(lt1) - 1]) [lt1[i], lt2[i], lt3[i]]];

function _zipAll_sub(lists, list_to, elem_to, i = 0) = 
    i > elem_to ? [] :
    concat([[for(j = [0:list_to]) lists[j][i]]], _zipAll_sub(lists, list_to, elem_to, i + 1));

function _zipAll(lists) = _zipAll_sub(lists, len(lists) - 1, len(lists[0]) - 1);
function _greaterThan(elem1, elem2, i) =
    i >= 0 && (
        elem1[i] > elem2[i] || (elem1[i] == elem2[i] && _greaterThan(elem1, elem2, i - 1))
    );
    
function greaterThan(elem1, elem2) = _greaterThan(elem1, elem2, len(elem1) - 1);

function lessThan(elem1, elem2) = !greaterThan(elem1, elem2) && elem1 != elem2;
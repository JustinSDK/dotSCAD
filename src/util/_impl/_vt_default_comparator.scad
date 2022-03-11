function greaterThan(elem1, elem2) = 
    let(
        leng = len(elem1),
        lt = [for(i = leng - 1; i > -1 && elem1[i] == elem2[i]; i = i - 1) i],
        leng_lt = len(lt)
    )
    leng_lt < leng && (
        let(i = leng_lt == 0 ? leng - 1 : lt[leng_lt - 1] - 1)
        elem1[i] > elem2[i]
    );

function lessThan(elem1, elem2) = !greaterThan(elem1, elem2) && elem1 != elem2;
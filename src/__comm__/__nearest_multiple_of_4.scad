function __nearest_multiple_of_4(n) =
    let(remain = n % 4)
    (remain / 4) > 0.5 ? n - remain + 4 : n - remain;

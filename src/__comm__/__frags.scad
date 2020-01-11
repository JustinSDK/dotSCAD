function __frags(radius) = 
    $fn == 0 ?  max(min(360 / $fa, radius * PI * 2 / $fs), 5) :
    $fn >= 3 ? $fn : 3;
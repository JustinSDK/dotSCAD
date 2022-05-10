function __frags(radius) = 
    $fn == 0 ?  
        max(min(360 / $fa, radius * 6.283185307179586 / $fs), 5) :
        max($fn, 3);
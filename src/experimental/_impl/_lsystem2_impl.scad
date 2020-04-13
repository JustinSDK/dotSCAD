use <experimental/assoc_lookup.scad>;
use <turtle/turtle2d.scad>;
 
// It doesn't use recursion to avoid recursion error. 
function _join(strs) = 
    let(leng = len(strs))
    [for(i = 0, s = strs[0]; i < leng; i = i + 1, s = str(s, strs[i])) s][leng - 1];

function _derive1(base, rule) = _join([
    for(c = base) 
    let(v = assoc_lookup(rule, c))
    is_undef(v) ? c : v
]);

function _derive(base, rule, n, i = 0) =
    i == n ? base : _derive(_derive1(base, rule), rule, n, i + 1);
    
function derive(rule, n) =
    _derive(assoc_lookup(rule, "S"), rule, n);

function _next_stack(t, code, stack) = 
    code == "[" ? concat([t], stack) :
    let(leng = len(stack))
    code == "]" ? 
            (leng > 1 ? [for(i = [1:leng - 1]) stack[i]] : []) :
            stack;

function _next_t1(t1, t2, code, stack) = 
    code == "[" ? t1 : 
    code == "]" ? stack[0] : t2; 
    
function _next_t2(t, code, angle, leng) = 
    is_undef(code) || code == "[" || code == "]" ? t :
    code == "F" ? turtle2d("forward", t, leng) :
    code == "M" ? turtle2d("forward", t, leng) :
    code == "+" ? turtle2d("turn", t, angle) :
    code == "-" ? turtle2d("turn", t, -angle) : t;    

// It doesn't use recursion to avoid recursion error.    
function _lines(t, codes, angle, leng) = 
    let(codes_leng = len(codes))
    [
        for(
            i = 0,
            stack = [],            
            t1 = t, 
            t2 = _next_t2(t1, codes[i], angle, leng);
            
            i < codes_leng; 
            
            t1 = _next_t1(t1, t2, codes[i], stack), 
            stack = _next_stack(t1, codes[i], stack),
            i = i + 1, 
            t2 = _next_t2(t1, codes[i], angle, leng)
        )
        if(search(codes[i], "F+-") != [])
            [turtle2d("pt", t1), turtle2d("pt", t2)]
    ];
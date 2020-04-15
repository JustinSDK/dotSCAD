use <experimental/_impl/_lsystem_comm.scad>;
use <turtle/turtle3d.scad>;
    
function _lsystem3_derive(axiom, rules, n, rules_pr) =
    is_undef(rules_pr) ? _derive(axiom, rules, n) :
                         _derive_p(axiom, rules, rules_pr, n);

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
    code == "F" || code == "f" ? turtle3d("xu_move", t, leng) :
    code == "+" ? turtle3d("zu_turn", t, angle) :
    code == "-" ? turtle3d("zu_turn", t, -angle) : t;    

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
            [turtle3d("pt", t1), turtle3d("pt", t2)]
    ];
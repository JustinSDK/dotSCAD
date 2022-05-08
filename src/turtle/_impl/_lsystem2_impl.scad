use <_lsystem_comm.scad>;
use <../turtle2d.scad>;

function _lsystem2_join(str_lt) = _join(str_lt);

function _lsystem2_derive(axiom, rules, n, rule_prs, seed) = _derive(axiom, rules, n, rule_prs, seed);

function _next_stack(t, code, stack) = 
    code == "["                ? [t, stack] :
    code == "]" && stack != [] ? stack[1] : stack;

function _next_t1(t1, t2, code, stack) = 
    code == "[" ? t1 : 
    code == "]" ? stack[0] : t2; 
    
function _next_t2(t, code, angle, leng) = 
    is_undef(code) || code == "[" || code == "]" ? t :
    code == "F" || code == "f" ? turtle2d("forward", t, leng) :
    code == "+" ? turtle2d("turn", t, angle) :
    code == "-" ? turtle2d("turn", t, -angle) : 
    code == "|" ? turtle2d("turn", t, 180) : t;    

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
        let(p1 = turtle2d("pt", t1), p2 = turtle2d("pt", t2))
        if(search(codes[i], "F+-") != [] && p1 != p2)
         [p1, p2]
    ];
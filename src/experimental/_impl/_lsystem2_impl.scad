use <experimental/assoc_lookup.scad>;
use <turtle/turtle2d.scad>;
use <util/rand.scad>;

// It doesn't use recursion to avoid recursion error. 
function _join(strs) = 
    let(leng = len(strs))
    [for(i = 0, s = strs[0]; i < leng; i = i + 1, s = str(s, strs[i])) s][leng - 1];

function c_or_v(c, v, rules, rules_pr, leng, i = 0) =
    i == leng ? c : (
        let(idx = search([v[i]], rules, num_returns_per_match=0, index_col_num = 1)[0][0])
        rand(0, 1) <= rules_pr[idx] ? v[i] : c_or_v(c, v, rules, rules_pr, leng, i + 1)
    );

function _derive1_p(base, rules, rules_pr) = 
    _join([
        for(c = base) 
        let(v = [for(r = rules) if(r[0] == c) r[1]])
        v == [] ? c : 
        c_or_v(c, v, rules, rules_pr, len(v))
    ]);

function _derive_p(base, rules, rules_pr, n, i = 0) =
    i == n ? base : _derive_p(_derive1_p(base, rules, rules_pr), rules, rules_pr, n, i + 1);

function _derive1(base, rules) = _join([
    for(c = base) 
    let(v = assoc_lookup(rules, c))
    is_undef(v) ? c : v
]);

function _derive(base, rules, n, i = 0) =
    i == n ? base : _derive(_derive1(base, rules), rules, n, i + 1);
    
function _lsystem2_derive(rules, n, rules_pr) =
    is_undef(rules_pr) ? _derive(rules[0][1], rules, n) : 
    rand() <= rules_pr[0] ? _derive_p(rules[0][1], rules, rules_pr, n) : "";

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
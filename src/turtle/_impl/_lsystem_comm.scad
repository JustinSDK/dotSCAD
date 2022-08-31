use <../../util/rand.scad>

function _codes(axiom, rules, n, forward_chars, rule_prs, seed) = 
    let(derived = _derive(axiom, rules, n, rule_prs, seed))
    forward_chars == "F" ? derived : _join([
        for(c = derived)
        let(idx = search(c, forward_chars))
        idx == [] ? c : "F"
    ]);

function _next_stack(t, code, stack) = 
    code == "["                ? [t, stack] :
    code == "]" && stack != [] ? stack[1] : stack;

function _next_t1(t1, t2, code, stack) = 
    code == "[" ? t1 : 
    code == "]" ? stack[0] : t2; 

function _assoc_lookup(array, key) = 
    array[search([key], array)[0]][1];

// It doesn't use recursion to avoid recursion error. 
function _join(str_lt) = 
    let(leng = len(str_lt))
    [for(i = 0, s = str_lt[0]; i < leng; i = i + 1, s = str(s, str_lt[i])) s][leng - 1];

function c_or_v(c, v, rules, rules_pr, leng, seed, ci, i = 0) =
    i == leng ? c : 
    let(idx = search([v[i]], rules, num_returns_per_match=0, index_col_num = 1)[0][0])
    rand(0, 1, seed + ci) <= rules_pr[idx] ? v[i] : c_or_v(c, v, rules, rules_pr, leng, seed, ci, i + 1);

function _derive1_p(base, rules, rules_pr, seed) = 
    _join([
        for(ci = [0:len(base) - 1]) 
        let(c = base[ci], v = [for(r = rules) if(r[0] == c) r[1]])
        v == [] ? c : c_or_v(c, v, rules, rules_pr, len(v), seed, ci)
    ]);

function _derive1(base, rules) = _join([
    for(c = base) 
    let(v = _assoc_lookup(rules, c))
    is_undef(v) ? c : v
]);

function _derive(base, rules, n, rule_prs, seed) =
    let(
        sd = is_undef(seed) ? rand(0, 1, seed) * 1000 : seed,
        derive = is_undef(rule_prs) ? function(base) _derive1(base, rules) : function(base) _derive1_p(base, rules, rule_prs, sd),
        bs = [
            for(i = 0, b = derive(base); i < n; i = i + 1, b = i != n ? derive(b) : undef)
            b
        ]
    )
    bs[len(bs) - 1];

// It doesn't use recursion to avoid recursion error.    
function _lines(t, codes, angle, leng, next_t2, turtle_p) = 
    let(codes_leng = len(codes))
    [
        for(
            i = 0,
            code = codes[i],
            stack = [],            
            t1 = t, 
            t2 = next_t2(t1, code, angle, leng);
            
            i < codes_leng; 
            
            t1 = _next_t1(t1, t2, code, stack), 
            stack = _next_stack(t1, code, stack),
            i = i + 1, 
            code = codes[i],
            t2 = next_t2(t1, code, angle, leng)
        )
        if(code == "F")
        [turtle_p(t1), turtle_p(t2)]
    ];
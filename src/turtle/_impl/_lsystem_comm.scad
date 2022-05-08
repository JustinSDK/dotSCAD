use <../../util/rand.scad>;

function _assoc_lookup(array, key) = 
    array[search([key], array)[0]][1];

// It doesn't use recursion to avoid recursion error. 
function _join(str_lt) = 
    let(leng = len(str_lt))
    [for(i = 0, s = str_lt[0]; i < leng; i = i + 1, s = str(s, str_lt[i])) s][leng - 1];

function c_or_v(c, v, rules, rules_pr, leng, seed, i = 0) =
    i == leng ? c : 
    let(idx = search([v[i]], rules, num_returns_per_match=0, index_col_num = 1)[0][0])
    rand(0, 1, seed + i) <= rules_pr[idx] ? v[i] : c_or_v(c, v, rules, rules_pr, leng, seed, i + 1);

function _derive1_p(base, rules, rules_pr, seed) = 
    _join([
        for(c = base) 
        let(v = [for(r = rules) if(r[0] == c) r[1]])
        v == [] ? c : c_or_v(c, v, rules, rules_pr, len(v), seed)
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
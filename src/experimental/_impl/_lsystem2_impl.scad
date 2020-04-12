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

function cmd(symbol, args) =
    symbol == "F" ? ["forward", args[0]] :
    symbol == "M" ? ["move", args[0]] :
    symbol == "+" ? ["turn", args[1]] :
    symbol == "-" ? ["turn", -args[1]] : 
    symbol == "[" ? ["push"] :
    symbol == "]" ? ["pop"] : [];
    
function _fd_if_mv(cmd) = 
    cmd == "move" ? "forward" : cmd;

function _next_stack(t, cmd, stack) = 
    cmd[0] == "push" ? concat([t], stack) :
    let(leng = len(stack))
    cmd[0] == "pop" ? 
            (leng > 1 ? [for(i = [1:leng - 1]) stack[i]] : []) :
            stack;

function _next_t1(t1, t2, cmd, stack) = 
    cmd[0] == "push" ? t1 : 
    cmd[0] == "pop" ? stack[0] : t2; 
    
function _next_t2(t, cmd) = 
    is_undef(cmd) || cmd[0] == "push" || cmd[0] == "pop" ? t : turtle2d(_fd_if_mv(cmd[0]), t, cmd[1]);

// It doesn't use recursion to avoid recursion error.    
function _lines(t, cmds) = 
    let(leng = len(cmds))
    [
        for(
            i = 0,
            stack = [],            
            t1 = t, 
            t2 = _next_t2(t1, cmds[i]);
            
            i < leng; 
            
            t1 = _next_t1(t1, t2, cmds[i], stack), 
            stack = _next_stack(t1, cmds[i], stack),
            i = i + 1, 
            t2 = _next_t2(t1, cmds[i])
        )
        if(cmds[i][0] != "move" && cmds[i][0] != "push" && cmds[i][0] != "pop")
            [turtle2d("pt", t1), turtle2d("pt", t2)]
    ];
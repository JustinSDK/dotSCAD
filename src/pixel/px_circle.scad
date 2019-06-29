function _px_circle_y(f, y) = f >= 0 ? y - 1 : y;
function _px_circle_ddf_y(f, ddf_y) = f >= 0 ? ddf_y + 2 : ddf_y;
function _px_circle_f(f, ddf_y) = f >= 0 ? f + ddf_y : f;

function _px_circle(f, ddf_x, ddf_y, x, y, filled) = 
    x >= y ? [] : 
    let(
        ny = _px_circle_y(f, y),
        nddf_y = _px_circle_ddf_y(f, ddf_y),
        nx = x + 1,
        nddf_x = ddf_x + 2,
        nf = _px_circle_f(f, ddf_y) + nddf_x
    )
    concat(
        filled ? 
            concat(
               [for(xi = -nx; xi <= nx; xi = xi + 1) [xi, -ny]],
               [for(xi = -ny; xi <= ny; xi = xi + 1) [xi, -nx]],
               [for(xi = -ny; xi <= ny; xi = xi + 1) [xi, nx]],
               [for(xi = -nx; xi <= nx; xi = xi + 1) [xi, ny]]              
            )
            :
            [  
                [-nx, -ny], [nx, -ny],                 
                [-ny, -nx], [ny, -nx],
                [-ny, nx], [ny, nx],
                [-nx, ny], [nx, ny]
            ],
        _px_circle(nf, nddf_x, nddf_y, nx, ny, filled)
    );
    
function px_circle(radius, filled = false) =
    let(
        f = 1 - radius,
        ddf_x = 1,
        ddf_y = -2 * radius,
        x = 0,
        y = radius
    )
    concat(
        filled ? 
            concat(
                [[0, radius], [0, -radius]],
                [for(xi = -radius; xi <= radius; xi = xi + 1) [xi, 0]]
            )
            : 
            [
                [0, -radius],                
                [-radius, 0], 
                [radius, 0],
                [0, radius]
            ],
        _px_circle(f, ddf_x, ddf_y, x, y, filled)
    );
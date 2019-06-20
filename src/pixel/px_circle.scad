function _px_circle_y(f, y) = f >= 0 ? y - 1 : y;
function _px_circle_ddf_y(f, ddf_y) = f >= 0 ? ddf_y + 2 : ddf_y;
function _px_circle_f(f, ddf_y) = f >= 0 ? f + ddf_y : f;

function _px_circle_sub(center, f, ddf_x, ddf_y, x, y, filled) = 
    let(
        x0 = center[0],
        y0 = center[1],
        ny = _px_circle_y(f, y),
        nddf_y = _px_circle_ddf_y(f, ddf_y),
        nx = x + 1,
        nddf_x = ddf_x + 2,
        nf = _px_circle_f(f, ddf_y) + nddf_x
    )
    concat(
        filled ? 
            concat(
               [for(xi = -nx; xi <= nx; xi = xi + 1) [x0 - xi, y0 + ny]],
               [for(xi = -ny; xi <= ny; xi = xi + 1) [x0 - xi, y0 + nx]],
               [for(xi = -ny; xi <= ny; xi = xi + 1) [x0 - xi, y0 - nx]],
               [for(xi = -nx; xi <= nx; xi = xi + 1) [x0 - xi, y0 - ny]]
            )
            :
            [
                [x0 - nx, y0 + ny],
                [x0 + nx, y0 + ny],
                [x0 - ny, y0 + nx],
                [x0 + ny, y0 + nx],

                [x0 - ny, y0 - nx],            
                [x0 + ny, y0 - nx],
                [x0 - nx, y0 - ny],
                [x0 + nx, y0 - ny]        
            ],
        _px_circle(center, nf, nddf_x, nddf_y, nx, ny, filled)
    );
    

function _px_circle(center, f, ddf_x, ddf_y, x, y, filled) = 
    x >= y ? [] : _px_circle_sub(center, f, ddf_x, ddf_y, x, y, filled);
    
function px_circle(radius, center = [0, 0], filled = false) =
    let(
        x0 = center[0],
        y0 = center[1],
        f = 1 - radius,
        ddf_x = 1,
        ddf_y = -2 * radius,
        x = 0,
        y = radius
    )
    concat(
        filled ? 
            concat(
                [[x0, y0 + radius], [x0, y0 - radius]],
                [for(xi = -radius; xi <= radius; xi = xi + 1) [x0 + xi, y0]]
            )
            : 
            [
                [x0, y0 + radius], 
                [x0, y0 - radius], 
                [x0 + radius, y0], 
                [x0 -radius, y0]
            ],
        _px_circle(center, f, ddf_x, ddf_y, x, y, filled)
    );
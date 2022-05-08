function _y(f, y) = f >= 0 ? y - 1 : y;
function _ddf_y(f, ddf_y) = f >= 0 ? ddf_y + 2 : ddf_y;
function _f(f, ddf_y) = f >= 0 ? f + ddf_y : f;

function _vx_circle(f, ddf_x, ddf_y, x, y, filled) = 
    x >= y ? [] : 
    let(
        ny = _y(f, y),
        nddf_y = _ddf_y(f, ddf_y),
        nx = x + 1,
        nddf_x = ddf_x + 2,
        nf = _f(f, ddf_y) + nddf_x
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
        _vx_circle(nf, nddf_x, nddf_y, nx, ny, filled)
    );
    
function _vx_circle_impl(radius, filled) =
    let(
        f = 1 - radius,
        ddf_x = 1,
        ddf_y = -2 * radius,
        x = 0,
        y = radius
    )
    concat(
        filled ? 
            [[0, radius], [0, -radius], each [for(xi = -radius; xi <= radius; xi = xi + 1) [xi, 0]]]
            : 
            [
                [0, -radius],                
                [-radius, 0], 
                [radius, 0],
                [0, radius]
            ],
        _vx_circle(f, ddf_x, ddf_y, x, y, filled)
    );
/**
* polytransversals.scad
*
* Crosscutting a polyline at different points gets several transversals.
* This module can operate reversely. It uses transversals to construct a polyline.
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-polytransversals.html
*
**/

include <__private__/__reverse.scad>;

module polytransversals(transversals) {
    leng_trs = len(transversals);
    leng_tr = len(transversals[0]);

    lefts = [
        for(i = [1:leng_trs - 2]) 
            let(tr = transversals[leng_trs - i])
                tr[0]
    ];

    rights = [
        for(i = [1:leng_trs - 2]) 
            let(tr = transversals[i])
                tr[leng_tr - 1]
    ];

    polygon(
        concat(
            transversals[0], 
            rights, 
            __reverse(transversals[leng_trs - 1]), 
            lefts
        )
    );
}
/**
* polytransversals.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-polytransversals.html
*
**/

include <util/__comm__/__reverse.scad>;
include <__comm__/__polytransversals.scad>;

module polytransversals(transversals) {
    polygon(
        __polytransversals(transversals)
    );
}
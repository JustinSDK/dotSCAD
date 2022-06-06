use <../../util/unit_vector.scad>
use <../../util/sum.scad>

ZERO_VTS = [undef, undef, [0, 0], [0, 0, 0]];

function limit(vt, magnitude) = 
    let(m = norm(vt))
    m > magnitude ? vt / m * magnitude : vt;
    
function setMagnitude(vt, magnitude) = unit_vector(vt) * magnitude;

// node
function node(position, option) = [
    position,                   // position
    rands(0, 1, len(position)), // velocity
    option                      // option
];

function position_of(node) = node[0];
function velocity_of(node) = node[1];
function option_of(node) = node[2];
function maxForce_of(node) = node[2][0];
function maxSpeed_of(node) = node[2][1];
function separationDistance_of(node) = node[2][2];
function separationCohesionRatio_of(node) = node[2][3];
function maxEdgeLength_of(node) = node[2][4];

function cohesionWith(node, other) =
    let(pos = position_of(node))
    limit(
        other == pos ? -velocity_of(node) : setMagnitude(other - pos, maxSpeed_of(node)) - velocity_of(node),
        maxForce_of(node)
    );
    
function seperationFrom(node, other) =
    let(
        v = position_of(node) - position_of(other),
        dist = norm(v)
    )
    dist < separationDistance_of(node) ? v / dist : ZERO_VTS[len(v)];

function applyForceTo(node, seperation, cohesion) = 
    let(
        acceleration = limit(seperation, maxForce_of(node)) * separationCohesionRatio_of(node) + cohesion,
        velocity = limit(velocity_of(node) + acceleration, maxSpeed_of(node))
    )
    [
        position_of(node) + velocity,
        velocity,
        option_of(node)
    ];

function suitableForGrowth(node, nxNode) =
    norm(position_of(node) - position_of(nxNode)) > maxEdgeLength_of(node);

function growNode(node, nxNode) = 
    node((position_of(node) + position_of(nxNode)) / 2, option_of(node));

// nodes

function cohesion(nodes, leng, i) =
    let(
        node = nodes[i],
        middlePt = (position_of(nodes[(leng + i - 1) % leng]) + position_of(nodes[(i + 1) % leng])) / 2
    )
    cohesionWith(node, middlePt);

function grow(nodes, leng) =
    [
        for(i = 0; i < leng; i = i + 1)
        let(
            node = nodes[i],
            nxNode = nodes[(i + 1) % leng]
        )
        each [node, if(suitableForGrowth(node, nxNode)) growNode(node, nxNode)]
    ];

function allSeperationFrom(nodes, leng, node, n) = [
    for(j = n; j < leng; j = j + 1) seperationFrom(node, nodes[j])
];

function updateAllSeperation(allSeperation, allSeperationFromj) = 
    let(leng = len(allSeperationFromj))
    [for(k = 1; k <= leng; k = k + 1) allSeperation[k]] - allSeperationFromj; 

function differentiate(nodes, leng) = 
    let(ZERO_VT = ZERO_VTS[len(position_of(nodes[0]))])
    [
        for(i = 0,
            allSeperationFromj = allSeperationFrom(nodes, leng, nodes[i], i + 1),
            allSep = [ZERO_VT, each -allSeperationFromj]; 
            i < leng; 
            i = i + 1,
            allSep = updateAllSeperation(allSep, allSeperationFromj),
            allSeperationFromj = allSeperationFrom(nodes, leng, nodes[i], i + 1)
        )
        applyForceTo(
            nodes[i], 
            allSeperationFromj == [] ? allSep[0] : allSep[0] + sum(allSeperationFromj), 
            cohesion(nodes, leng, i)
        )
    ];
    
function _differential_line_growth(nodes) = 
    let(leng = len(nodes))
    grow(differentiate(nodes, leng), leng);
    
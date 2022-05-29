use <../../util/unit_vector.scad>;
use <../../util/sum.scad>;

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
        for(i = 0, j = 1; i < leng; i = i + 1, j = j + 1)
        let(
            node = nodes[i],
            nxNode = nodes[j % leng]
        )
        each [node, if(suitableForGrowth(node, nxNode)) growNode(node, nxNode)]
    ];

function allSeperationFrom(nodes, leng, node, n) = [
    for(j = n; j < leng; j = j + 1)
    seperationFrom(node, nodes[j])
];

function updateAllSeperation(allSeperation, allSeperationFrom_i_1) = 
    let(leng = len(allSeperationFrom_i_1))
    [
        for(k = 0; k < leng; k = k + 1)
        allSeperation[k + 1] - allSeperationFrom_i_1[k]
    ]; 

function differentiate(nodes, leng) = 
    let(ZERO_VT = ZERO_VTS[len(position_of(nodes[0]))])
    [
        for(i = 0,
            j = 1,
            allSeperationFrom_i_1 = allSeperationFrom(nodes, leng, nodes[i], j),
            allSep = [ZERO_VT, each -allSeperationFrom_i_1],
            running = i < leng; 
            running; 
            i = i + 1,
            j = j + 1,
            running = i < leng,
            allSep = running ? updateAllSeperation(allSep, allSeperationFrom_i_1) : undef,
            allSeperationFrom_i_1 = running ? allSeperationFrom(nodes, leng, nodes[i], j) : undef
        )
        applyForceTo(
            nodes[i], 
            sum([allSep[0], each allSeperationFrom_i_1]), 
            cohesion(nodes, leng, i)
        )
    ];
    
function _differential_line_growth(nodes) = 
    let(leng = len(nodes))
    grow(differentiate(nodes, leng), leng);
    
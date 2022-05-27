use <../../util/unit_vector.scad>;
use <../../util/sum.scad>;

ZERO_VT = [0, 0];

function limit(vt, magnitude) = 
    let(m = norm(vt))
    m > magnitude ? vt / m * magnitude : vt;
    
function setMagnitude(vt, magnitude) = vt == ZERO_VT ? vt : unit_vector(vt) * magnitude;

// node
function node(position, option) = [
    position,       // position
    rands(0, 1, 2), // velocity
    option          // option
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
    limit(
        setMagnitude(other - position_of(node), maxSpeed_of(node)) - velocity_of(node),
        maxForce_of(node)
    );
    
function seperationFrom(node, other) =
    let(
        v = position_of(node) - position_of(other),
        dist = norm(v)
    )
    dist < separationDistance_of(node) ? v / dist : ZERO_VT;

function applyForceTo(node, seperation, cohesion) = 
    let(
        acceleration = limit(seperation, maxForce_of(node)) * separationCohesionRatio_of(node) + cohesion,
        velocity = limit(velocity_of(node) + acceleration,
        maxSpeed_of(node))
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

function updateAllSeperation(allSeperation, allSeperationFrom_i_1, leng, n) = [
    for(i = 0; i < leng; i = i + 1)
    if(i < n)  allSeperation[i]
    else allSeperation[i] - allSeperationFrom_i_1[i - n]
]; 

function differentiate(nodes, leng) = 
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
            allSeperationFrom_i_1 = running ? allSeperationFrom(nodes, leng, nodes[i], j) : undef,
            allSep = running ? updateAllSeperation(allSep, allSeperationFrom_i_1, leng, j) : undef
        )
        applyForceTo(
            nodes[i], 
            sum([allSep[i], each allSeperationFrom_i_1]), 
            cohesion(nodes, leng, i)
        )
    ];
    
function _differential_line_growth(nodes) = 
    let(leng = len(nodes))
    grow(differentiate(nodes, leng), leng);
    
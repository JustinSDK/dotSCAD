//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//														Gyroid.scad															//
//			Calculates points and face indices of a gyroid body (one elementary cell). A larger body can be created by		//
//			translating with multiples of 360. For thios purpose the gyroid body is calculated a bit larger than 			//
//			necessarey. It reches from -1 to 361 to obtain some overlap for the union() operation. 							//
//			There is no scaling included. When using the gyroid body as an infill for 3D printing with high strength,		//
//			an intersection() or difference() has to be applied. It is strongly recommended to create						//
//			the gyroid body separately not applying boolean operators except union(). Openscad will crash otherwise.		//
//			It is recommended to render the gyroid body and save ist as an stl file and importing the stl file for			//
//			further processing. By this way, the stl file can be scaled as required. The wall thickness is scaled too.		//
//			Therefore sacing has to be considered when definíng wall thickness. The calculation is performed prior to 		//
//			creating the gyroid body, to avoid multiple time consuming calculation.											//
//																															//
//							Created by Dr. Manfred Witzany under GNU General Public License									//
//																															//
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Calculates gyroid function. The zero crossings define the 2 dimensional gyroid surface.
// n=number of iterations
// x=x-coordinate of point
// y=y-coordinate of point
// z1=lower starting value for z (need not be defined)
// z2=upper starting value for z (need not be defined)
// f1=gyroid function of z1 (need not be defined internal use only)
// f1=gyroid function of z2 (need not be defined internal use only)
function gyroid(x, y, z)=sin(x)*cos(y)+sin(y)*cos(z)+sin(z)*cos(x);

function gyroid_point(n=50, x, y, z1=40, f1, z2=300, f2)=
	(f1==undef || f2==undef) ?							// if f1, f2 are not defined, calculate them
		gyroid_point(n=n-1, x=x, y=y, z1=z1, f1=gyroid(x=x, y=y, z=z1), z2=z2, f2=gyroid(x=x, y=y, z=z2))
	:
		let(z3=(z1+z2)/2)								// find the middle between both limits z1, z2	
		let(f3=gyroid(x=x, y=y, z=z3))					// calculate zthe gyroid function of the middle
		(n<0) ?	z3										// decide, whre the zero crossing of the gyroid function is
		:
			sign(f1)==sign(f3) ?											// next step of iteration
				gyroid_point(n=n-1, x=x, y=y, z1=z3, f1=f3, z2=z2, f2=f2)	// zero crossing is between z2 and z3
			:	gyroid_point(n=n-1, x=x, y=y, z1=z1, f1=f1, z2=z3, f2=f3);	// zero crossing is between z1 and z3

// Calculates the gradient of the gyroid function. This is a vector perpendicularly pointing to the surface.
// The point x, y, z must be a point of the gyroid surface.
// x, y, z=coordinates of point
function grad_gyroid(x, y, z)=
[	cos(x)*cos(y)-sin(z)*sin(x),		// df/dx
	cos(y)*cos(z)-sin(x)*sin(y),		// df/dy
	cos(z)*cos(x)-sin(y)*sin(z)			// df/dz
];

// Calculates a point of a gyroid wall having a distance to the gyroid surface of w/2. 
// x, y, z=point of gyroid surface
// w=wall thickness to calculate the opposing wall point, w needs to be negatve
function wall_gyroid(x, y, z, w)=
	let(n=grad_gyroid(x=x, y=y, z=z))					// calculate the gardient of the gyroid function pointing to the wall vector
	[x, y, z]+w*n/(2*norm(n));							// normalize gradient and multipy it with half of the wall thickness

// Calculates points of a triangular part of a gyroid surface with edge points [0,0], [0,180] and [90,90].
// All other points can be derived from these points by means of coodinate ransformation. The points are calculated in the form of 
// a grid having pp lines in x direction and 2*pp rows in y direction. Additionally one line / row is calculated byond said limits,
// to smoothly combine the individual parts by union().
// pp=number of rows
// w=wall thickness
function gyroid_points(pp, w)=
	let(res=90/(pp-2))									// resolution of points = distance between two adjacent points
	let(p=												// coordinates of points
	[	for (i=[-w, w])									// for both wall directions (up/down)
			for(j=[0:pp])								// for every row
				let(jj=min(max(j, 1),pp-1)-1)
				let(x=90-jj*res-((j==pp) ? abs(w)/2 : 0))						// x and y coordinate of start of current row
				let(start=[(x*x/90+x)/2, x])					// starting point of current row
				let(z=gyroid_point(x=start.x, y=start.y))			// z coordinate of start of current row
				let(end=[180-z, 180-start.x])					// ending point of current row
				for(k=[0:2*j])							// for every line in row
					let(p_xy=
						(j==0)				? [90+w/2, 90]
					:	(k==0)				? start-[0, abs(w)/2]
					:	(k==2*j)			? end+[0, abs(w)/2]
					:	(j==1) && (k==1)	? [90, 90]
					:						  start+(end-start)/(2*(j-1))*(k-1))
					let(wall=(k==0 || k==2*j || j==pp) ? 0 : i)
					wall_gyroid(p_xy.x,p_xy.y,gyroid_point(x=p_xy.x, y=p_xy.y),wall)	// calculate point in row, line within gyroid wall
	])													// matrix of points for all primitives of a gyroid micro cell
	[	[for(i=p) i],									// copy of p
		[for(i=p) [180,180,180]-i],						// diagonally oposing part of p
		[for(i=p) [i.y,i.z,i.x]],						// first cyclic permutation of coordinates
		[for(i=p) [180-i.y,180-i.z,180-i.x]],			// diagonally oposing part of permutation
		[for(i=p) [i.z,i.x,i.y]],						// second cyclic permutation of coordinates
		[for(i=p) [180-i.z,180-i.x,180-i.y]]			// diagonally oposing part of permutation
	];

// Calculates faces index matrix for gyroid polyhedron
// pp=number of rows
function gyroid_faces(pp)=
	let(zs=(pp+1)*(pp+1))								// starting index of down wall points
	  		     										// calculate face index vetros for triangles of polyhedron
	[	for(i=[0:pp-1])									// for every row
			let(jm=i*(i+1))								// middle point index for current j vector
			let(jfm=(i+1)*(i+2))						// middle point index for succeeding j vector
			let(ii=min(i,pp-2))							// don't use the outer points in the last row
			for(j=[0:ii], k=[-1,1], l=[0,1], m=[0,1])	// for every point
				let(dm=(m==0) ? 0 : zs)
				let(p1=jm+j*k+dm)				// first point of triangle
				let(p2=(l==0) ? jfm+j*k+dm : jfm+(j+1)*k+dm)
				let(p3=(l==0) ? jfm+(j+1)*k+dm : jm+(j+1)*k+dm)
				if (j<i || l==0)
					((k==1 && m==0) || (k==-1 && m==1)) ? [p2, p1, p3] : [p1, p2, p3]
	];

// Swaps x and y coordinate of all members in matrix m. Applied on a faces matrix for polyhedron creation, it swaps inside out. 
function swap_xy(m)=
	[	for(i=m)										// fall every menmber in matrix m
			[i.y, i.x, i.z]								// swap x with y
	];

// Operator to create a complete gyroid cell (cube from [0,0,0] to [180,180,180] from single polyhedron 
// by means of mirroring anf translation.
// No parameters required
module gyroid_cell()
{
	modify=								// Matrix defining modification - first vector mirror x, y, z - second vector translate
	[	[[0,0,0],[0,	0,		0]],
		[[1,0,0],[360,	0,		180]],
		[[0,1,0],[180,	360,	0]],
		[[0,0,1],[0,	180,	360]],
		[[1,1,0],[360,	180,	0]],
		[[1,0,1],[180,	0,		360]],
		[[0,1,1],[0,	360,	180]],
		[[1,1,1],[360,	360,	360]]
	];
	for (i=modify)							// for everey modification
		translate(i[1])						// translate triangle
		mirror([i[0].x, 0, 		0])			// mirror in x direction if necessary
		mirror([0,		i[0].y,	0])			// mirror in y direction if necessary
		mirror([0,		0,		i[0].z])	// mirror in z direction if necessary
		children();							// polyhedron of gyroid triangle
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//													module testing															//
//	pp: Higher values make the surface smoother baut increases calculation time.											//
//	w:  Wall thickness for unscaled body. The fundamental cell of the gyroid body has a length of 360. 						//
//		If the body is scaled, the wall thickness has to be devided by the scaling factor. For example: 					//
//		If the gyroid body is scaled with 0.5 to achieve a period of 180, the wallthickness has to be multiplied by 2.		//
//		After scaling the gyroid body the wall thickness has then the desired value.										//
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

pp=7;										// number of rows defines resolution ADAPT AS DESIRED 
w=10;										// wall width						 ADAPT AS DESIRED 

points=gyroid_points(pp=pp, w=w);			// calculate points matrix
f=gyroid_faces(pp=pp);						// calculate faces vector
fi=swap_xy(m=f);							// calculate faces vector for mirrored objects
gyroid_cell()							// apply coordinate transformations
for(i=[0:len(points)-1])													// for every vector in matrix
	polyhedron(points=points[i], faces=(i%2==0) ? fi : f, convexity=100);	// create polyhedron of gyroid body

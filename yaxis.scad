$fn = 50;

rodlen = 300;
rodsep = 120;
rodrad = 4.25;
base = 24;

pulleyrad = 10;
pulleyheight = 15;
spoolrad = 10;
platethick = 6;
strapthick=4;
motorwidth = 44;
motoropenrad = 13;
motorboltspread = 31.5;
plate1len = 34;
extraheight = 3;
extramotorclearance = 2;

dim = 20;

m3rad = 1.9;
m5rad = 3;
m5caprad = 4.7;
m5nutrad = 4.7;


*for (i=[-1, 1], j=[-1, 1])
	translate([j*27, i*15, 0]) rodend();

*for (i=[-1, 1])
	translate([-i*25, 0, 0]) pulleyplate1(i);

*rotate([180, 0, 0])
 pulleyplate2();

yaxis();

module yaxis() {
	for (i=[-1, 1])
		translate([i*rodsep/2, 0, 0])
			rotate([90, 0, 0])
				color("silver") cylinder(r=rodrad, h=rodlen, center=true);
	
	for (i=[-1, 1], j=[-1, 1])
		translate([i*rodsep/2, j*rodlen/2, 0])
			rodend(-j);
	ext1();
	ext2();
	pulleys();
	pulleyplates();
	tstraps();
}

module ext1() {
	color("silver")
	for (i=[-1, 1])
		translate([0, i*rodlen/2, -(rodrad+4+base+dim/2)])
			cube([rodsep+rodrad*2+8+dim*2, dim, dim], true);
}

module ext2() {
	color("silver")
	for (i=[-1, 1])
		translate([i*(rodsep/2+5), 0, -(rodrad+4+base+dim/2)])
			cube([dim, rodlen-dim, dim], true);
}

module pulley() {
	color("blue")
	cylinder(r=pulleyrad, h=pulleyheight, center=true);
}

module pulleys() {
	for (i=[-1, 1]) {
		translate([-pulleyrad, i*(rodlen/2+pulleyrad*2+5), -(rodrad+4+base-pulleyheight/2-platethick)])
			pulley();
		translate([-pulleyrad*3, i*(pulleyrad+spoolrad), -(rodrad+4+base-pulleyheight/2-platethick)])
			pulley();
	}
}

module rodend(dir=1) {
	difference() {
		union() {
			rotate([90, 0, 0])
				cylinder(r=rodrad+4, h=dim, center=true);
			translate([0, 0, -(rodrad+4+base)/2])
				cube([(rodrad+4)*2, dim, rodrad+4+base], true);
			translate([0, 0, -(rodrad+4+base/2)]) {
				hull() for (i=[-1, 1])
					translate([i*(rodrad+4+5), 0, 0])
						cylinder(r=dim/2, h=base, center=true);
			}
		}
		translate([0, dir*3, 0])
			rotate([90, 0, 0])
				cylinder(r=rodrad, h=20, center=true);
		for (i=[-1, 1]) {
			translate([i*(rodrad+4+5), 0, -(rodrad+4+base/2)])
				cylinder(r=m5rad, h=base*2, center=true);
			translate([i*(rodrad+4+5), 0, -(rodrad+4+base/2)+5])
				cylinder(r=m5caprad, h=base, center=true);
		}
	}
}

module pulleyplates() {
	for (i=[-1, 1])
		translate([-pulleyrad, i*rodlen/2, -(rodrad+4+base-platethick/2)])
			pulleyplate1(i);

	translate([-(rodsep/2+5), 0, -(rodrad+4+base-platethick/2)])
		pulleyplate2();
}

module pulleyplate1(dir=1) {
	difference() {
		union() {
			hull() {
				translate([0, 0, extraheight/2])
					cube([plate1len, dim, platethick++extraheight], true);
				translate([dir*pulleyrad, (pulleyrad*2+5), 0])
					cylinder(r=pulleyrad, h=platethick, center=true);
			}
			translate([0, 0, platethick/2+extraheight])
				cube([plate1len, 5.1, 2], true);
			translate([dir*pulleyrad, (pulleyrad*2+5), platethick/2])
				cylinder(r=m5rad+4, h=platethick*2, center=true);
		}
		for (i=[-1, 1])
			translate([i*pulleyrad*0.8, 0, (extraheight+1)/2]) {
				translate([0, 0, 4.25])
					cylinder(r=m5rad, h=platethick+extraheight+1, center=true);
				translate([0, 0, -platethick-extraheight-1+4])
					cylinder(r=m5caprad, h=platethick+extraheight+1, center=true);
			}
		translate([dir*pulleyrad, (pulleyrad*2+5), 0])
			cylinder(r=m5rad, h=platethick*2, center=true);
		translate([dir*pulleyrad, (pulleyrad*2+5), platethick*1.5-1.99])
			cylinder(r=m5nutrad, h=4, $fn=6, center=true);
	}
}

module pulleyplate2() {
	difference() {
		union() {
			hull() {
				translate([-platethick/2, 0, 0])
					cube([dim+platethick, (spoolrad+pulleyrad*3)*2+10, platethick], true);
				for (i=[-1, 1])
					translate([(rodsep/2+5)-pulleyrad*3, i*(pulleyrad+spoolrad), 0])
						cylinder(r=pulleyrad, h=platethick, center=true);
				translate([-dim/2-motorwidth/2-platethick-10, 0, 0])
					cube([motorwidth, motorwidth+platethick*2, platethick], true);
			}
			if (extraheight != 0) {
				translate([0, 0, -platethick/2-extraheight/2]) 
					cube([dim, (spoolrad+pulleyrad*3)*2+10, extraheight], true);
			}
			translate([0, 0, -platethick/2-extraheight]) 
				cube([5.1, (spoolrad+pulleyrad*3)*2+10, 2], true);
			
			for (i=[-1, 1])
				translate([(rodsep/2+5)-pulleyrad*3, i*(pulleyrad+spoolrad), -platethick/2])
					cylinder(r=m5rad+4, h=platethick*2, center=true);
			
			translate([-dim/2-platethick/2, 0, -dim/2-platethick/2-extraheight/2])
				cube([platethick, (spoolrad+pulleyrad*3)*2+10, dim+extraheight], true);
			for (i=[-1, 1])
				translate([-(motorwidth+platethick+10+dim)/2, i*(motorwidth/2+platethick/2), -dim/2-platethick/2])
					cube([motorwidth+platethick+10, platethick, dim], true);
		}

		translate([-(motorwidth+20)/2-dim/2-platethick, 0, -motorwidth/2-platethick/2+extramotorclearance])
			cube([motorwidth+20, motorwidth, motorwidth], true);

		for (i=[-1, 1])
			translate([(rodsep/2+5)-pulleyrad*3, i*(pulleyrad+spoolrad), -platethick*1.5+1.99])
				cylinder(r=m5nutrad, h=4, center=true, $fn=6);

		translate([-dim/2-platethick, 0, -platethick/2-dim])
			rotate([0, 21, 0])
				translate([-motorwidth, 0, -dim])
					cube([motorwidth*2, motorwidth*2, dim*2], true);
		for (i=[-1, 1]) {
			translate([(rodsep/2+5)-pulleyrad*3, i*(pulleyrad+spoolrad), 0])
				cylinder(r=m5rad, h=platethick*5, center=true);
			translate([-dim/2-platethick/2, i*motorwidth/1.2, -dim/2-platethick/2-extraheight])
				rotate([0, 90, 0])
					cylinder(r=m5rad, h=platethick*4, center=true);
		}

		for (i=[-1, 0, 1])
			translate([0, i*(pulleyrad*2+spoolrad), -extraheight/2-0.5]) {
				translate([0, 0, -extraheight-2.25])
					cylinder(r=m5rad, h=platethick+extraheight+1, center=true);
				translate([0, 0, platethick+1-2])
					cylinder(r=m5caprad, h=platethick+extraheight+1, center=true);
			}
		translate([-dim/2-motorwidth/2-platethick-10, 0, 0]) {
			cylinder(r=motoropenrad, h=platethick*2, center=true);
			for (i=[-1, 1], j=[-1, 1])
				translate([i*motorboltspread/2, j*motorboltspread/2, 0])
					cylinder(r=m3rad, h=platethick*2, center=true);
		}
	}
}

module tstraps() {
	for (i=[-1, 1], j=[-1, 1])
		translate([i*(rodsep/2+5), j*rodlen/2, -(rodrad+4+base+dim+strapthick/2)])
			tstrap(-j);
}

module tstrap(dir=1) {
	difference() {
		union() {
			cube([dim*2, dim, strapthick], true);
			translate([0, dir*dim*1.5, 0])
				cube([dim, dim*2, strapthick], true);
		}
		for (i=[-1, 1]) {
			translate([i*dim/2, 0, 0])
				cylinder(r=m5rad, h=strapthick*2, center=true);
			translate([0, dir*dim*1.5+i*dim/2, 0])
				cylinder(r=m5rad, h=strapthick*2, center=true);
		}
	}
}
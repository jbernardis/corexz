$fn = 50;

rod_diameter = 8;

clearance=0.7;

lmxuu_diameter=15+clearance;
lmxuu_length=24+clearance;
lmxuu_support_thickness=3.2; 
lmxuu_end_diameter=rod_diameter+2;
lmxuu_base_thickness = 2;

lmxuu_holder_width=lmxuu_diameter+2*lmxuu_support_thickness;
lmxuu_holder_length=lmxuu_length+2*lmxuu_support_thickness;
lmxuu_holder_height=lmxuu_diameter*0.75+lmxuu_support_thickness;

lmxuu_holder_gap=(lmxuu_holder_length-5*lmxuu_support_thickness);

m5rad = 3;
m5caprad = 5;
m4rad = 2.45;
m4caprad = 4;
m5nutrad = 4.7;
tunerrad = 5.1;
mh_loc = [];


$fn = 50;

barsep = 100;
holesepw = 149;
holesepl = 45;
centerl = 95;
carriagedepth = centerl + 10;

m5rad = 3;

strapw = 19;
thick = 6;
mountthick = 15;

union() {
	difference() {
		union() {
			difference() {
				hull() 
					for (i=[-1, 1], j=[-1, 1])
						translate([i*holesepw/2, j*holesepl/2, 0])
							cylinder(r=strapw/2, h=thick, center=true);
				cube([holesepw - strapw, holesepl - strapw, thick+1], true);
			}
			hull() 
				for (i=[-1, 1])
					translate([0, i*centerl/2, (mountthick-thick)/2])
						cylinder(r=strapw/2+3, h=mountthick, center=true);
			for (i=[-1, 1])
				translate([i*barsep/2, 0, 0])
					cube([strapw, carriagedepth-lmxuu_holder_length, thick], true);
			for (i=[-1, 1], j=[-1, 1])
				translate([i*barsep/2, j*carriagedepth/2, -thick/2])
					lmxuu_bearing_holder();
		}
		holes();
	}
}


module holes() {
	for (i=[-1, 1], j=[-1, 1])
		translate([i*holesepw/2, j*holesepl/2, 0])
			cylinder(r=m5rad, h=thick*2, center=true);
	translate([0, centerl/2, (mountthick-thick)/2]) {
		translate([0, 0, 4.25])
			cylinder(r=m5rad, h=mountthick, center=true);
		translate([0, 0, mountthick/2-2+0.1])
			cylinder(r=m5nutrad, center=true, h=4, $fn=6);
		translate([0, 0, -(mountthick/2-2)])
			cylinder(r=m5caprad, center=true, h=4.01);
	}
	translate([0, -centerl/2, (mountthick-thick)/2]) {
		cylinder(r=tunerrad, h=mountthick*2, center=true);
		translate([8, 8, 0])
			cylinder(r=1.25, h=mountthick*2, center=true);
	}
}

module lmxuu_bearing_holder() {
	translate([0, 0, lmxuu_base_thickness+lmxuu_holder_height/2])
	rotate([0, 0, 0])
	difference() {
		translate([0, 0, -lmxuu_base_thickness/2])
			cube([lmxuu_holder_width,lmxuu_holder_length,lmxuu_holder_height+lmxuu_base_thickness], true);
		translate([0,0,lmxuu_support_thickness])
			rotate([-90,0,0])
				cylinder(r=lmxuu_diameter/2,h=lmxuu_length,$fn=40, center=true);

		translate([0, 0, lmxuu_diameter/2+lmxuu_support_thickness])
			cube([lmxuu_diameter, lmxuu_length, lmxuu_diameter], true);

		translate([0, 0, lmxuu_support_thickness])
			rotate([-90,0,0]) {
				cylinder(r=lmxuu_end_diameter/2,h=lmxuu_holder_length+2,$fn=40, center=true);
				translate([0, -lmxuu_end_diameter/2, 0])
					cube([lmxuu_end_diameter,lmxuu_end_diameter,lmxuu_holder_length+2], true);
			}

		translate([0, 0, lmxuu_support_thickness*2])
			cube([lmxuu_holder_width+2,lmxuu_holder_gap, lmxuu_holder_height], true);

		for (i=mh_loc) {
			translate([0, i, -lmxuu_base_thickness/2-1])
				cylinder(r=mh_rad, center=true, h=lmxuu_holder_height + lmxuu_base_thickness);
			translate([0, i, -lmxuu_base_thickness/2+lmxuu_base_thickness/2])
				cylinder(r=mh_headrad, center=true, h=lmxuu_holder_height + lmxuu_base_thickness);
		}

		translate([0, 0, -10])
			union() {
				cube([lmxuu_holder_width*0.6, 4, 2], true);
				for (i=[-1, 1])
					translate([i*lmxuu_holder_width*0.27, 0, 0])
						rotate([0, i*22, 0])
							translate([0, 0, 8])
								cube([2, 4, 16], true);
			}
	}
}





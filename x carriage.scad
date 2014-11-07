$fn = 30;

rod_diameter = 10;

clearance=0.7;

lmxuu_diameter=19+clearance;
lmxuu_length=29+clearance;
lmxuu_support_thickness=3.2; 
lmxuu_end_diameter=rod_diameter+2;
lmxuu_base_thickness = 0;

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

mh_rad = 1.9;
mh_headrad = 3.2;
mh_loc = [  ];

bar_sep = 70;
carriage_width = 90;
carriage_height = bar_sep+lmxuu_holder_width;
carriage_thick = 15;

block_width = 40;
block_height = 20;
block_thick = 20;

translate([0, 0, carriage_thick/2])
difference() {
	union() {
		for (i=[-1, 1], j=[-1, 1])
			translate([i*(carriage_width/2-lmxuu_holder_length/2), j*(carriage_height/2-lmxuu_holder_width/2), lmxuu_holder_height/2-carriage_thick/2])
				lmxuu_bearing_holder();
		cube([carriage_width, bar_sep - lmxuu_holder_width, carriage_thick], true);
		translate([0, 0, carriage_thick/2+block_thick/2]) {
			cube([block_width, block_height, block_thick], true);
			cube([carriage_width - 2*lmxuu_holder_length, bar_sep - lmxuu_holder_width, block_thick], true);
		}
		translate([-carriage_width/2+5, -carriage_height/2-5, -2.5])
			difference() {
				cube([10, 10, 10], true);
				translate([0, 0, 4.25])
					cylinder(r=1.9, h=10, center=true);
				translate([0, 0, -6])
					cylinder(r=3.2, h=10, center=true, $fn=6);
			}

	}
	for (i=[-1, 1]) {
		translate([i*(block_width/2-6), 0, block_thick/2])	{
			translate([0, 0, block_thick+0.25])
				cylinder(r=m4rad, h=block_thick+carriage_thick, center=true);
			translate([0, 0, -carriage_thick])
				cylinder(r=m4caprad, h=block_thick+carriage_thick, center=true);
		}
		translate([0, i*((bar_sep - lmxuu_holder_width)/2-6), block_thick/2]) {
			translate([0, 0, block_thick+0.25])
				cylinder(r=m4rad, h=block_thick+carriage_thick, center=true);
			translate([0, 0, -carriage_thick])
				cylinder(r=m4caprad, h=block_thick+carriage_thick, center=true);
		}
	}
	for (i=[-1, 1]) {
		translate([i*(carriage_width-22)/2, 21/2+2, 4.25])
			cylinder(r=m5rad, h=carriage_thick, center=true);
		translate([i*(carriage_width-22)/2, 21/2+2, carriage_thick/2-2.99])
			cylinder(r=m5caprad, h=6, center=true);
		translate([i*(carriage_width-22)/2, 21/2+2, -(carriage_thick/2-1.99)])
			cylinder(r=m5nutrad, h=4, center=true, $fn=6);
		translate([i*(carriage_width-22)/2, -21/2+1, 0])
			cylinder(r=tunerrad, h=carriage_thick*2, center=true);
	}
	for (i=[-1, 1])
		translate([i*(carriage_width-38)/2, -21/2+1-8, 0])
			cylinder(r=1.25, h=carriage_thick*2, center=true);
}


module lmxuu_bearing_holder() {
	rotate([0, 0, 90])
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





$fn = 50;
m5rad = 3;
m5nutrad = 4.7;
m3rad = 1.9;
thick = 6;
motorwidth = 44;
motorholesep = 30.5;
dim = 20;

offset1 = [10, 30, 0];
offset2 = [30, 50, 0];

module motorplate() {
	difference() {
		union() {
			hull() {
				cube([motorwidth, motorwidth, thick], true);
				translate(offset2 + [2, 2, 0])
					cylinder(r=8, h=thick, center=true);
				translate([0, -dim/2-motorwidth/2+0.1, 0])
					cube([motorwidth, dim, thick], true);
			}
			translate(offset1 + [0, 0, thick/2]) 
				cylinder(r=m5rad+4, h=thick*2, center=true);
			translate(offset2 + [0, 0, thick/2])
				cylinder(r=m5rad+4, h=thick*2, center=true);
		}
		cylinder(r=23/2, h=thick*2, center=true);
		for (i=[-1, 1], j=[-1, 1])
			translate([i*motorholesep/2, j*motorholesep/2, 0])
				cylinder(r=m3rad, h=thick*2, center=true);

		translate(offset1) {
			cylinder(r=m5rad, h=thick*4, center=true);
			translate([0, 0, thick*1.5-1.49])
				cylinder(r=m5nutrad, h=3, center=true, $fn=6);
		}
		translate(offset2) {
			cylinder(r=m5rad, h=thick*4, center=true);
			translate([0, 0, thick*1.5-1.49])
				cylinder(r=m5nutrad, h=3, center=true, $fn=6);
		}
		

		for (i=[-1, 1])
			translate([i*10, -dim/2-motorwidth/2, 0])
				cylinder(r=m5rad, h=thick*2, center=true);

	}
}

motorplate();


	
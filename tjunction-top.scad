$fn = 50;

dimh = 20.4;
dimv = 20.5;
len = 50;
wall = 3;

m5rad = 3;

junction();
*translate([5, dimh+10, 0]) mirror() junction();

module junction() {
	union() {
		p1();
		translate([-len/2-dimh/2-wall, 0, 0])
			p2();
	}
}

module p1() {
	translate([0, 0, (dimv+wall)/2])
	difference() {
		cube([len, dimh+wall, dimv+wall], true);
		translate([0, wall/2, wall/2])
			cube([len+1, dimh+0.1, dimv+0.1], true);
		for (i=[-1, 1])
			translate([i*len/4, 0, wall/2])
				rotate([90, 0, 0])
					cylinder(r=m5rad, h=dimh*2, center=true);
	}
}

module p2() {
	translate([0, 0, (dimv+wall*2)/2])
	difference() {
		cube([dimh+wall*2, len, dimv+wall*2], true);
		translate([0, 0, 0])
			cube([dimh, len+1, dimv], true);
		for (i=[-1, 1])
			translate([-dimh/2, i*len/4, 0])
				rotate([0, 90, 0])
					cylinder(r=m5rad, h=dimh, center=true);
		translate([dimh/2, len/3, 0])
			rotate([0, 90, 0])
				cylinder(r=m5rad, h=dimh, center=true);
	}
}
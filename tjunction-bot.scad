$fn=50;

dimh = 20.4;
dimv = 20.5;

len = 50;
wall = 3;
m5rad = 3;

union() {
	p1();
	translate([-len/2-dimh/2-wall, 0, 0])
		p2();
}

module p1() {
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
	difference() {
		cube([dimh+wall*2, len, dimv+wall], true);
		translate([0, 0, wall/2])
			cube([dimh, len+1, dimv+0.1], true);
		for (i=[-1, 1])
			translate([0, i*len/2.8, wall/2])
				rotate([0, 90, 0])
					cylinder(r=m5rad, h=dimh*2, center=true);
	}
}
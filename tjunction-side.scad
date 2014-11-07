$fn = 50;

dimh = 20.4;
dimv = 20.5;
wall = 3;

m5rad = 3;

len = 50;

for (i=[-1, 1])
	translate([0, i*(dimh), 0])
		junction();

module junction() {
	difference() {
		union() {
			cube([len*2+wall, dimh+wall*2, dimv+wall*2], true);
			translate([0, 0, dimv/2+wall+len/4])
				cube([dimh+wall*2, dimh+wall*2, len/2], true);
		}
		for (i=[-1, 1])
			translate([i*(len/2+wall/2), 0, 0])
				cube([len+0.05, dimh, dimv], true);
		translate([0, 0, dimv/2+wall+len/4])
			cube([dimh, dimh, len/2+0.1], true);
	
		for (i=[-43, -23, 23, 43])
			translate([i, 0, 0])
				rotate([90, 0, 0])
					cylinder(r=m5rad, h=dimv*2, center=true);
		translate([0, 0, dimv/2+wall+len/4])
			rotate([90, 0, 0])
				cylinder(r=m5rad, h=dimh*2, center=true);
	}
}

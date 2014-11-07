clamp();
translate([0, -30, 0]) mirror([0,1,0]) clamp();


module clamp() {
	difference() {
		union() {
			cylinder(r=10, h=20, center=true, $fn=50);
			translate([0, -10+3, 0])
				cube([50, 6, 20], true);
			translate([-12.5, 0, 0])
				cube([25, 20, 20], true);
		}
		cylinder(r=5.1, h=21, center=true, $fn=50);
		translate([-12.6, 0, 0])
			cube([25, 2, 21], true);
		for (i=[-1, 1])
			translate([i*17, 0, 0])
				rotate([90, 0, 0])
					cylinder(r=3, h=40, center=true, $fn=30);
		translate([-17, 10-1.5+0.1, 0])
			rotate([90, 0, 0])
				cylinder(r=5, h=3, center=true, $fn=30);
	}
}

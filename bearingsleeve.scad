bearingrad = 9.7;
bearinglength = 30;

wall = 3;
base = 7;

gap = wall+13;

$fn=50;

for (k=[-1, 1])
translate([k*20, 0, 0])
difference() {
	bearingsleeve();
	for (i=[-1, 1], j=[-8, 8])
		translate([0, 0, i*45/2+j])
			rotate([90, 0, 0]) {
				cylinder(r=1.9, h=(bearingrad+wall+base)*2+1, center=true);
				translate([0, 0, -base])
					cylinder(r=3.3, h=(bearingrad+wall+base)*2, center=true);
			}
}

module bearingsleeve() {
	union() {
		difference() {
			union() {
				cylinder(r=bearingrad+wall, h=bearinglength*2+wall+gap, center=true);
				translate([0, bearingrad*0.9, 0])
					cube([(bearingrad+wall)*2, bearingrad*1.8, bearinglength*2+wall+gap], true);
				translate([0, bearingrad*1.3, 0])
					cube([(bearingrad+wall*2)*2, bearingrad, bearinglength*2+wall+gap], true);
				translate([0, -(bearingrad+base+wall)/2, 0])
					cube([(bearingrad+wall)*2, bearingrad+wall+base, bearinglength*2+wall+gap], true);
		
			}
			cylinder(r=bearingrad, h=bearinglength*2+wall+gap+1, center=true);
			translate([0, bearingrad+0.1, 0])
				cube([bearingrad*2-0.5, bearingrad*2, bearinglength*2+wall+gap+1], true);
			for (i=[-1, 1])
				translate([0, bearingrad+2.5, i*(bearinglength/2+wall/2+gap/2)])
					rotate([0, 90, 0]) {
						cylinder(r=1.8, h=bearingrad*4, center=true);
						translate([0,0,-(bearingrad+wall*1.75+0.1)])
							cylinder(r=3.3, h=wall/2, center=true, $fn=6);
					}
		}
		translate([0, -bearingrad, 0])
			cube([bearingrad*2, wall, gap], true);
		for (i=[-1, 1])
			translate([0, -bearingrad, i*(bearinglength+gap/2+wall/4)])
				cube([bearingrad*2, wall, wall/2], true);
	}
}


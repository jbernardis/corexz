$fn = 30;

m5rad = 3;
dimh = 20.3;
dimv = 20.4;

sidelen = 25;
frontlen = 25;
wall = 3;

for (i=[-1, 1], j=[-1, 1])
	translate([i*20, j*30, 0])
		if (j == 1)
			corner();
		else
			mirror() corner();


module corner() {
	difference() {
		union() {
			cube([frontlen+wall, dimh+wall*2, dimv+wall], true);
			translate([(dimh+wall*2)/2-(frontlen+wall)/2, (sidelen)/2+dimh/2+wall, 0])
				cube([dimh+wall*2, sidelen, dimv+wall], true);
		}
		translate([wall/2+0.01, 0, wall/2+0.01])
			cube([frontlen, dimh, dimv], true);
		translate([(dimh+wall*2)/2-(frontlen+wall)/2, (sidelen)/2+dimh/2+wall, wall/2+0.01])
				cube([dimh, sidelen+0.01, dimv], true);
		translate([0, 0, wall/2])
			rotate([90, 0, 0])
				cylinder(r=m5rad, h=dimh);
	
		translate([0, (sidelen)/2+dimh/2+wall, wall/2])
			rotate([0, 90, 0])
				cylinder(r=m5rad, h=2*dimh, center=true);
	}
}
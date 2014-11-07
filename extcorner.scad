$fn = 50;

capheight = 6;
capdiam = 8.6;

requiredspace = capdiam + 4;

m5rad = 3;

extralengthh = 14;
extralengthv = 0;

lengthh = capheight*2 + capdiam + 2 + extralengthh;
lengthv = capheight*2 + capdiam + 2 + extralengthv;
dim = 20;

holesv = [0];
holesh = [-8, 8];

wall = 4;

translate([0, -15, ])
	corner();

translate([0, 15, ])
	doublecorner();

module doublecorner() {
	difference() {
		union() {
			corner();
			translate([51.9-wall*2, 0, 0]) rotate([0, 0, 180]) corner();
		}
		for (i=[-1, 1])
			translate([(51.9-wall*2)/2+i*10, 0, 0])
				cylinder(r=m5rad, h=10, center=true);
	}
}


module corner() {
	union() {
		tab(lengthh, holesh);
		rotate([0, -90, 0])
			translate([0, 0, wall])
				tab(lengthv, holesv);
		for (i=[-1, 1])
			translate([0, i*(dim/2-min(wall, (dim-requiredspace)/2)/2), 0])
				wing(min(lengthh, lengthv));
	}
}

module tab(llen, hl) {
	translate([llen/2, 0, -wall/2])
	union() {
		difference() {
			cube([llen, dim, wall], true);
			for (i=hl)
				translate([i, 0, 0])
					cylinder(r=m5rad, h=wall*2, center=true);
		}
		translate([-llen/2-wall/2, 0, 0])
			cube([wall, dim, wall], true);
	}
}

module wing(llen) {
	translate([llen/2, 0, llen/2])
	difference() {
		cube([llen, min(wall, (dim-requiredspace)/2), llen], true);
		rotate([0, -45, 0])
			translate([llen/2, 0, 0])
				cube([llen, wall+1, llen*2], true);
	}
}
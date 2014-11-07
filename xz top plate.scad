$fn=50;

m5rad = 3;
m5nutrad = 4.7;
thick = 6;
pulleysep = 40;
dim = 20;
rad = 10;

plate();

translate([0, -45, 0]) plate();

module plate() {
	difference() {
		union() {
			cube([pulleysep, dim, thick], true);
			hull() {
				for (i=[-1, 1])
					translate([i*pulleysep/2, dim, 0])
						cylinder(r=rad, h=thick, center=true);
			}
			for (i=[-1, 1])
				translate([i*pulleysep/2, dim, thick])
					cylinder(r=m5nutrad+2, h=thick, center=true);
		}
		for (i=[-1, 1]) {
			translate([i*(pulleysep-15)/2, 0, 0])
				cylinder(r=m5rad, h=thick+1, center=true);
			translate([i*pulleysep/2, dim, 0]) {
				cylinder(r=m5rad, h=thick*4, center=true);
				translate([0, 0, thick*1.5-1.99])
					cylinder(r=m5nutrad, h=4, center=true, $fn=6);
			}
		}
	}
}

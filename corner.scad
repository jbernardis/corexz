dim = 20.4;
thick = 3;

len1 = 30;
len2 = 30;
len3 = 20;

mirror()
difference() {
	union() {
		cube([len1+thick, dim+thick*2, dim+thick*2], true);
		translate([-len1/2+dim/2+thick*0.5, -len2/2-dim/2-thick, 0])
			cube([dim+thick*2, len2, dim+thick*2], true);
		translate([dim/2-len1/2+thick*0.5, 0, dim+thick-0.3])
			cube([dim+thick*2, dim+thick*2, len3], true);
	}

	translate([thick, 0, 0])
		cube([len1+thick, dim, dim], true);
	translate([-len1/2+dim/2+thick*0.5, -len2/2-thick/2-dim/2-thick, 0])
		cube([dim, len2+thick, dim], true);
	translate([dim/2-len1/2+thick*0.5, 0, dim+thick+thick/2])
		cube([dim, dim, len3+thick], true);

	translate([0, 25, 0])
		rotate([90, 0, 0])
			cylinder(r=3, h=50, center=true, $fn=30);
	translate([0, 0, dim+thick])
		rotate([0, 90, 0])
			cylinder(r=3, h=50, center=true, $fn=30);
	translate([0, -dim/2-thick-len2/2, 0])
		rotate([0, 90, 0])
			cylinder(r=3, h=50, center=true, $fn=30);
}

$fn = 50;
grubflangethick = 7;
flangethick = 4;
flangerad = 14.5;
spoollength = 20;
spoolrad = 11;

m3rad = 1.9;
m3nutrad = 3.2;
m3nutdepth = 4;
m3nuth = 2.5;
m3nutw = 5.7;

shaftrad = 5.25/2;

stringholerad = 1.25;

for (i=[-1, 1])
	translate([i*16, 0, 0])
		spool();

//segment(1, 1, 0, 1);

module spool() {
	translate([0, 32, 1.5])
		segment(1, 1, 0, 1);
	translate([0, -32, 0])
		segment(0, 1, 1, 0);
}

module segment(grub=0, notch=0, flangeonly=0, nuttraps=0) {
	union() {
		difference() {
			union() {
				if (grub == 1) {
					cylinder(r=flangerad, h=grubflangethick, center=true);
					if (flangeonly == 0) {
						translate([0, 0, (spoollength+grubflangethick)/2])
							cylinder(r=spoolrad, h=spoollength, center=true);
					}
				} else {
					cylinder(r=flangerad, h=flangethick, center=true);
					if (flangeonly == 0) {
						translate([0, 0, (spoollength+flangethick)/2])
							cylinder(r=spoolrad, h=spoollength, center=true);
					}
				}

			}
			for (i=[-1, 1])
				translate([i*5, i*5, 0]) {
					cylinder(r=m3rad, h=spoollength*3, center=true);
					if (nuttraps == 1) {
						translate([0, 0, -(grubflangethick-m3nutdepth+0.01)/2])
							cylinder(r=m3nutrad, h=m3nutdepth, center=true, $fn=6);
					}
				}
			cylinder(r=shaftrad, h=spoollength*3, center=true);
			translate([8, 0, 0])
				cylinder(r=stringholerad, h=spoollength*3, center=true);
			if (grub == 1) {
				rotate([0, 0, 225]) {
					rotate([90, 0, 0])
						cylinder(r=m3rad, h=flangerad+2);
					translate([0, -5, 0])
						cube([m3nutw, m3nuth, 8], true);
				}
			}
			if (notch == 1) {
				translate([spoolrad+stringholerad, 0, 0])
					cylinder(r=stringholerad, h=grubflangethick*3, center=true);
			}
		}
		if (nuttraps == 1) {
			for (i=[-1, 1])
				translate([i*5, i*5, -grubflangethick/2+m3nutdepth+0.12]) 
					color("red") cylinder(r=m3nutrad+0.5, h=0.25, center=true);
		}
	}
}

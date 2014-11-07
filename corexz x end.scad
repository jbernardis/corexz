$fn = 50;
block_thick = 20;
bar_sep = 70;
bar_rad = 5.1;
pad = block_thick/2-bar_rad;;
pulley_vsep = bar_sep - 25;
pulley_hsep = 40;
block_width = pulley_hsep*2-22;

m3rad = 1.9;
m3nut = 3.2;
m5rad = 3;
m5nutrad = 4.7;


//xend(0);
xend(1);

module xend(endstop=0) {
	union() {
		difference() {
			union() {
				translate([-4, 0, 0])
					cube([block_width, bar_sep + bar_rad*2 + pad*2, bar_rad*2 + pad*2], true);
				if (endstop == 1) {
					translate([block_width/2-5-4, (bar_sep+bar_rad*2+pad*2)/2, 0])
						cube([10, 10, bar_rad*2 + pad*2], true);
				}
			}
			for (i=[-1, 1]) {
				translate([18, i*bar_sep/2, 0])
					rotate([0, 0, 0])
						teardropcentering(bar_rad, block_width+1, 45);
			}
			for (i=[-1, 1]) {
				translate([-2, i*(bar_sep/2), 0])
					union() {
						cube([pulley_hsep/2, 2*(pad+bar_rad*4), 2], true);
						for (j=[-1, 1])
							translate([j*(pulley_hsep/4-1), 0, -10])
								cube([2, 2*(pad+bar_rad*4), 20], true);
					}
			}
			for (i=[-pulley_hsep/2, 0, pulley_hsep/2], j=[-1, 1]) 
				translate([i-2, j*pulley_vsep/2, 4.5]) {
					cylinder(r=m5rad, h=bar_rad*2 + pad*2, center=true);
					translate([0, 0, -(bar_rad*2 + pad*2)-0.25])
						cylinder(r=m5nutrad, h=bar_rad*2 + pad*2, center=true, $fn=6);
				}
			for (i=[-1, 1])
				translate([-block_width/2-4, i*pulley_vsep/2, 0])
					bearingmount();
			translate([block_width/2-20/2+0.1, 0, 0])
				cube([20, pulley_vsep-11, block_thick+1], true);
			if (endstop == 1) {
				translate([block_width/2-5-4, (bar_sep+bar_rad*2+pad*2)/2, 0])
					cylinder(r=1.9, h=30, center=true, $fn=30);
			}

		}
		for (i=[-1, 1]) {
			translate([0, i*pulley_vsep/2, 1.125]) 
				cylinder(r=m5rad+3, h=0.25, center=true);
		}
	}
}


module bearingmount() {
	for (ii=[-8, 8])
		translate([0, ii, 0]) {
			rotate([0, 90, 0])
				cylinder(r=m3rad, h=34, center=true);
			translate([10, 0, 0])
				cube([2.5, 5.7, block_thick*2], true);
		}
}

module teardropcentering (r=4.5,h=20,alpha=45) {	
	centering_offset_factor = 1.1;
	render()
	translate([-h/2,0,0])
		rotate([-270,0,90])
			difference(){
				linear_extrude(height=h){
					circle(r, $fn=24);
					polygon(points=[[0,0],[r*cos(alpha),r*sin(alpha)],[0,r/sin(alpha)],[-r*cos(alpha),r*sin(alpha)]], paths=[[0,1,2,3]]);
				}
				translate([0,(r/sin(alpha))/2+r*centering_offset_factor,h/2]) cube([2*r+2,r/sin(alpha),h+2],center=true);
			}
}

*difference() {
	cube([20, 30, 20], true);
	translate([0, -5, 0]) teardropcentering(5.1, 30);
	translate([0, 7, 0]) {
		cylinder(r=3, h=21, center=true);
		translate([0, 0, 17])
			cylinder(r=4.7, h=20, center=true, $fn=6);
	}
	*translate([0, -12, 0]) {
		cube([5.7, 2.5, 25], true);
		rotate([90, 0, 0])
			cylinder(r=1.9, h=20, center=true);
	}
}


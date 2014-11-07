spreadx = 45;
spready = 35;
thick = 6;
r608 = 11;
h608 = 7;

m3rad = 1.9;
m5rad = 3;
m5nutrad = 4.7;
m8rad = 4.4;
nema17holerad = 13;
nema17mountspread = 31/2;

dimv = 20.5;

translate([40, 0, 0]) top();
translate([-40, 0 , 0]) mirror() bottom();

//*** Test Piece
//intersection() {
//	bottom();
//	translate([0, 0, 1.51]) cube([400, 400, 3], true);
//}


module top() {
	difference() {
		plate();
	
		for (i=[-1, 1], j=[-1, 1])
			translate([i*spreadx/2, j*spready/2, 0])
				cylinder(r=m8rad, h=(thick+h608)*2, $fn=50, center=true);	
	}
}

module bottom() {
	difference() {
		union() {
			plate();
			translate([0, -spready/2-r608-dimv/2-2, 0])
				cube([spreadx, dimv, thick], true);

			translate([7, spready/2+r608+38, 0])
				hull() {
					cylinder(r=10, h=thick, center=true, $fn=50);
					translate([-32.5, -25.5, 0])
						cylinder(r=10, h=thick, center=true, $fn=50);
					translate([0, -35, 0])
						cylinder(r=10, h=thick, center=true, $fn=50);
				}
					
			*translate([0, spready/2+r608+33, thick/2]) {
				translate([0, 0, 0])
					cylinder(r=m5rad+4, h=thick, center=true, $fn=50);
				translate([-20, -20, 0])
					cylinder(r=m5rad+4, h=thick, center=true, $fn=50);
			}
			translate([-spreadx/2-r608-2+6, spready/2+10, 0])
				cube([12, 28, thick], true);
			
		}
	
		for (i=[-1, 1], j=[-1, 1])
			translate([i*spreadx/2, j*spready/2, 0]) 
				cylinder(r=m8rad, h=(thick+h608)*2, $fn=50, center=true);

		cylinder(r=nema17holerad, h=thick+1, center=true, $fn=30);
		rotate([0, 0, 45])
			for (i=[-1, 1], j=[-1, 1])
				translate([i*nema17mountspread, j*nema17mountspread, 0]) 
					cylinder(r=1.9, h=thick+1, center=true, $fn=30);

		for (i=[-1, 1]) 
			translate([i*spreadx/4, -spready/2-r608-dimv/2-2, 0])
				cylinder(r=m5rad, h=thick+1, center=true, $fn=30);

		translate([7, spready/2+r608+38, 0]) {
			cylinder(r=m5rad, h=thick*3, center=true, $fn=50);
			translate([-20, -20, 0])
				cylinder(r=m5rad, h=thick*3, center=true, $fn=50);
		}

	}
}

module plate() {
	union() {
		translate([0, 0, -3])
		for (i=[-1, 1], j=[-1, 1])
			translate([i*spreadx/2, j*spready/2, (j+1)*h608/4+h608/2])
				cylinder(r1=r608, r2=r608-5, h=h608, $fn=50, center=true);
		hull()
			for (i=[-1, 1], j=[-1, 1])
				translate([i*(spreadx/2+2), j*(spready/2+2), 0])
					cylinder(r=r608, h=thick, $fn=50, center=true);
	}
}
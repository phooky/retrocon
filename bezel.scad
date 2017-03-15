module washer(location = [0,0,0]) {
    ID = 7.8;
    OD = 16.5;
    thickness = 5;
    translate(location)
    color("green") difference() {
       cylinder(d=OD,h=thickness);
       translate([0,0,-0.1]) cylinder(d=ID,h=thickness+0.2); 
    }
}

module hole(location = [0,0,0]) {
    ID = 8;
    translate(location)
    color("purple",0.5) cylinder(d=ID,h=50,center=true);
}

module hole_stack(location = [0,0,0]) {
    translate(location) {
        washer([0,0,-5]);
        hole();
        washer([0,0,1.9]);
    }
}

module hole_cut(location = [0,0,0], rot=0) {
    OD=18;
    
    translate(location) {
        translate([0,0,-5]) cylinder(d=OD,h=31);
        rotate([0,0,1],a=45+rot) translate([0,-OD/2,-0.5]) cube([30,OD,20]);
    }
}

horiz_hole_dist = 211;
vert_hole_dist = 160;
h2 = horiz_hole_dist/2; v2 = vert_hole_dist/2;

hole_locations = [ [-h2,-v2,0], [-h2,v2,0], [h2,-v2, 0], [h2, v2, 0] ];

module screen() {
    radius=874.8;
    slice_height=50;
    color("orange",0.2)
    translate() 
    intersection() {
        translate([0,0,radius])
        rotate(v=[0,1,0],a=90)
        sphere(r=radius,$fn=150);
        cube([222,172,slice_height*2],center=true);
    }
}

module frustrum_2d() {
    w = 190;
    h = 140;
    chamfer = 10;
    translate([-w/2 + chamfer,-h/2 + chamfer,0]) circle(r=chamfer);
    translate([-w/2 + chamfer,h/2 - chamfer,0]) circle(r=chamfer);
    translate([w/2 - chamfer,-h/2 + chamfer,0]) circle(r=chamfer);
    translate([w/2 - chamfer,h/2 - chamfer,0]) circle(r=chamfer);
    square([w,h-2*chamfer],center=true);
    square([w-2*chamfer,h],center=true);
}

module frustrum() {
    translate([0,0,-10]) linear_extrude(height=20) frustrum_2d();
    rotate(v=[0,1,0],a=180)
    linear_extrude(height=10,scale=1.3) frustrum_2d();
}


//frustrum();


difference()
{
    translate([0,0,-3])
        cube([230,180,19],center=true);
    hole_cut(hole_locations[0]);
    hole_cut(hole_locations[1],-90);
    hole_cut(hole_locations[2],90);
    hole_cut(hole_locations[3],180);
    translate([0,0,-7]) screen();
    translate([0,0,-8]) frustrum();
}

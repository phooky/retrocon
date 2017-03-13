module washer(location = [0,0,0]) {
    ID = 8;
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
        sphere(r=radius,$fn=100);
        cube([240,190,slice_height*2],center=true);
    }
}

module frustrum() {
}


difference()
{
    translate([0,0,-3])
        cube([230,180,19],center=true);
    for( where = hole_locations ) {
        hole_stack(where);
    }
    translate([0,0,-5.4]) screen();
    frustrum();
}

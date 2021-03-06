//
// DragonFrame Motor Unit box
//

$fn=50;

drawTop=0;
drawBottom=0;
drawAll=0;
drawBridgePart=0;

//----------------------------

module rounded_rect(x, y, z, radius) {
    linear_extrude(height=z)
        minkowski() {
            square([x,y]);
            circle(r = radius);
        }
}

module mount(dia,thick) {
    difference() {
        cylinder(h=thick,d1=dia+4,d2=dia+2);
        translate([0,0,-1]) cylinder(h=thick+2,d=dia);
    }
}

module box_mount(thick,hole) {
    difference() {
    union() {
        cube([4,2,thick]);
        cube([2,4,thick]);
        translate([2,2,0]) cylinder(h=thick,d=4);
    }
    translate([1.5+0.01,1.5+0.01,-1]) cylinder(h=thick+2,d=hole);// Fold Bug
    }
}

module lip_lock_top() {
    rounded_rect(bottomX,bottomY,1,bottomThick/2+0.125);
}

module lip_lock_bottom() {
    difference() {
        rounded_rect(bottomX,bottomY,1,bottomThick);
        rounded_rect(bottomX,bottomY,1,bottomThick/2-0.125);
    }
}

module bridge() {
    difference() {
        cube([5,18,7]);
        translate([-1,9,7]) rotate([0,90,0]) cylinder(h=7,d=8);
        translate([2.5,2.5,3]) cylinder(h=5,d=2);
        translate([2.5,15.5,3]) cylinder(h=5,d=2);
    }
}

module bridge_motor() {
    difference() {
        cube([5,15,5]);
        translate([-1,5,3.5]) cube([7,5,2]);
        translate([2.5,2.5,1]) cylinder(h=5,d=2);
        translate([2.5,12.5,1]) cylinder(h=5,d=2);
    }
}

module bridge_part() {
    difference() {
        cube([5,18,3]);
        translate([-1,9,5.5]) rotate([0,90,0]) cylinder(h=7,d=8);
        translate([2.5,2.5,-1]) cylinder(h=5,d=2);
        translate([2.5,15.5,-1]) cylinder(h=5,d=2);
    }
    translate([10,0,0])
    difference() {
        cube([5,15,2]);
        translate([2.5,2.5,-1]) cylinder(h=5,d=2);
        translate([2.5,12.5,-1]) cylinder(h=5,d=2);
    }
}

module wall() {
    difference() {
        union() {
            cube([5,10,4]);
            translate([5,5,0]) cylinder(h=4,d=10);
        }
        translate([5,5,-1]) cylinder(h=6,d=3.5);
        translate([5,5,3])
        difference() {
            cylinder(h=1,d1=3.5,d2=5);
            cylinder(h=1,d=3.5);
        }
    }
}

module driver() {
    driverX=32;
    driverY=38;
    driverZ=1.3;
    difference() {
        color("darkgreen")
        translate([0,0,0]) cube([driverX,driverY,driverZ]);    
        translate([driverX/2,4.25,-1]) cylinder(h=driverZ+2,d=3);// Mount hole
        translate([driverX/2,driverY-4.25,-1]) cylinder(h=driverZ+2,d=3);
    }
    color("black") {
        translate([0,driverY/4,driverZ]) cube([6.6,22,8.4]);// Header M/PWR
        translate([driverX-6.6,driverY-11-driverY/8,driverZ]) cube([6.6,11,8.4]);// Header
    }
    color("silver")
    translate([driverX-20,driverY-8,driverZ]) cylinder(h=5.5,d=6);// Header
}

module uno() {
    unoX=53.3;
    unoY=68.6;
    unoZ=1.6;
    difference() {
        color("darkgreen")
        translate([0,0,0]) cube([unoX,unoY,unoZ]);    
        translate([unoX-2.5-5.1-27.9-15.2,14+1.3,-1]) cylinder(h=unoZ+2,d=3);// Mount Hole
        translate([unoX-2.5-5.1-27.9,14+1.3+50.8,-1]) cylinder(h=unoZ+2,d=3);
        translate([unoX-2.5-5.1,14+1.3+50.8,-1]) cylinder(h=unoZ+2,d=3);
        translate([unoX-2.5,14,-1]) cylinder(h=unoZ+2,d=3);
    }
    color("black") {
        translate([9.6-0.5,-6.2,unoZ-0.5]) cube([12+1,15,10.9+1]);// USB-B
        translate([unoX-2.5-5.1-27.9-15.2-2.54/2,25,unoZ]) cube([2.54,40,10]);// Header
        translate([unoX-2.5-2.54/2,35,unoZ]) cube([2.54,30,10]);
    }
}

module supply() {
    supplyX=51;
    supplyY=78;
    supplyZ=28;
    color("silver")
    translate([0,0,0]) cube([supplyX,supplyY,supplyZ]);
    color("black")
    translate([0,supplyY,supplyZ/4]) cube([51,14,14]);// Header
}

bottomX=65+2;
bottomY=125;
bottomZ=35;
bottomThick=2;

module bottom() {
    difference() {
        union() {
        difference() {
        translate([0,0,0]) rounded_rect(bottomX,bottomY,bottomZ+1,bottomThick);// BASE
        translate([0,0,bottomThick]) cube([bottomX,bottomY,bottomZ]);// FILL
        }
        translate([25.4+1,10.5+10,bottomThick]) cylinder(h=1,r1=3,r2=2);// Supply mount - bottom
        translate([25.4+1,10.5+55+10,bottomThick]) cylinder(h=1,r1=3,r2=2);
        }
        translate([-2,2.75+10,14+bottomThick+1]) rotate([0,90,0]) cylinder(h=4,d=3);
        translate([-2,2.75+66.5+10,14+bottomThick+1]) rotate([0,90,0]) cylinder(h=4,d=3);        
        translate([37,bottomY+2,bottomThick+7]) rotate([90,0,0]) cylinder(h=4,d=8);// Supply Hole
        translate([53,bottomY+2,bottomThick+3.5]) rotate([90,0,0]) cube([5,2.85,4]);// Motor Hole
        translate([0,0,bottomZ]) lip_lock_bottom();// Lip Lock
        translate([53.3+(topX-53.3)/2,6.2-bottomThick,bottomZ+topZ-topThick-3]) rotate([180,0,180]) uno();// Uno Cut
        translate([-bottomThick-0.1,2.75+10,14+bottomThick+1]) rotate([0,90,0]) cylinder(h=1.1,d1=5.5,d2=3);// Supply Sink
        translate([-bottomThick-0.1,2.75+66.5+10,14+bottomThick+1]) rotate([0,90,0]) cylinder(h=1.1,d1=5.5,d2=3);
    }
    translate([0-0.01,2.75+10,14+bottomThick+1]) rotate([0,90,0]) mount(3,1);// Supply mount - side
    translate([0-0.01,2.75+66.5+10,14+bottomThick+1]) rotate([0,90,0]) mount(3,1);
    translate([bottomX,60+4.25,16+bottomThick+9]) rotate([0,90,180]) mount(2,3);// Driver mount
    translate([bottomX,60+38-4.25,16+bottomThick+9]) rotate([0,90,180]) mount(2,3);
    translate([46,bottomY-12,bottomThick]) rotate([0,0,90]) bridge();// Supply Bridge
    translate([63,bottomY-12,bottomThick]) rotate([0,0,90]) bridge_motor();// Motor Bridge
    translate([0,0,2]) box_mount(bottomZ-1,2);// Bottom mount
    translate([bottomX,0,2]) rotate([0,0,90]) box_mount(bottomZ-1,2);
    translate([bottomX,bottomY,2]) rotate([0,0,180]) box_mount(bottomZ-1,2);
    translate([0-0.01,bottomY+0.01,2]) rotate([0,0,270]) box_mount(bottomZ-1,2);// NF Bug
    translate([bottomX+1,5,0]) wall();//Wall Mount
    translate([bottomX+1,bottomY-15,0]) wall();
    translate([-1,15,0]) rotate([0,0,180]) wall();
    translate([-1,bottomY-5,0]) rotate([0,0,180]) wall();
}

topX=65+2;
topY=125;
topZ=17.5;
topThick=2;
topUnoXOffset=(topX-53.3)/2;

module top() {
    difference() {
        translate([0,0,0]) rounded_rect(topX,topY,topZ,topThick);// BASE
        translate([0,0,-topThick]) cube([topX,topY,topZ]);// FILL
        translate([53.3+(topX-53.3)/2,6.2-topThick,topZ-topThick-3]) rotate([180,0,180]) uno();// Uno
        translate([1.5,1.5,topZ-3]) cylinder(h=topThick+2,d=3);//Top Mount Hole
        translate([topX-1.5,1.5,topZ-3]) cylinder(h=topThick+2,d=3);
        translate([1.5,topY-1.5,topZ-3]) cylinder(h=topThick+2,d=3);
        translate([topX-1.5,topY-1.5,topZ-3]) cylinder(h=topThick+2,d=3);
        for (vspace=[1:4])// Vent
            translate([topX/8,topY-10*vspace,topZ-topThick-1])rounded_rect(topX/8*6,1,topThick+2,1);
        translate(0,0,0) lip_lock_top();// Lip Lock
        translate([1.5,1.5,topZ-1]) cylinder(h=1,d1=3,d2=5.5);// Top Sink
        translate([topX-1.5,1.5,topZ-1]) cylinder(h=1,d1=3,d2=5.5);
        translate([1.5,topY-1.5,topZ-1]) cylinder(h=1,d1=3,d2=5.5);
        translate([topX-1.5,topY-1.5,topZ-1]) cylinder(h=1,d1=3,d2=5.5);
    }
    translate([2.5+topUnoXOffset,14+6.2-topThick,topZ-topThick]) rotate([0,180,0]) mount(2,3);// Uno Mount
    translate([2.5+5.1+topUnoXOffset,14+1.3+50.8+6.2-topThick,topZ-topThick]) rotate([0,180,0]) mount(2,3);
    translate([2.5+5.1+27.9+topUnoXOffset,14+1.3+50.8+6.2-topThick,topZ-topThick]) rotate([0,180,0]) mount(2,3);
    translate([2.5+5.1+27.9+15.2+topUnoXOffset,14+1.3+6.2-topThick,topZ-topThick]) rotate([0,180,0]) mount(2,3);
    translate([0,0,1]) box_mount(topZ-3,3);// Top Mount
    translate([topX,0,1]) rotate([0,0,90]) box_mount(topZ-3,3);
    translate([0,topY,1]) rotate([0,0,270]) box_mount(topZ-3,3);
    translate([topX+0.01,topY+0.02,1]) rotate([0,0,180]) box_mount(topZ-3,3);// strange bug?
}

//--------------------------

if (drawTop) {
    translate([topX+topThick,topThick,topZ]) rotate([0,180,0]) top();
}

if (drawBottom) {
    translate([bottomThick+9,bottomThick,0]) bottom();
}

if (drawBridgePart) {
    bridge_part();
}

if (drawAll) {
    bottom();
    translate([1,10,bottomThick+1]) supply();
    translate([bottomX-3,60,bottomThick+9]) rotate([0,0,0]) rotate([0,-90,0]) driver();
    translate([53.3+(topX-53.3)/2,6.2-bottomThick,bottomZ+topZ-topThick-3]) rotate([180,0,180]) uno();
    translate([0,0,bottomZ]) top();
}

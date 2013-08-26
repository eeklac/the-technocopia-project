$fn=50;
use <../Vitamins/Electronics/Hot_Ends/PrintrBotJHeadHotEnd_Vitamin.scad>;
use <../Vitamins/Actuators/StandardServo/StandardServo_Vitamin.scad>;
use <../Vitamins/Actuators/StandardServo/Servo_Connector_Vitamin.scad>;
use <../Vitamins/Fasteners/Screws/High_Low_Screw_Vitamin.scad>;
use <../Vitamins/Structural/SealedBearings/SealedBearing608_Vitamin.scad>;
use <../Vitamins/Sensors/Encoders/Encoder_Vitamin.scad>;
use <../Vitamins/Sensors/Encoders/EncoderMagnet_Vitamin.scad>;
use <../Vitamins/Tools/Standard_Extruder_Spacing_Vitamin.scad>;
use <../Vitamins/Tools/Filament_Vitamin.scad>;
use <ExtruderIdlerWheel.scad>;

//core dimensions of the part depend on the screw, servo, and servo connector.  Width is based on the standard platform fastener distance.  Parameterize when possible.

function ExtruderLength(3dPrinterTolerance=.4) = StandardServoLength(3dPrinterTolerance)+HiLoScrewLength(3dPrinterTolerance)/2+2*ConnectorLength(3dPrinterTolerance);
function ExtruderHeight(3dPrinterTolerance=.4) = HiLoScrewLength(3dPrinterTolerance)/2;
function ExtruderWidth(3dPrinterTolerance=.4) = StandardExtruderSpacing()+HotEndDiam(3dPrinterTolerance);

function CounterboreRad(3dPrinterTolerance=.4) = HiLoScrewHeadDiameter(3dPrinterTolerance)/2+.5;

//Creating the basic extruder block
module ExtruderBlock()
{
	cube([ExtruderLength(),ExtruderWidth(),ExtruderHeight()]);
}
//counterbore screw module:
module CounterboreScrew(3dPrinterTolerance=.4){
	union(){
		cylinder(h=HiLoScrewLength()/4, r=CounterboreRad(.4));
		rotate([0,180,0]){HiLoScrew();}
	}
}	
//ExtruderBlock(.4);

//Removing feature elements from block. The boolean creates either a servo side or an encoder side.

module Extruder(servo=true, 3dPrinterTolerance=.4)
{
	if(servo==true){
		difference(){
			translate([-ExtruderLength()/2,-ExtruderWidth()/1.8,0]){ExtruderBlock(.4);}
		//the hot end:
			translate([ExtruderWidth()/2,0,ExtruderHeight()]){rotate([0,90,0]){HotEnd(true,.4);}}
		//the servo:
			translate([ExtruderIdlerWheelDiam()/2.5,StandardServoNubDiam()/2+FilamentDiam()/4,StandardServoHeightAbvWings()*2-ExtruderIdlerWheelThickness()-.25]){rotate([0,0,-90]){StandardServoMotor(true,2,true,.4);}}
		//the filament channel:
			rotate([0,90,0]){translate([-ExtruderHeight(),0,-ExtruderLength()/2-2]){Filament();}}
			rotate([0,90,0]){translate([-ExtruderHeight(),0,-ExtruderLength()/2-2]){cylinder(FilamentHeight()/4,FilamentDiam()*4,FilamentDiam()/2);}}
		//The Idler Wheel Recess:
			translate([ExtruderIdlerWheelDiam()/2.5,-ExtruderIdlerWheelDiam()/2,ExtruderHeight(3dPrinterTolerance)/2-ExtruderIdlerWheelThickness(3dPrinterTolerance)]){IdlerWheelKeepaway(.4);}
		//The Idler Wheel (use for adjusting the filament and servo locations):
			translate([ExtruderIdlerWheelDiam()/2.5,-ExtruderIdlerWheelDiam()/2,ExtruderHeight(3dPrinterTolerance)/2-ExtruderIdlerWheelThickness(3dPrinterTolerance)]){IdlerWheel(.4);}
		//The thru hole for the idler wheel:
			translate([ExtruderIdlerWheelDiam()/2.5,-ExtruderIdlerWheelDiam()/2,-ExtruderHeight()+(ExtruderHeight()-1)]){cylinder(h=MagnetLength(3dPrinterTolerance)*2, r=608BallBearingInnerDiam(-3dPrinterTolerance)/2);}
		//The 608 Bearing.  commented out cube is for cross-section examination
			translate([ExtruderIdlerWheelDiam()/2.5,-ExtruderIdlerWheelDiam()/2,MagnetLength()-ExtruderIdlerWheelThickness()*3+1]){cylinder(h=608BallBearingHeight(3dPrinterTolerance)+ExtruderIdlerWheelThickness(),r=(608BallBearingDiam()+.04)/2);}
			translate([ExtruderIdlerWheelDiam()/2.5,-ExtruderIdlerWheelDiam()/2,ExtruderHeight()/2-ExtruderIdlerWheelThickness()*2.25]){608BallBearing();}
			//translate([0,-ExtruderWidth()/2-608BallBearingDiam(3dPrinterTolerance)/2,-ExtruderHeight()]){cube([100,20,100]);}
		//The hole for the servo connector:
			translate([-ExtruderIdlerWheelDiam(3dPrinterTolerance)/4-1,-StandardServoThickness()/2-1,ConnectorLength()/2]){rotate([0,90,90]){ServoConnector(.4);}}
		//Platform connector Screws:
			translate([ExtruderLength()/2+HiLoScrewLength()/2,-ExtruderWidth()/2+HotEndDiam()/2,ExtruderHeight()]){rotate([0,90,0]){HiLoScrew();}}
			mirror([0,0,1]){translate([ExtruderLength()/2+HiLoScrewLength()/2,StandardExtruderSpacing()/2,-ExtruderHeight()]){rotate([0,90,0]){HiLoScrew();}}}
			
		//Counterbored screw holes:
			translate([ExtruderLength()/2-ExtruderIdlerWheelDiam(.4)/3,ExtruderWidth()/2-HiLoScrewHeadDiameter(.4)*2,-.1]){CounterboreScrew(.4);}
			translate([ExtruderLength(.4)/2-ExtruderIdlerWheelDiam(.4)/3,-ExtruderWidth()/2+HiLoScrewHeadDiameter(.4)/3,-.1]){CounterboreScrew(.4);}
			translate([-ExtruderLength()/2+ExtruderIdlerWheelDiam(.4),ExtruderWidth()/2-HiLoScrewHeadDiameter(.4)*2,-.1]){CounterboreScrew(.4);}
			translate([-ExtruderLength()/2+ExtruderIdlerWheelDiam(),-ExtruderWidth()/2+StandardServoThickness()/1.5,-.1]){CounterboreScrew(.4);}
			echo((ExtruderLength()/2-ExtruderIdlerWheelDiam(.4)/3)-(-ExtruderLength()/2+ExtruderIdlerWheelDiam(.4)));
		//weight reduction: 
			translate([-ExtruderHeight()-ExtruderIdlerWheelDiam(),-ExtruderIdlerWheelDiam()-FilamentDiam()*2-2,-1]){cylinder(h=ExtruderHeight()+2,r=ExtruderIdlerWheelDiam());}
			translate([-ExtruderLength()/2-1,-ExtruderWidth()/2,-ExtruderHeight()/2+4]){cube([ExtruderHeight()+2,ExtruderWidth(),ExtruderHeight()+4]);}
			translate([-ExtruderLength()/2-HiLoScrewLength()/1.5,ExtruderWidth()/2-ExtruderHeight()+2,-2]){cube([ExtruderLength(),ExtruderWidth()/4,ExtruderHeight()+4]);
			}
		}
	}else{
	}
}
Extruder(true,.4);

//mirror([1,0,0]){Extruder(true,.4);};
				
			


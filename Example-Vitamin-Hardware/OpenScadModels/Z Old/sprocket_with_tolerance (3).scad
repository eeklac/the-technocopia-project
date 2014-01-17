function mm(i) = i*25.4 ;

$fn = 60;

// sprocket(NUMBER OF TEETH, ROLLER DIAMETER, PITCH LENGTH, THICKNESS, TOLERANCE)
module sprocket(teeth=20, rollerdiam=3, pitch=17, thickness=3, tolerance=0.2){
	//$fs=0.5;
	roller=rollerdiam/2; //We need radius in our calculations, not diameter
	distance_from_center=pitch/(2*sin(180/teeth));
	 echo(distance_from_center); //this just displays the angle below the window

	angle=(360/teeth); 
	pitch_circle=sqrt((distance_from_center*distance_from_center) - (pitch*(roller+tolerance))+((roller+tolerance)*(roller+tolerance)));
	echo(pitch_circle);
	difference(){
		union(){
			cylinder(r=pitch_circle,h=thickness);
			for(tooth=[1:teeth]){
				intersection(){
					rotate(a=[0,0,angle*(tooth+0.5)]){
						translate([distance_from_center,0,0]){
							cylinder(r=pitch-roller-tolerance,h=thickness);
						}
					}
					rotate(a=[0,0,angle*(tooth-0.5)]){
						translate([distance_from_center,0,0]){
							cylinder(r=pitch-roller-tolerance,h=thickness);
						}
					}
				}
			}
		}
		for(tooth=[1:teeth]){
			rotate(a=[0,0,angle*(tooth+0.5)]){
				translate([distance_from_center,0,-1]){
					cylinder(r=roller+tolerance,h=thickness+2);
				}
			}
		}
	}
}

module sprocketNum25(teeth=20){
	sprocket(teeth,mm( .130),mm(1/4),mm(.11)-0.2,0.05);
}

module sprocketNum35(teeth=20){
	sprocket(teeth,mm( .2),mm(3/8),mm(.168)-0.2,0.05);
}

module viewer(){
	sprocketNum25(23);
}

viewer();

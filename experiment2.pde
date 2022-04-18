var q = loadJSONLines("/Users/PhilipChenaux-Repond_MacBookPro/uchicago_cs/performancecap/pythonhead/contours.json")

// with a little bit of motion blur
_.stage.background.a = 0.5
// for-forever
while(true)
{
	// for-every frame in the file (after frame 120)
	for(var frame=120;frame<q.lines.length;frame++)
	{
		// parse the frame
		var FRAME = q.parse(frame)
		
		// *** and pull out two values from the analysis
		var noisex = FRAME.mean_motion_x*4
		var noisey = FRAME.mean_motion_y*4

		// remove everything we've drawn so far
		_.stage.lines.clear()
		var f = new FLine()
		for(var n of FRAME.contours)
		{
			for(var i=0;i<n.length;i+=4)
			{
				// add some random noise in the direction of motion
				f.lineTo(n[i][1] + Math.random()*noisex, 
						 n[i][0] + Math.random()*noisey)
			}
		}
		// map motion to line thicknes
		f.fastThicken=FRAME.mean_motion_x*FRAME.mean_motion_x/4000+0.2
		
		// more grit
		f.pointSize=FRAME.mean_motion_px/30000
		
		// set the color of the line to be the average color of the scene
		//f.color=vec(FRAME.mean_blue/200,FRAME.mean_green/300,FRAME.mean_red/255,0.9)	
		// make it a little more red
		f.color=vec(1.0,0.5,0.9,1)
		
		// but the points tilt blue
		f.pointColor = vec(0.2,0.6,0.3,0.1)
		
		f.pointed=true
		f.pointSize=1
		_.stage.lines.add(f * vec(100,70) + vec(0, 15))
		_.stage.frame(0.05)
	}
}

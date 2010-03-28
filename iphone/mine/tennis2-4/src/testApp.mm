#include "testApp.h"

//--------------------------------------------------------------
void testApp::setup(){	
	// register touch events
	ofRegisterTouchEvents(this);
	
	// initialize the accelerometer
	ofxAccelerometer.setup();
	
	//iPhoneAlerts will be sent to this.
	ofxiPhoneAlerts.addListener(this);
	
	//If you want a landscape oreintation 
	//iPhoneSetOrientation(OFXIPHONE_ORIENTATION_LANDSCAPE_RIGHT);
	
	ofBackground(127,127,127);

/*
 Add - angle on edge of bats
 Sync to good update speed, or adjust for particular machines
 
 */
	
	screenWidth = ofGetScreenWidth();
	screenHeight = ofGetScreenHeight();
	ofSetFrameRate(FRAMERATE);
//	screenWidth = 800;
//	screenHeight = 600;
	ofBackground(0,0,0);	
	
	for (int i = 0; i<4; i++) {
		if (i<2) {
			bat[i].width = LONG_SIZE;
			bat[i].height = THIN_SIZE;
		} else {
			bat[i].width = THIN_SIZE;
			bat[i].height = LONG_SIZE;
		}
		
		// temporary position
		bat[i].cx = 0;
		bat[i].cy = 0;
		
		switch (i) {
			case 0:							// top bat	
				bat[i].limit[0] = H_MARGIN;
				bat[i].limit[1] = screenWidth-H_MARGIN;
				bat[i].limit[2] = 0;
				bat[i].limit[3] = V_MARGIN;
				break;
				
			case 1:							// bottom bat
				bat[i].limit[0] = H_MARGIN;
				bat[i].limit[1] = screenWidth-H_MARGIN;
				bat[i].limit[2] = screenHeight-V_MARGIN;
				bat[i].limit[3] = screenHeight;
				break;
				
			case 2:	
				bat[i].limit[0] = 0;
				bat[i].limit[1] = H_MARGIN;
				bat[i].limit[2] = V_MARGIN;
				bat[i].limit[3] = screenHeight-V_MARGIN;
				break;
				
			case 3:	
				bat[i].limit[0] = screenWidth-H_MARGIN;
				bat[i].limit[1] = screenWidth;
				bat[i].limit[2] = V_MARGIN;
				bat[i].limit[3] = screenHeight-V_MARGIN;
				break;
		}
		bat[i].cx = bat[i].limit[0] + (bat[i].limit[1] - bat[i].limit[0])/2;
		bat[i].cy = bat[i].limit[2] + (bat[i].limit[3] - bat[i].limit[2])/2;
		
		// update the hit rectangle for this bat
		switch (i) {
			case 0:							// top bat	
				bat[i].hit.x = bat[i].cx - LONG_SIZE/2 - GAP;
				bat[i].hit.y = bat[i].cy - THIN_SIZE/2 - GAP;
				bat[i].hit.width = LONG_SIZE + 2*GAP;
				bat[i].hit.height = THIN_SIZE + 2*GAP;
				break;
				
			case 1:							// bottom bat
				bat[i].hit.x = bat[i].cx - LONG_SIZE/2 - GAP;
				bat[i].hit.y = bat[i].cy - THIN_SIZE/2 - GAP;
				bat[i].hit.width = LONG_SIZE + 2*GAP;
				bat[i].hit.height = THIN_SIZE + 2*GAP;
				break;
				
			case 2:	
				bat[i].hit.x = bat[i].cx - THIN_SIZE/2 - GAP;
				bat[i].hit.y = bat[i].cy - LONG_SIZE/2 - GAP;
				bat[i].hit.width = THIN_SIZE + 2*GAP;
				bat[i].hit.height = LONG_SIZE + 2*GAP;
				break;
				
			case 3:	
				bat[i].hit.x = bat[i].cx - THIN_SIZE/2 - GAP;
				bat[i].hit.y = bat[i].cy - LONG_SIZE/2 - GAP;
				bat[i].hit.width = THIN_SIZE + 2*GAP;
				bat[i].hit.height = LONG_SIZE + 2*GAP;
				break;
		}
		
	}
	
	flash = 0;
	flashCount = 0;
	speedScale = SPEED_SCALE;
	
	newGame();
	
	// this load font loads the non-full character set
	// (ie ASCII 33-128), at size "32"
	
	scoreFont.loadFont("verdana.ttf", 32);
	debugFont.loadFont("verdana.ttf", 12);
	
}

void testApp::drawBat(int i) {
	ofRect(bat[i].cx - bat[i].width/2, bat[i].cy - bat[i].height/2 ,bat[i].width, bat[i].height);
}
//--------------------------------------------------------------
void testApp::update(){
	float halfbat;
	float midbat;
	float prop;
	
	if (action == SERVING || action == SCORING) {
		// update a flashing count
		flash+=1;
		if (flash > FLASH_SCALE) {
			flashCount += 1;
			flash = 0;
		}
	}
	
	if (action == SERVING) {		
		if (flashCount == 10) {
			action = MOVING;
			flashCount = 0;
		}
	} else if (action == SCORING) {
		if (flashCount == 10) {
			action = SERVING;
			flashCount = 0;
			ball.cx = screenWidth/2;
			ball.cy = screenHeight/2;
		}
	}
	
	if (action == MOVING) {
		// move the ball
		ball.cx += ball.xspeed;
		ball.cy += ball.yspeed;
		
		// check is past edge of screen
		if (ball.cy <= -1) {
			adjustScore(0);	// score to other people
		}
		if (ball.cy >= screenHeight+1) {
			adjustScore(1);	// score to other people
		}
		if (ball.cx <= -1) {
			adjustScore(2);	// score to other people
		}
		if (ball.cx >= screenWidth+1) {
			adjustScore(3);	// score to other people
		}
		
		// check if hits the bat
		// see if ball centre is in hit rectangle in front and just behind bat
		for (int i = 0; i<4; i++) {
			switch (i) {
				case 0:	
				case 1:	
					if (pointInRect( bat[i].hit, ball.cx, ball.cy)) {
						if (i==0) {
							ball.cy = bat[i].hit.y + bat[i].hit.height + 3;
						} else {
							ball.cy = bat[i].hit.y - 3;
						}
						direction *= -1;
						//				direction = TWO_PI - direction;
						//				if (direction > TWO_PI) direction -= TWO_PI;

						// calc proportion down the bat
						halfbat = bat[i].hit.width/2;
						midbat = bat[i].hit.x + halfbat;
						prop = (midbat - ball.cx)/halfbat;
						dbProp = prop;
						dbBall = ball.cx;

						if (i==0) {
							direction -= H_ARC * prop;
						} else {						
							direction += H_ARC * prop;
						}
						setSpeed();
						// ball.yspeed *= -1;				
					}
					break;
				case 2:	
				case 3:	
					if (pointInRect( bat[i].hit, ball.cx, ball.cy)) {
						if (i==2) {
							ball.cx = bat[i].hit.x + bat[i].hit.width + 3;
						} else {
							ball.cx = bat[i].hit.x - 3;
						}
						direction = PI - direction;
						//						direction = TWO_PI - direction;
						//						if (direction > TWO_PI) direction -= TWO_PI;

						// calc proportion down the bat
						halfbat = bat[i].hit.height/2;
						midbat = bat[i].hit.y + halfbat;
						prop = (midbat - ball.cy)/halfbat;
						dbProp = prop;
						dbBall = ball.cy;

						if (i==2) {
							direction += V_ARC * prop;
						} else {						
							direction -= V_ARC * prop;
						}
						
						
						
						setSpeed();
						// ball.xspeed *= -1;				
					}
					break;
			}
		}
	}
}

void testApp::adjustScore(int player) {
	// add point to other player/s
	for (int i=0; i<4; i++) {
		if (i != player) score[i] += 1;
	}
	action = SCORING;
	direction += PI;
	if (direction > TWO_PI) direction -= TWO_PI;
	setSpeed();
}

bool testApp::pointInRect(ofRectangle r, float x, float y) {
	bool reply = false;
	if (x > r.x && x < (r.x + r.width) && y > r.y && y < (r.y + r.height)) reply = true;
	return reply;
}


void testApp::newGame() {
	for (int i=0; i<4; i++) {
		score[i]=0;
	}
	direction = ofRandom( -PI, PI);
	ball.cx = screenWidth/2;
	ball.cy = screenHeight/2;
	setSpeed();
	flashCount = 0;
	action = SERVING;
}

void testApp::setSpeed() {
	ball.xspeed = cos(direction)*speedScale;
	ball.yspeed = -sin(direction)*speedScale;
}
//--------------------------------------------------------------
void testApp::draw(){
	ofSetColor(255,255,255);
	for (int i=0; i<4; i++) {
		drawBat(i);
	}
	drawScoreboard(screenWidth/2-100,screenHeight/2-80,200,160);
	
	// draw ball
	ofFill();
	if (action == SERVING) {		
		if (flashCount%2 == 1) {
			ofSetColor(55,255, 50);
		} else {
			ofSetColor(255,255,255);
		}
	} else if (action == SCORING) {
		if (flashCount%2 == 1) {
			ofSetColor(255,50, 50);
		} else {
			ofSetColor(255,255,255);
		}
	}
	ofCircle(ball.cx, ball.cy, 10);
}
/*
//--------------------------------------------------------------
void testApp::keyPressed(int key){
	
	if (key == 's' || key == 'S'){
		speedScale -= .2;
	} else if (key == 'f' || key == 'F'){
		speedScale += .2;
	} else if (key == 'n' || key == 'N'){
		newGame();
	} else if (key == ' '){
		if (action == MOVING) {
			action = STOPPED;
		} else {
			action = MOVING;
		}
	}
}

//--------------------------------------------------------------
void testApp::keyReleased(int key){
	
}
 */

void testApp::drawDebug(float x, float y) {

	char tempString[255];
	sprintf(tempString," cx,cy: %3.2f, %3.2f,\n xspeed, yspeed:  %3.2f, %3.2f, \n dirn:%3.2f", ball.cx, ball.cy, ball.xspeed, ball.yspeed, direction );
	debugFont.drawString(tempString, x, y-30);
}

void testApp::drawScoreboard(float x, float y, float w, float h) {
	if (DEBUG_ON) {
		drawDebug(x, y-20);
	}
	float AX = 0.3;
	float AY = 0.3;
	
	ofFill();
	ofSetColor(80,80,80);
	ofRect(x,y,w,h);
	
	ofNoFill();
	ofSetColor(255,255,255);
	ofLine(x,y,x+w,y);
	ofLine(x+w,y,x+w,y+h);
	ofLine(x+w,y+h,x,y+h);
	ofLine(x,y+h,x,y);
	
	ofSetColor(0xFF0000);
	ofLine(x,y, x+w*AX, y+h*AY);
	ofLine(x+w*AX,y+h*AY, x+w-w*AX, y+h*AY);
	ofLine(x+w-w*AX, y+h*AY, x+w, y);
	ofSetColor(0x00FF00);
	ofLine(x,y+h, x+w*AX, y+h-h*AY);
	ofLine(x+w*AX, y+h-h*AY, x+w-w*AX, y+h-h*AY);
	ofLine(x+w-w*AX, y+h-h*AY, x+w, y+h);
	
	ofSetColor(0x0000FF);
	
	ofLine(x+w*AX, y+h*AY, x+w*AX, y+h-h*AY);
	ofLine(x+w-w*AX, y+h*AY, x+w-w*AX, y+h-h*AY);
	
	ofSetColor(0x00FF00);
	float sx;
	float sy;
	float spanX;
	float spanY;
	char tempString[255];
	for (int i = 0; i<4; i++) {
		//		score[i]=9*i;
		sprintf(tempString,"%i", score[i]);
		spanX = scoreFont.stringWidth(tempString); 
		spanY = scoreFont.stringHeight(tempString); 
		switch (i) {
			case (0):
				sx = x + w/2 - spanX/2;
				sy = y + h*AY/2 + spanY/2 - 5;
				break;
			case (1):
				sx = x + w/2 - spanX/2;
				sy = y + h - h*AY/2 + spanY/2 - 5;
				break;
			case (2):
				sx = x + w*AX/2 - spanX/2;
				sy = y + h/2 + 10;
				break;
			case (3):
				sx = x + w - w*AX/2 - spanX/2;
				sy = y + h/2 + 10;
				break;
		}
		
		scoreFont.drawString(tempString, sx, sy);
	}		
}


//--------------------------------------------------------------
void testApp::exit(){

}

//--------------------------------------------------------------
void testApp::touchMoved(ofTouchEventArgs &touch){
	moveBat(touch.x, touch.y);
}

//--------------------------------------------------------------
void testApp::touchDown(ofTouchEventArgs &touch){
	moveBat(touch.x, touch.y);
}
	
	//--------------------------------------------------------------
void testApp::moveBat(int x, int y){
		
	// find which bat
	for (int i=0; i<4; i++) {
		// if click in area
		if (x>bat[i].limit[0] && x<bat[i].limit[1] && y>bat[i].limit[2] && y<bat[i].limit[3] ) {
			bat[i].cx = x;
			bat[i].cy = y;
			
			// update the hit rectangle for this bat
			switch (i) {
				case 0:							// top bat	
					bat[i].hit.x = bat[i].cx - LONG_SIZE/2 - GAP;
					bat[i].hit.y = bat[i].cy - THIN_SIZE/2 - GAP;
					bat[i].hit.width = LONG_SIZE + 2*GAP;
					bat[i].hit.height = THIN_SIZE + 2*GAP;
					break;
					
				case 1:							// bottom bat
					bat[i].hit.x = bat[i].cx - LONG_SIZE/2 - GAP;
					bat[i].hit.y = bat[i].cy - THIN_SIZE/2 - GAP;
					bat[i].hit.width = LONG_SIZE + 2*GAP;
					bat[i].hit.height = THIN_SIZE + 2*GAP;
					break;
					
				case 2:	
					bat[i].hit.x = bat[i].cx - THIN_SIZE/2 - GAP;
					bat[i].hit.y = bat[i].cy - LONG_SIZE/2 - GAP;
					bat[i].hit.width = THIN_SIZE + 2*GAP;
					bat[i].hit.height = LONG_SIZE + 2*GAP;
					break;
					
				case 3:	
					bat[i].hit.x = bat[i].cx - THIN_SIZE/2 - GAP;
					bat[i].hit.y = bat[i].cy - LONG_SIZE/2 - GAP;
					bat[i].hit.width = THIN_SIZE + 2*GAP;
					bat[i].hit.height = LONG_SIZE + 2*GAP;
					break;
			}
			
			break;
		}
	}
	
}

//--------------------------------------------------------------
void testApp::touchUp(ofTouchEventArgs &touch){

}

//--------------------------------------------------------------
void testApp::touchDoubleTap(ofTouchEventArgs &touch){
	int x = touch.x;
	int y = touch.y;
	ofRectangle r = ofRectangle(screenWidth/2-30,screenHeight/2-30,60,60);
	if (pointInRect(r, x, y)) {
		newGame();
	}
}

//--------------------------------------------------------------
void testApp::lostFocus(){

}

//--------------------------------------------------------------
void testApp::gotFocus(){

}

//--------------------------------------------------------------
void testApp::gotMemoryWarning(){

}

//--------------------------------------------------------------
void testApp::deviceOrientationChanged(int newOrientation){

}


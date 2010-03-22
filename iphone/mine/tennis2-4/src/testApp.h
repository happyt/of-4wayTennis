#pragma once

#include "ofMain.h"
#include "ofxiPhone.h"
#include "ofxiPhoneExtras.h"

class testApp : public ofxiPhoneApp {
	
public:
	void setup();
	void update();
	void draw();
	void exit();
	
	void touchDown(ofTouchEventArgs &touch);
	void touchMoved(ofTouchEventArgs &touch);
	void touchUp(ofTouchEventArgs &touch);
	void touchDoubleTap(ofTouchEventArgs &touch);

	void lostFocus();
	void gotFocus();
	void gotMemoryWarning();
	void deviceOrientationChanged(int newOrientation);

	void drawBat(int i);
	bool pointInRect(ofRectangle r, float x, float y);
	void drawScoreboard(float x, float y, float w, float h);
	void adjustScore(int player);
	void drawDebug(float x, float y);
	void setSpeed();
	void newGame();
	
	struct paddle {
		float cx;
		float cy;
		float width;
		float height;
		float limit[4];			// movement area
		ofRectangle hit;		// hit rectangle
	};
	
	struct balls {
		float cx;
		float cy;
		float xspeed;
		float yspeed;
	};
	
	paddle bat[4];
	int score[4];
	balls ball;
	bool serveBall;
	float direction;  // start direction, radians +-pi
	
	enum { SERVING, SCORING, MOVING, STOPPED };
	int action;
	
	ofTrueTypeFont  scoreFont;
	ofTrueTypeFont  debugFont;
	int screenWidth;
	int screenHeight;
	
	int flash;
	int flashCount;
	
	float speedScale;
	
#define V_MARGIN 50
#define H_MARGIN 50
	
#define SPEED_SCALE 0.4
#define FLASH_SCALE 20
	
#define THIN_SIZE 10
#define LONG_SIZE 100
#define GAP 10
};



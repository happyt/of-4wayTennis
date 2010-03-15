#include "testApp.h"

//--------------------------------------------------------------
void testApp::setup(){
	
	ofBackground(0, 0, 0);
}

//--------------------------------------------------------------
void testApp::update(){

	for (int i = 0; i < pts.size(); i++){
		
		//pts[i].x += ofRandom(-1,1);
		//pts[i].y += ofRandom(-1,1);
		
	}
	
}

//--------------------------------------------------------------
void testApp::draw(){


	
	ofSetPolyMode(OF_POLY_WINDING_NONZERO);
	
	ofFill();
	if (pts.size() > 2){
		
		ofBeginShape();
		
		ofVertex(pts[0].x, pts[0].y);
		
		
		float width = 3;
		for (int i = 0; i < pts.size()-2; i++){
			ofPoint a = pts[i];
			ofPoint b = pts[i+1];
			ofPoint c = pts[i+2];
			float dx = c.x - a.x;
			float dy = c.y - a.y;
			float distance = sqrt (dx*dx + dy*dy);
			float angle = atan2(dy, dx);
			
			width = 0.6f * width + 0.4f * (3+distance/5);
			
			//ofSetLineWidth(distance);
			ofCurveVertex(b.x + width * cos(angle + PI/2), b.y + width * sin(angle + PI/2));
			//ofLine(b.x, b.y, b.x - distance * cos(angle + PI/2), b.y - distance * sin(angle + PI/2));
			
		}
		
		ofVertex(pts[pts.size()-1].x, pts[pts.size()-1].y);
		
		
		for (int i = pts.size()-3; i >= 0; i--){
			ofPoint a = pts[i];
			ofPoint b = pts[i+1];
			ofPoint c = pts[i+2];
			float dx = c.x - a.x;
			float dy = c.y - a.y;
			float distance = sqrt (dx*dx + dy*dy);
			float angle = atan2(dy, dx);
			//ofSetLineWidth(distance);
			//ofLine(b.x, b.y, b.x + distance * cos(angle + PI/2), b.y + distance * sin(angle + PI/2));
			
			width = 0.6f * width + 0.4f * (3+distance/5);
			
			ofCurveVertex(b.x - width * cos(angle + PI/2), b.y - width * sin(angle + PI/2));
			
		}
		
		ofEndShape(true);
	}
}

//--------------------------------------------------------------
void testApp::keyPressed(int key){

}

//--------------------------------------------------------------
void testApp::keyReleased(int key){

}

//--------------------------------------------------------------
void testApp::mouseMoved(int x, int y ){

}

//--------------------------------------------------------------
void testApp::mouseDragged(int x, int y, int button){
	
	ofPoint myPt;
	myPt.x = x;
	myPt.y = y;
	pts.push_back(myPt);
	
	
}

//--------------------------------------------------------------
void testApp::mousePressed(int x, int y, int button){

	pts.clear();
}

//--------------------------------------------------------------
void testApp::mouseReleased(int x, int y, int button){

}

//--------------------------------------------------------------
void testApp::windowResized(int w, int h){

}


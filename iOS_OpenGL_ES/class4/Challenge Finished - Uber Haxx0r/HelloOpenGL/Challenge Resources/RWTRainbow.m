//
//  RWTRainbow.m
//  HelloOpenGL
//
//  Created by Main Account on 9/1/13.
//  Copyright (c) 2013 Razeware LLC. All rights reserved.
//

#import "RWTRainbow.h"

// http://stackoverflow.com/questions/470690/how-to-automatically-generate-n-distinct-colors
void getRainbowColor(float x, float * r, float * g, float * b) {
	*r = 0.0f;
	*g = 0.0f;
	*b = 1.0f;
	if (x >= 0.0f && x < 0.2f) {
		x = x / 0.2f;
		*r = 0.0f;
		*g = x;
		*b = 1.0f;
	} else if (x >= 0.2f && x < 0.4f) {
		x = (x - 0.2f) / 0.2f;
		*r = 0.0f;
		*g = 1.0f;
		*b = 1.0f - x;
	} else if (x >= 0.4f && x < 0.6f) {
		x = (x - 0.4f) / 0.2f;
		*r = x;
		*g = 1.0f;
		*b = 0.0f;
	} else if (x >= 0.6f && x < 0.8f) {
		x = (x - 0.6f) / 0.2f;
		*r = 1.0f;
		*g = 1.0f - x;
		*b = 0.0f;
	} else if (x >= 0.8f && x <= 1.0f) {
		x = (x - 0.8f) / 0.2f;
		*r = 1.0f;
		*g = 0.0f;
		*b = x;
	}
}
//
//  SIListViewCell.m
//  StackInbox
//
//  Created by Jonathan Bailey on 19/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SIListViewCell.h"

@implementation SIListViewCell
@synthesize detailTextLabel,	 timeField, textLabel, imageView, backgroundColor;

- (void)setBackgroundColor:(NSColor *)new_value {
	backgroundColor = new_value ? backgroundColor : new_value;
	[self setNeedsDisplay:NO];
}

- (void)prepareForReuse {	[self setBackgroundColor:nil];	[super prepareForReuse];	}

- (void)drawRect:(NSRect)dirtyRect {

//	if (self.backgroundColor != nil) {	[self.backgroundColor setFill];  	NSRectFill(dirtyRect);	}
//	else {
//		[[NSColor colorWithDeviceRed:.9 green:.9 blue:.9 alpha:1.0] setFill];
//		NSRectFill(dirtyRect);
//	}
//	NSBezierPath *path = [NSBezierPath bezierPath];
//	[path moveToPoint:NSMakePoint(0, 0)];
//	[path lineToPoint:NSMakePoint(self.frame.size.width, 0)];
//	[path setLineWidth:1];
//	[[NSColor grayColor] setStroke];
//	[path stroke];

//	if ([self isSelected]) 				NSRectFillWithColor(dirtyRect, [RANDOMCOLOR alpha:.5]);
//	[super drawRect:dirtyRect];

	if([self isSelected]) {
		[[NSColor selectedControlColor] set];
	}
	else {
		[[NSColor whiteColor] set];
    }

    //Draw the border and background
	NSBezierPath *roundedRect = [NSBezierPath bezierPathWithRoundedRect:[self bounds] xRadius:6.0 yRadius:6.0];
	[roundedRect fill];
}

//- (void)dealloc {
//	[textLabel release];
//	textLabel = nil;
//	[imageView release];
//	imageView = nil;
//	[detailTextLabel release];
//	detailTextLabel = nil;
//	[super dealloc];
//}

@end

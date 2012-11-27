//
//  SIWindow.m
//  StackInbox
//
//  Created by Jonathan Bailey on 20/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SIWindow.h"

@implementation SIWindow
@synthesize titlebarRefreshSpinner;

- (void)keyUp:(NSEvent *)theEvent	{	NSLog(@"%@", self.delegate);	}
- (void)awakeFromNib
{
	self.delegate = self;
	self.backgroundColor = GRAY2;
	self.titleBarHeight = 30;
	NSProgressIndicator *refreshSpinner = [[NSProgressIndicator alloc] initWithFrame:NSMakeRect(self.titleBarView.bounds.size.width - 30, CGRectGetMidY(self.titleBarView.bounds) - 10, 20, 20)];
	refreshSpinner.style				= NSProgressIndicatorSpinningStyle;
	refreshSpinner.displayedWhenStopped = YES;
	refreshSpinner.doubleValue			= 50;
	refreshSpinner.indeterminate		= YES;
	refreshSpinner.bezeled				= YES;
	refreshSpinner.arMASK = NSViewMinXMargin | NSViewMaxXMargin | NSViewMinYMargin | NSViewMaxYMargin;
	[self.titleBarView addSubview:refreshSpinner];
	self.titlebarRefreshSpinner = refreshSpinner;
	
	NSTextField *titleText = [[NSTextField alloc] initWithFrame:self.titleBarView.frame];
	//NSMakeRect(0, CGRectGetMidY(self.titleBarView.bounds) -5, self.titleBarView.bounds.size.width, 15)];
	titleText.arMASK					= NSSIZEABLE;
	titleText.bezeled					= NO;
	titleText.alignment					= NSCenterTextAlignment;
	titleText.backgroundColor			= RED;
//	titleText.autoresizingMask = NSViewMinXMargin | NSViewMaxXMargin | NSViewMinYMargin | NSViewMaxYMargin;
	titleText.stringValue				= @"StackExchange Inbox";
	titleText.selectable				= NO;
	titleText.editable					= NO;
	
	[self.titleBarView addSubview:titleText];

	NSRect r = AZRightEdge(self.titleBarView.frame, 25);
	NSImageView *iv = [[NSImageView alloc]initWithFrame:AZRectFromDim(25)];
	iv.image = [[[NSIMG systemIcons]randomElement]scaledToMax:25];// [NSIMG badgeForRect:AZRectFromDim(25) withColor:RANDOMCOLOR stroked:BLACK withString:@"20"];
	[self.titleBarView addSubview:iv];
	[iv setFrame:r];

}
- (NSRect)window:(NSWindow *)window willPositionSheet:(NSWindow *)sheet usingRect:(NSRect)rect
{
	rect.origin.y -= 24;
	return rect;
}
@end

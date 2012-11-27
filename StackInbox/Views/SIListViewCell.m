//  SIListViewCell.m
//  Created by Jonathan Bailey on 19/12/2011.

#import "SIViewControllers.h"   //#import "SIListViewCell.h"

@implementation SIListViewCell
@synthesize detailTextLabel,	 timeField, textLabel, imageView;

- (NSC*) backgroundColor	{	return [self.imageView.image quantize][0];	}

- (void)prepareForReuse 	{	[super prepareForReuse];		/* [self setBackgroundColor:nil]; */ }

- (void)drawRect:(NSRect)dirtyRect
{
	[self isSelected] ? ^{
		[self.backgroundColor set];
		[textLabel setAssociatedValue:[textLabel.textColor hexString]  forKey:@"oldColor" policy:OBJC_ASSOCIATION_RETAIN_NONATOMIC];
		textLabel.textColor = self.backgroundColor.contrastingForegroundColor;
	}() : ^{
		textLabel.textColor = [NSC colorFromHexRGB:[textLabel associatedValueForKey:@"oldColor"]];
		[[self.backgroundColor alpha:.2] set];
    }();

    //Draw the border and background
	[[NSBezierPath bezierPathWithRect:self.bounds] fill];//RoundedRect:[self bounds] xRadius:6.0 yRadius:6.0];
	[[NSBezierPath bezierPathWithRect:AZRectBy(dirtyRect.size.width, 3)] fillWithColor:BLACK];
}

@end

//	if (self.backgroundColor != nil) {	[self.backgroundColor setFill];  	NSRectFill(dirtyRect);	}
//	else {		[[NSColor colorWithDeviceRed:.9 green:.9 blue:.9 alpha:1.0] setFill];
//				NSRectFill(dirtyRect);					}
//	NSBezierPath *path = [NSBezierPath bezierPath];
//	[path moveToPoint:NSMakePoint(0, 0)];
//	[path lineToPoint:NSMakePoint(self.frame.size.width, 0)];
//	[path setLineWidth:1];	[[NSColor grayColor] setStroke];	[path stroke];

//	if ([self isSelected]) 				NSRectFillWithColor(dirtyRect, [RANDOMCOLOR alpha:.5]);
//	[super drawRect:dirtyRect];

//- (void)setBackgroundColor:(NSColor *)backgroundColor
//{
//	_backgroundColor = backgroundColor ?: _backgroundColor;
//	[self setNeedsDisplay:YES];
//}


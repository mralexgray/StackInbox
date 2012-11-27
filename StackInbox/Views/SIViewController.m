
//  SIViewController.m
//  Created by Jonathan Bailey on 11/02/2012.

#import "SIViewControllers.h"

@implementation SIViewController
@synthesize 	parentContainer, isCurrent;

- (id)init
{
    NSS* classname = NSStringFromClass([self class]);
    if (!(self = [super initWithNibName:classname bundle:[NSBundle frameworkBundleNamed:@"AtoZStack"]])) return nil;
	return self;
}

- (void) viewControllerWillMoveFromParent {	/* override */		}

@end

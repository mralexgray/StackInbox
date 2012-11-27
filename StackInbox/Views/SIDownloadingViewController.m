//
//  SIDownloadingViewController.m
//  StackInbox
//
//  Created by Jonathan Bailey on 11/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SIViewControllers.h"

@implementation SIDownloadingViewController
@synthesize activity;
@synthesize progressBar;

- (id)initWithNibName:(NSS *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	if (!(self = [super initWithNibName:nibNameOrNil bundle:[NSBundle frameworkBundleNamed:@"AtoZStack"]])) return nil;
	return self;
}

- (void)awakeFromNib {
	[self.activity startAnimation:nil];
}
- (void)viewControllerWillMoveFromParent {
	[self.progressBar setDoubleValue:0];
}
@end

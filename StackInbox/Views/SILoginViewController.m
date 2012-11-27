//
//  SILoginViewController.m
//  StackInbox
//
//  Created by Jonathan Bailey on 11/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SIViewControllers.h"

@implementation SILoginViewController
@synthesize loginState, loginButton, progressBar, delegate;

- (id)initWithNibName:(NSS *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	if (!(self = [super initWithNibName:nibNameOrNil bundle:[NSBundle frameworkBundleNamed:@"AtoZStack"]])) return nil;
	return self;
}

- (void)switchToLoggingInState:(BOOL)loggingIn
{
	[self setLoginState:	 		loggingIn];
	[loginButton setEnabled: 		loggingIn ? NO : YES];
	[loginButton setTitle:			loggingIn ? @"Logging in..." : @"Login"];
	[progressBar setIndeterminate:	loggingIn ? YES : NO];
	loggingIn ? [progressBar startAnimation:nil]
			  : [progressBar setDoubleValue:0];
}
- (void) awakeFromNib {	[self switchToLoggingInState:self.loginState];	}

- (IBAction) login:(NSBUTT*)sender
{
	[self switchToLoggingInState:YES];
	performDelegateSelector(@selector(loginButtonPressed))
}

- (void)viewControllerWillMoveFromParent { 	[self switchToLoggingInState:NO]; }

@end

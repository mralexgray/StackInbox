//
//  SIViewController.h
//  
//
//  Created by Jonathan Bailey on 11/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PXListView.h"

@class SIAppDelegate;
@interface SIViewController : NSViewController

@property (unsafe_unretained) SIAppDelegate *parentContainer;
@property (assign) BOOL 		  isCurrent;

- (id)init;
- (void)viewControllerWillMoveFromParent;

@end

@protocol SILoginViewControllerDelegate <NSObject>
- (void)loginButtonPressed;
@end

@interface SILoginViewController : SIViewController
@property (assign) BOOL loginState;
@property (unsafe_unretained) IBOutlet NSButton *loginButton;
@property (unsafe_unretained) IBOutlet NSProgressIndicator *progressBar;
@property (unsafe_unretained) id<SILoginViewControllerDelegate> delegate;
- (IBAction)login:(NSButton *)sender;
- (void)setLoginState:(BOOL)loggingIn;
@end



@interface SIDownloadingViewController : SIViewController
@property (unsafe_unretained) IBOutlet NSProgressIndicator *activity;
@property (unsafe_unretained) IBOutlet NSProgressIndicator *progressBar;

@end



@interface SINoInternetViewController : SIViewController
@end


@interface SIInboxListViewController : SIViewController <PXListViewDelegate>
@property (unsafe_unretained) IBOutlet   PXListView 	*listView;
@property (nonatomic, strong) NSArray 		*itemsToList;
@end



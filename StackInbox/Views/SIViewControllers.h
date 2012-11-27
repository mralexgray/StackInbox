//
//  SIViewController.h
//  
//
//  Created by Jonathan Bailey on 11/02/2012.

#import "EGOImageView.h"
#import <AtoZ/AtoZ.h>

@class SIAppDelegate;
@interface 					 SIViewController : NSViewController
@property (weak) 				SIAppDelegate   *parentContainer;
@property  								 BOOL 	isCurrent;

- (void) viewControllerWillMoveFromParent;
- (id)   init;
@end

@protocol       SILoginViewControllerDelegate   <NSObject>
- (void) loginButtonPressed;
@end

@interface              SILoginViewController : SIViewController
@property 	   	  						 BOOL   loginState;
@property (weak) 		IBOutlet 	   NSBUTT   *loginButton;
@property (weak) 		IBOutlet 	     NSPI   *progressBar;
@property  id <SILoginViewControllerDelegate>   delegate;

- (IBAction) login:			(NSBUTT*)sender;
- (void) 	 setLoginState:	(BOOL)loggingIn;
@end

@interface 			           SIListViewCell : PXListViewCell
@property (RONLY)		      		      NSC	*backgroundColor;
@property (STRNG,NATOM) IBOutlet EGOImageView   *imageView;
@property  			    IBOutlet       NSTXTF 	*timeField;
@property (STRNG,NATOM) IBOutlet       NSTXTF 	*textLabel,
												*detailTextLabel;
@end

@interface 		  DSURLTestListViewController : SIViewController <PXListViewDelegate>
@property  			   	IBOutlet   PXListView   *listView;
@property (STRNG,NATOM) 		     	  NSA   *itemsToList;
@end

@interface 			      DSURLDataSourceCell : PXListViewCell
@property (STRNG,NATOM)	IBOutlet       NSTXTF   *textLabel;
@property 			 	IBOutlet 	 AZASIMGV   *imageV;
@property (STRNG) 					      NSC   *backgroundColor;
@end

@interface        SIDownloadingViewController : SIViewController
@property  				IBOutlet         NSPI   *activity;
@property  				IBOutlet    	 NSPI   *progressBar;
@end


@interface          SIInboxListViewController : SIViewController <PXListViewDelegate>
@property  			   IBOutlet    PXListView 	*listView;
@property (STRNG,NATOM) 			      NSA   *itemsToList;
@end

@interface         SINoInternetViewController : SIViewController
@end


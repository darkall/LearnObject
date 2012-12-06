//
//  ViewController.h
//  LearnObjects
//
//  Created by Liu zhongqiang on 6/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@class ExtUIScrollView;
@class ExtUIView;
@class CustomScrollView;
@class CusExtUIView;
@class CustomSetViewViewController;

@interface ViewController : UIViewController <UIGestureRecognizerDelegate>{
    IBOutlet ExtUIScrollView *mScrView;
    IBOutlet UIView *mMainView;
    IBOutlet ExtUIView *mExamView;
    CustomScrollView *mCustomScrollView;
    CusExtUIView *mCusExtUIView;

    
    CustomSetViewViewController *mSetView;

    CGRect mRect;
    NSString* mCurCategroy;
    
    CGPoint mFirstPoint;
	CGPoint mSecondPoint;
    BOOL mTouchMove;
}

@property UIView *mMainView;
@property ExtUIScrollView *mScrView;

-(void) mainViewLoad;

@end

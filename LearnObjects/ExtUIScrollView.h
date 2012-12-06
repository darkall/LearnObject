//
//  ExtUIScrollView.h
//  LearnObjects
//
//  Created by Liu zhongqiang on 6/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExtUIScrollView : UIScrollView {
    CGPoint mFirstPoint;
	CGPoint mSecondPoint;
    BOOL mTouchMove;
    NSString *mCurCategroy;
    NSInteger mRandNum;
}

-(id)initWithFrame:(CGRect)frame withCategroy:(NSString*) categroy;
-(void) clipScollViewLoad;

@end

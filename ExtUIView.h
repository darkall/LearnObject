//
//  ExtUIView.h
//  LearnObjects
//
//  Created by Liu zhongqiang on 8/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExtUIView : UIView{
    CGPoint mFirstPoint;
    CGPoint mSecondPoint;
    BOOL mTouchMove;
    NSInteger mCurPicIndex;
    NSArray* mColors;
    NSMutableArray *mPoint;
    NSInteger mSelectIndex;
}

-(void) examViewLoad:(NSString*) category 
       locationIndex:(NSInteger) index;
@end

//
//  CusExtUIView.h
//  LearnObjects
//
//  Created by Liu zhongqiang on 8/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CusExtUIView : UIView{
    NSInteger mRandlocation;
    NSArray* mColors;
    NSMutableArray *mPoint;
    NSInteger mSelectIndex;
}
-(void) imageLoad:(NSArray*) array;
-(void) imageLoad:(NSArray*) array locationIndex:(NSInteger) index;
@end

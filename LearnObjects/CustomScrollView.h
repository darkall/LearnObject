//
//  CustomScrollView.h
//  LearnObjects
//
//  Created by Nuo Yang on 8/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LocalImageManager;

@interface CustomScrollView : UIScrollView{
    UIView *mSetView;
    CGRect mFrame;
    LocalImageManager *mImageCenter;
    NSMutableArray *mImgArray;
    BOOL isHavePic;
}

-(id)initWithFrame:(CGRect)frame with:(UIView*) setView;
-(void)updateData;
-(NSArray*) getImages;
@end

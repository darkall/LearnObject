//
//  CustomSetViewViewController.h
//  LearnObjects
//
//  Created by Liu zhongqiang on 9/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PicChoiceView;
@interface CustomSetViewViewController : UIViewController{
    PicChoiceView *mPickView;
    UIImageView *mIntroView;
    CGRect mRect;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withRect:(CGRect) rect;
- (void) SaveImageToLocal;
@end

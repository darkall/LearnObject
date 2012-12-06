//
//  PicChoiceView.h
//  LearnObjects
//
//  Created by Liu zhongqiang on 8/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  LocalImageManager;
@interface PicChoiceView : UIViewController{
    NSMutableArray *mImageViewArray;
    LocalImageManager* mImageCenter;

}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil;
-(void)SaveImageToLocal;

@end

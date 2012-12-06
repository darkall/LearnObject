//
//  PicChoiceView.m
//  LearnObjects
//
//  Created by Liu zhongqiang on 8/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PicChoiceView.h"
#import "ImagePickView.h"
#import "LocalImageManager.h"

#define kScreenWidth		 1024.0
#define kScreenHeight		 768.0

#define kImageWidth			 1024.0/5
#define kImageHeight		 768.0/3
#define kImageNumber         10

@implementation PicChoiceView

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    //self.view.frame = rect;
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code
        CGRect rect = CGRectMake(2, 2, kImageWidth-4, kImageHeight-4);
        mImageViewArray = [[NSMutableArray alloc] init];
        mImageCenter = [LocalImageManager sharedManager];
        
        for (int i=0;i< kImageNumber;i++) {
            [mImageViewArray addObject:[[ImagePickView alloc] init]];
        }
        NSString *imgName = @"LearnObject";
        for(NSInteger i=1;i<kImageNumber+1;i++){
            rect.origin.x = kImageWidth*((i-1)%5);
            if(i>5&&i<11)
                rect.origin.y = kImageHeight;
            UIImageView* imgView=[[mImageViewArray objectAtIndex:i-1] initWithFrame:rect];
            NSString *tmpName = [imgName stringByAppendingString: [NSString stringWithFormat: @"%d", i-1]];
            if([mImageCenter LocalHaveImage:tmpName]){
                imgView.image = [mImageCenter GetImageFromLocal:tmpName];
            }
            [self.view addSubview:imgView];
        }
        [self.view setBackgroundColor:[UIColor blackColor]];
    }
    return self;
}

-(void)SaveImageToLocal{
    NSString *imgName;
    for (NSInteger i=0;i< kImageNumber;i++) {
        ImagePickView *tmp = (ImagePickView*) [mImageViewArray objectAtIndex:i];
        imgName = [NSString stringWithFormat: @"LearnObject%d", i];
        if(tmp.image !=nil){
            [mImageCenter SaveImageToLocal:tmp.image Keys:imgName];
        }
    }
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if([[event allTouches] count] >= 2){
         [self.view.superview.nextResponder touchesEnded:touches withEvent:event];
          return;
    }else if([[event allTouches] count] == 1){
        UITouch *touch = [touches anyObject];    
        ImagePickView *view = (ImagePickView*) [touch view];
        [view openPhotoLibrary:nil];
    }
}

@end

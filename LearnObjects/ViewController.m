//
//  ViewController.m
//  LearnObjects
//
//  Created by Liu zhongqiang on 6/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "ExtUIScrollView.h"
#import "ExtUIView.h"
#import "PicChoiceView.h"
#import "SCGIFImageView.h"
#import "CustomScrollView.h"
#import "CusExtUIView.h"
#import "CustomSetViewViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize mMainView,mScrView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    CGRect tmpRect = [[UIScreen mainScreen] bounds];
    mRect.origin = tmpRect.origin;
    mRect.size.width = tmpRect.size.height;
    mRect.size.height = tmpRect.size.width;
    
    mCurCategroy = @"fruit";
    
    mMainView = [[UIView alloc] initWithFrame:mRect];
    [self mainViewLoad];
    [self.view addSubview:mMainView];
    [self.view setTag:1];
    
    mExamView = [[ExtUIView alloc] initWithFrame:mRect];
    [mExamView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:mExamView];

    [self setViewLoad];
    [self.view addSubview:mSetView.view];
    
    mCusExtUIView = [[CusExtUIView alloc] initWithFrame:mRect];
    [self.view addSubview:mCusExtUIView];
    [self.view bringSubviewToFront:mMainView];
	// Do any additional setup after loading the view, typically from a nib.
    
    UITapGestureRecognizer *singleTapTwo = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    singleTapTwo.numberOfTouchesRequired = 2; 
    singleTapTwo.numberOfTapsRequired = 1; 
    singleTapTwo.delegate = self;
    [self.view addGestureRecognizer:singleTapTwo];
}

-(void)setViewLoad
{
    mSetView = [[CustomSetViewViewController alloc] initWithNibName:nil bundle:nil withRect:mRect];
//    [mSetView.view setBackgroundColor:[UIColor whiteColor]];
//    NSString* filePath1 = [[NSBundle mainBundle] pathForResource:@"intr.png" ofType:nil];
//    //NSString* filePath2 = [[NSBundle mainBundle] pathForResource:@"twoFingerTap.gif" ofType:nil];
//    
//    UIImageView *gifView1 = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:filePath1]];
//    //SCGIFImageView *gifView2 = [[SCGIFImageView alloc] initWithGIFFile:filePath2];
//    gifView1.frame = CGRectMake(0, 0, gifView1.image.size.width, gifView1.image.size.height);
//    
//    //gifView2.frame = CGRectMake(0, gifView1.image.size.height, gifView1.image.size.width, gifView2.image.size.height);
//    mPickView.frame = CGRectMake(mPickView.frame.origin.x
//                                 , mRect.size.height/3, mPickView.frame.size.width,mPickView.frame.size.height);
//    [mSetView.view addSubview:gifView1];
//    [mSetView.view addSubview:mPickView];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //mPickView = segue.destinationViewController;
    //    [self performSegueWithIdentifier:@"PickImages" sender:nil];
    //[self.view addSubview:mPickView.view];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

- (void) handleSingleTap:(UITapGestureRecognizer *)sender {
    
    if (sender.numberOfTouchesRequired == 2) {
        if(self.view.tag==3){
            [self.view bringSubviewToFront:mScrView];
            [self.view setTag:2];
            mTouchMove = NO;
            [self doCATransitionUnCurl];
        } else if(self.view.tag==2){
            [self.view bringSubviewToFront:mMainView];
            [self.view setTag:1];
            mTouchMove = NO;
            [self doCameraIrisHollowClose];
        } else if(self.view.tag==4){
            [self.view bringSubviewToFront:mMainView];
            [self.view setTag:1];
            mTouchMove = NO;
            [self doCameraIrisHollowClose];
        } else if(self.view.tag==5){
            [self.view bringSubviewToFront:mMainView];
            [mSetView SaveImageToLocal];
            [self.view setTag:1];
            mTouchMove = NO;
            [self doCameraIrisHollowClose];
        } else if(self.view.tag==44){
            [self.view bringSubviewToFront:mCustomScrollView];
            [self.view setTag:4];
            mTouchMove = NO;
            [self doCameraIrisHollowClose];
        }
    }
}

-(IBAction) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
	CGPoint point = [touch locationInView:self.view];
	mFirstPoint = point;
	mTouchMove = NO;
}

-(IBAction) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if([[event allTouches] count] >= 2)
        return;

    if(mTouchMove==NO){
        if(self.view.tag==1){
            UITouch *touch = [touches anyObject];    
            CGPoint touchPoint = [touch locationInView:[touch view]];
            CGFloat x,y,width,height;
            x=touchPoint.x;
            y=touchPoint.y;
            width=mRect.size.width/3;
            height=mRect.size.height/2;
            
            if(x<width && y<height){
                mCurCategroy=@"fruit";
                mScrView = [[ExtUIScrollView alloc] initWithFrame:mRect withCategroy:mCurCategroy];
                [mScrView clipScollViewLoad];
                [self.view addSubview:mScrView];
                [self.view bringSubviewToFront:mScrView];
                [self doCATransitionSuckEffect];
                [self.view setTag:2];
            } else if((x>width && x<2*width)&&y<height){
                mCurCategroy=@"number";
                mScrView = [[ExtUIScrollView alloc] initWithFrame:mRect withCategroy:mCurCategroy];
                [mScrView clipScollViewLoad];
                [self.view addSubview:mScrView];
                [self.view bringSubviewToFront:mScrView];
                [self doCATransitionSuckEffect];
                [self.view setTag:2];
            } else if((x>2*width && x<3*width)&&y<height){
                mCustomScrollView = [[CustomScrollView alloc] initWithFrame:mRect with:mSetView.view];
                [self.view addSubview:mCustomScrollView];
                [mCustomScrollView updateData];
                [self.view bringSubviewToFront:mCustomScrollView];
                [self.view setTag:4];                
            } else if(x<width && (y>height && y<2*height)){
                mCurCategroy=@"alphabet";
                mScrView = [[ExtUIScrollView alloc] initWithFrame:mRect withCategroy:mCurCategroy];
                [mScrView clipScollViewLoad];
                [self.view addSubview:mScrView];
                [self.view bringSubviewToFront:mScrView];
                [self doCATransitionSuckEffect];
                [self.view setTag:2];
            } else if((x>width && x<2*width) && (y>height && y<2*height) ){
                mCurCategroy=@"animal";
                mScrView = [[ExtUIScrollView alloc] initWithFrame:mRect withCategroy:mCurCategroy];
                [mScrView clipScollViewLoad];
                [self.view addSubview:mScrView];
                [self.view bringSubviewToFront:mScrView];
                [self doCATransitionSuckEffect];
                [self.view setTag:2];
            } else if((x>2*width && x<3*width)&& (y>height && y<2*height)){
                [self.view bringSubviewToFront:mSetView.view];
                [self.view setTag:5];
            }
            
        }else if(self.view.tag==2){
            [mExamView examViewLoad:mCurCategroy locationIndex:mScrView.contentOffset.x/1024];
            [self.view bringSubviewToFront:mExamView];
            [self doCATransitionCurl];
            [self.view setTag:3];
        } else if(self.view.tag==4){
            [mCusExtUIView imageLoad:[mCustomScrollView getImages]
                 locationIndex:mCustomScrollView.contentOffset.x/1024];
            [self.view bringSubviewToFront:mCusExtUIView];
            [self doCATransitionCurl];
            [self.view setTag:44];
        }

    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [touches anyObject];
	CGPoint point = [touch locationInView:self.view];
	mSecondPoint = point;
	mTouchMove = YES;
}

-(void) mainViewLoad
{
    CGRect tmp = mRect;
    tmp.size.width = mRect.size.width/3;
    tmp.size.height = mRect.size.height/2;
    for(NSInteger i=1;i<7;i++){
        tmp.origin.x = tmp.size.width*((i-1)%3);
//        if ((i-1)%3)
//            tmp.origin.x = tmp.size.width*((i-1)%3)+2;
        if(i>=4)
            tmp.origin.y = (mRect.size.height/2);
        UIImageView* imageView=[[UIImageView alloc] initWithFrame:tmp];
        UIImage *img;
        switch(i-1)
        { 
        case 0:
            img = [UIImage imageNamed:@"icon0.jpg"];
            break;
        case 1:
            img = [UIImage imageNamed:@"icon2.jpg"];
            break;
        case 3:
            img = [UIImage imageNamed:@"icon3.jpg"];
            break;
        case 4:   
            img = [UIImage imageNamed:@"icon1.jpg"]; 
            break;
        case 2:   
            img = [UIImage imageNamed:@"icon4.jpg"]; 
            break;
        case 5:   
            img = [UIImage imageNamed:@"icon5.jpg"]; 
            break;
        }
        [imageView setImage:img];
        [mMainView addSubview:imageView];
    }
    [mMainView setBackgroundColor:[UIColor blackColor]];
}

-(void) doCATransitionUnCurl
{
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = 0.5f * 1;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
	animation.fillMode = kCAFillModeForwards;
	animation.endProgress = 1;
	animation.removedOnCompletion = NO;
    animation.type = @"pageUnCurl";
    [self.view.layer addAnimation:animation forKey:@"animation"];
}

-(void) doCATransitionCurl
{
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = 0.5f * 1;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
	animation.fillMode = kCAFillModeForwards;
	animation.endProgress = 1;
	animation.removedOnCompletion = NO;
    animation.type = @"pageCurl";
    [self.view.layer addAnimation:animation forKey:@"animation"];
}

-(void) doCATransitionSuckEffect
{
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = 0.5f * 1;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
	animation.fillMode = kCAFillModeForwards;
	animation.endProgress = 1;
	animation.removedOnCompletion = NO;
    animation.type = @"suckEffect";
    animation.subtype = kCATransitionFromTop;
    [self.view.layer addAnimation:animation forKey:@"animation"];
}

-(void) doCameraIrisHollowClose
{
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = 0.5f * 1;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
	animation.fillMode = kCAFillModeForwards;
	animation.endProgress = 1;
	animation.removedOnCompletion = NO;
    animation.type = @"rippleEffect";
    [self.view.layer addAnimation:animation forKey:@"animation"];
}

@end

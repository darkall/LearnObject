//
//  CustomSetViewViewController.m
//  LearnObjects
//
//  Created by Liu zhongqiang on 9/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CustomSetViewViewController.h"
#import "PicChoiceView.h"

@interface CustomSetViewViewController ()

@end

@implementation CustomSetViewViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withRect:(CGRect) rect
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        mRect = rect;
        mPickView = [[PicChoiceView alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    NSString* filePath1 = [[NSBundle mainBundle] pathForResource:@"intr.png" ofType:nil];
    //NSString* filePath2 = [[NSBundle mainBundle] pathForResource:@"twoFingerTap.gif" ofType:nil];
    
    mIntroView = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:filePath1]];
    //SCGIFImageView *gifView2 = [[SCGIFImageView alloc] initWithGIFFile:filePath2];
    mIntroView.frame = CGRectMake(0, 0, mIntroView.image.size.width, mIntroView.image.size.height);
    
    //gifView2.frame = CGRectMake(0, gifView1.image.size.height, gifView1.image.size.width, gifView2.image.size.height);
    mPickView.view.frame = CGRectMake(mPickView.view.frame.origin.x
                                 , mRect.size.height/3, mPickView.view.frame.size.width,mPickView.view.frame.size.height);
    [self.view addSubview:mIntroView];
    [self.view addSubview:mPickView.view];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void) SaveImageToLocal{
    [mPickView SaveImageToLocal];
}

-(IBAction) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if([[event allTouches] count] >= 2)
        [self.view.superview.nextResponder touchesEnded:touches withEvent:event];
}
@end

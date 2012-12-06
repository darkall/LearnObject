//
//  ExtUIView.m
//  LearnObjects
//
//  Created by Liu zhongqiang on 8/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ExtUIView.h"
#define kImageWidth		 512.0
#define kImageHeight	 385.0

@implementation ExtUIView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        mColors = [[NSArray alloc] initWithObjects:@"red.png",@"pink.png",@"sky.png",@"blue.png",@"purple.png",@"yellow.png",@"green.png",@"orange.png",nil ];
        mPoint =[[NSMutableArray alloc] init];
        NSValue *value;
        CGRect rect = CGRectMake(0, 0, kImageWidth, kImageHeight);   
        value = [NSValue valueWithBytes:&rect objCType:@encode(CGRect)];
        [mPoint addObject:value];
        rect = CGRectMake(kImageWidth, 0, kImageWidth, kImageHeight);   
        value = [NSValue valueWithBytes:&rect objCType:@encode(CGRect)];
        [mPoint addObject:value];
        rect = CGRectMake(0, kImageHeight, kImageWidth, kImageHeight);   
        value = [NSValue valueWithBytes:&rect objCType:@encode(CGRect)];
        [mPoint addObject:value];
        rect = CGRectMake(kImageWidth, kImageHeight, kImageWidth, kImageHeight);   
        value = [NSValue valueWithBytes:&rect objCType:@encode(CGRect)];
        [mPoint addObject:value];
    }
    return self;
}

// Timer event is called whenever the timer fires
- (void)onTimer
{
    int disX = round(random() % 300);
    int disY = round(random() % 80);
    int startX = 300+disX;
    int startY = 550+disY;

    NSInteger index = random()%8;
    UIImage *flakeImage = [UIImage imageNamed:[mColors objectAtIndex:index]];
	UIImageView* flakeView = [[UIImageView alloc] initWithImage:flakeImage];

	// use the random() function to randomize up our flake attributes
	
	int endX = round(random() % 700)+100;
    
	double scale = round(random() % 2)/10 + 0.60;
	double speed = round(random() % 5)/10 + 1.0;

	// set the flake start position
	flakeView.frame = CGRectMake(startX, startY, 81.0 * scale, 105.0 * scale);
	flakeView.alpha = 0.85;
	
	// put the flake in our main view
	[self addSubview:flakeView];
	
	[UIView beginAnimations:nil context:(void*)flakeView];
	// set up how fast the flake will fall
	[UIView setAnimationDuration:4 * speed];
	
	// set the postion where flake will move to
	flakeView.frame = CGRectMake(endX, -200.0, 81.0 * scale, 105.0 * scale);
    flakeView.alpha = 0.65;

	// set a stop callback so we can cleanup the flake when it reaches the
	// end of its animation
	[UIView setAnimationDidStopSelector:@selector(onAnimationComplete:finished:context:)];
	[UIView setAnimationDelegate:self];
	[UIView commitAnimations];
}

- (void)onAnimationComplete:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
	
	UIImageView *flakeView = (__bridge UIImageView*)context;
	[flakeView removeFromSuperview];
}

- (void)onError
{
	// build a view from our flake image
    UIImage *flakeImage = [UIImage imageNamed:@"error.png"];
	UIImageView* flakeView = [[UIImageView alloc] initWithImage:flakeImage];
    
	// use the random() function to randomize up our flake attributes
	
	// set the flake start position
    NSValue *value = [mPoint objectAtIndex:mSelectIndex];
    CGRect rect;
    [value getValue:&rect];
	flakeView.frame = rect;
	flakeView.alpha = 1.0;
	
	// put the flake in our main view
	[self addSubview:flakeView];
	
	[UIView beginAnimations:nil context:(void*)flakeView];
	// set up how fast the flake will fall
	[UIView setAnimationDuration:1.5];
	flakeView.alpha = 0.0;
	// set a stop callback so we can cleanup the flake when it reaches the
	// end of its animation
	[UIView setAnimationDidStopSelector:@selector(onErrorComplete:finished:context:)];
//    [UIView setAnimationRepeatCount:20];
	[UIView setAnimationDelegate:self];
	[UIView commitAnimations];
}

- (void)onErrorComplete:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
	
	UIImageView *flakeView = (__bridge UIImageView*)context;
	[flakeView removeFromSuperview];
}

-(void) examViewLoad:(NSString*) category 
        locationIndex:(NSInteger) index
{
    NSMutableArray *num = [NSMutableArray arrayWithObjects:@"",@"",@"",@"", nil];
    NSInteger randNum;
    if([category isEqualToString:@"alphabet"])
       randNum = 26;
    else
       randNum=10;
       
    NSInteger other1,other2,other3;
    while(true){
        other1 = arc4random()%randNum;
        if(index==other1) 
            continue;
        else {
            while(true){
                other2 = arc4random()%randNum;
                if(index==other2||other1==other2) 
                    continue;
                else {
                    while(true){
                        other3 = arc4random()%randNum;
                        if(index==other3||other1==other3||other2==other3) 
                            continue;
                        else
                            break;
                    }
                    break;  
                }
            }
            break;
        }
    }
    
    mCurPicIndex = arc4random()%4;
    NSInteger location1,location2,location3;
    while(true){
        location1 = arc4random()%4;
        if(mCurPicIndex==location1) 
            continue;
        else {
            while(true){
                location2 = arc4random()%4;
                if(mCurPicIndex==location2||location1==location2) 
                    continue;
                else {
                    while(true){
                        location3 = arc4random()%4;
                        if(mCurPicIndex==location3||location1==location3||location2==location3) 
                            continue;
                        else
                            break;
                    }
                    break;  
                }
            }
            break;
        }
    }

    NSString* randStr;
    for(NSInteger i=0;i<4;i++){
        if (i==location1)
           randStr = [NSString stringWithFormat:@"%@%d.jpg",category,other1];
        else if(i==location2)
            randStr = [NSString stringWithFormat:@"%@%d.jpg",category,other2];
        else if(i==location3)
            randStr = [NSString stringWithFormat:@"%@%d.jpg",category,other3];
        else if(i==mCurPicIndex)
            randStr = [NSString stringWithFormat:@"%@%d.jpg",category,index];
        [num replaceObjectAtIndex:i withObject:randStr];
    }
        
    CGRect tmpRect = self.frame;
    tmpRect.size.width = self.frame.size.width/2-2;
    tmpRect.size.height = self.frame.size.height/2-2;
    for(NSInteger i=1;i<5;i++){
        tmpRect.origin.x = tmpRect.size.width*((i-1)%2);
        if ((i-1)%2)
            tmpRect.origin.x = tmpRect.size.width*((i-1)%2)+3;
        
        if(i>=3)
            tmpRect.origin.y = (self.frame.size.height/2)+1;
        UIImageView* imgView=[[UIImageView alloc] initWithFrame:tmpRect];
        UIImage *img = [UIImage imageNamed:[num objectAtIndex:i-1]];
        [imgView setImage:img];
        [self addSubview:imgView];
    }
    [self setBackgroundColor:[UIColor blackColor]];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [[event allTouches] anyObject];
	CGPoint point = [touch locationInView:self];
	mFirstPoint = point;
	mTouchMove = NO;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [touches anyObject];
	CGPoint point = [touch locationInView:self];
	mSecondPoint = point;
	mTouchMove = YES;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    if([[event allTouches] count] >= 2)
        return;
    
    UITouch *touch = [[event allTouches] anyObject];

    CGPoint touchPoint = [touch locationInView:[touch view]];
    CGFloat x,y,width,height;
    x=touchPoint.x;
    y=touchPoint.y;
    width=self.frame.size.width/2-2;
    height=self.frame.size.height/2-2;
	if(mTouchMove == NO){
        
        mSelectIndex=0;
        
        if(x<width && y<height)
            mSelectIndex = 0;
        else if((x>width && x<2*width)&&y<height)
            mSelectIndex = 1;
        else if(x<width && (y>height && y<2*height))
            mSelectIndex = 2;
        else if((x>width && x<2*width) && (y>height && y<2*height) )
            mSelectIndex = 3;
        
        if(mSelectIndex == mCurPicIndex){
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:
//                                  @"you are right!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//            [alert show];
            for (NSInteger i=0; i<19; i++) {
                [NSTimer scheduledTimerWithTimeInterval:(0.1) target:self selector:@selector(onTimer) userInfo:nil repeats:NO];
            }
        } else {
            [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(onError) userInfo:nil repeats:
             NO];
        }

	}
}

@end

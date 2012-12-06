//
//  ExtUIScrollView.m
//  LearnObjects
//
//  Created by Liu zhongqiang on 6/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ExtUIScrollView.h"
#import "ExtUIView.h"

@implementation ExtUIScrollView

- (id)initWithFrame:(CGRect)frame withCategroy:(NSString*) categroy
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        mCurCategroy = categroy;
    }
    return self;
}

-(void) clipScollViewLoad
{
    // 1. setup the scrollview for multiple images and add it to the view controller
	// note: the following can be done in Interface Builder, but we show this in code for clarity
	[self setBackgroundColor:[UIColor whiteColor]];
	[self setCanCancelContentTouches:NO];
	self.indicatorStyle = UIScrollViewIndicatorStyleWhite;
	self.clipsToBounds = YES;		// default is NO, we want to restrict drawing within our scrollview
	self.scrollEnabled = YES;
	
	// pagingEnabled property default is NO, if set the scroller will stop or snap at each photo
	// if you want free-flowing scroll, don't set this property.
	self.pagingEnabled = YES;
    
    [self loadImages:mCurCategroy];
    [self layoutScrollImages];
}

- (void)loadImages: (NSString*) categoryName
{
    if([categoryName isEqualToString:@"alphabet"])
        mRandNum = 26;
    else
        mRandNum=10;
    
    for(NSInteger i=0;i<mRandNum;i++){
        NSString *imageName = [NSString stringWithFormat:@"%@%d.jpg",categoryName,i];
        UIImage *image = [UIImage imageNamed:imageName];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.frame ];
        [imageView setImage:image];
        [imageView setUserInteractionEnabled:YES];
        imageView.tag = i+1;
        [self addSubview:imageView];
    }
}

- (void) layoutScrollImages
{
	UIImageView *view = nil;
	NSArray *subviews = [self subviews];
    
	// reposition all image subviews in a horizontal serial fashion
	CGFloat curXLoc = 0;
	for (view in subviews){
		if ([view isKindOfClass:[UIImageView class]] && view.tag >0){
			CGRect frame = view.frame;
			frame.origin = CGPointMake(curXLoc, 0);
			view.frame = frame;
			curXLoc += (self.frame.size.width);
		}
	}
	
	// set the content size so it can be scrollable
	[self setContentSize:CGSizeMake((mRandNum* self.frame.size.width), self.frame.size.height)];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
	UITouch *touch = [[event allTouches] anyObject];
	CGPoint point = [touch locationInView:self];
	mFirstPoint = point;
	mTouchMove = NO;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
	UITouch *touch = [touches anyObject];
	CGPoint point = [touch locationInView:self];
	mSecondPoint = point;
	mTouchMove = YES;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    if([[event allTouches] count] >= 2)
        return;
    
	if(mTouchMove == NO){
        [self.superview.nextResponder touchesEnded:touches withEvent:event];
	} 
}

@end

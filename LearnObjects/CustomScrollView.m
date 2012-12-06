//
//  CustomScrollView.m
//  LearnObjects
//
//  Created by Nuo Yang on 8/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CustomScrollView.h"
#import "LocalImageManager.h"

@implementation CustomScrollView

- (id)initWithFrame:(CGRect)frame with:(UIView*) setView
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        mImageCenter = [LocalImageManager sharedManager];
        mSetView = setView;
        mImgArray = [[NSMutableArray alloc] init];
        isHavePic = NO;
        [self setBackgroundColor:[UIColor whiteColor]];
        [self setCanCancelContentTouches:NO];
        self.indicatorStyle = UIScrollViewIndicatorStyleWhite;
        self.clipsToBounds = YES;		// default is NO, we want to restrict drawing within our scrollview
        self.scrollEnabled = YES;
        
        // pagingEnabled property default is NO, if set the scroller will stop or snap at each photo
        // if you want free-flowing scroll, don't set this property.
        self.pagingEnabled = YES;
        
        [self isHavePics];
        [self checkView];
    }
    return self;
}

-(void)updateData
{
    mImageCenter = [LocalImageManager sharedManager];
    [self isHavePics];
    [self checkView];
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
	[self setContentSize:CGSizeMake(([mImgArray count]* self.frame.size.width), self.frame.size.height)];
}

-(void) setScrollImage{
    NSArray *subView = [self subviews];
    for(NSInteger i=0;i<[subView count]; i++){
        if ([[subView objectAtIndex:i] tag]==10+i) {
            [[subView objectAtIndex:i] removeFromSuperview];
        }
    }

    for(NSInteger i=0;i<[mImgArray count];i++){
        UIImageView* imgView=[[UIImageView alloc] initWithFrame:self.frame];
        [imgView setUserInteractionEnabled:YES];
        imgView.tag = 10+i;
        imgView.image = [mImgArray objectAtIndex:i];
        [self addSubview:imgView];
    }
}

-(BOOL) isHavePics
{
    [mImgArray removeAllObjects];
    isHavePic = NO;
    for(NSInteger i=0;i<10;i++){
        NSString *tmpName = [NSString stringWithFormat: @"LearnObject%d", i];
        if([mImageCenter LocalHaveImage:tmpName]){
            [mImgArray addObject:[mImageCenter GetImageFromLocal:tmpName]];
            isHavePic = YES;
        }
    }
    return isHavePic;
}
    
-(void) checkView
{    
    if(isHavePic){
        [self setScrollImage];
        [self layoutScrollImages];
    }
    else {
        UIImageView* imgView=[[UIImageView alloc] initWithFrame:self.frame];
        [imgView setUserInteractionEnabled:YES];
        imgView.tag = 99;
        imgView.image = [UIImage imageNamed:@"icon5.jpg"]; 
        [self addSubview:imgView];
    }
}

-(NSArray*) getImages{
    return mImgArray;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    if([[event allTouches] count] >= 2)
        return;
	if(!isHavePic){
        [self.superview bringSubviewToFront:mSetView];
        NSArray *subView = [self subviews];
        for(NSInteger i=0;i<[subView count]; i++){
            if ([[subView objectAtIndex:i] tag]==99) {
                [[subView objectAtIndex:i] removeFromSuperview];
            }
        }
        [self.superview setTag:5];
	}
    else {
        [self.superview.nextResponder touchesEnded:touches withEvent:event];
    }
}

@end

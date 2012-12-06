//
//  ImagePicker.m
//  ImagePicker
//
//  Created by Liu zhongqiang on 8/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ImagePickView.h"

@interface ImagePickView(private)
- (void) openPhotoLibrary:(UIControl*)sender;
-(UIImage*) getImage;
@end


@implementation ImagePickView
- (id)initWithFrame:(CGRect)frame 
{
    if ((self = [super initWithFrame:frame])) 
	{
		self.userInteractionEnabled = YES;

        mPickController  = [[UIImagePickerController alloc] init];
		mPickController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
		mPickController.delegate = self;
		mPickController.allowsEditing = YES;
		mPickController.wantsFullScreenLayout = YES;
		[self setBackgroundColor:[UIColor whiteColor]];
		mPopoverView = [[UIPopoverController alloc] initWithContentViewController:mPickController];	
		[mPopoverView setPopoverContentSize:CGSizeMake(200,200) animated:YES];//size
	}
	return self;
}
#pragma mark -
#pragma mark self action

- (void) openPhotoLibrary:(UIControl*)sender
{
    [mPopoverView presentPopoverFromRect:CGRectMake(0,0,10,10)//eject position
										  inView:self 
						permittedArrowDirections:UIPopoverArrowDirectionAny//eject direction 
										animated:YES];
	return;
	
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.superview touchesBegan:touches withEvent:event];
}

#pragma mark -
#pragma mark picker delegate
- (void) imagePickerController:(UIImagePickerController*)picker didFinishPickingImage:(UIImage*)image editingInfo:(NSDictionary*)editingInfo
{
	[mPopoverView dismissPopoverAnimated:YES];
    self.image = image;
    
	//!  picker == mPickController, they are the same one!
	[picker dismissModalViewControllerAnimated:YES];
	[picker.view removeFromSuperview];
    
	[mPopoverView dismissPopoverAnimated:YES];
}

-(UIImage*) getImage
{
    return self.image;
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
	
	[mPickController dismissModalViewControllerAnimated:YES];
	[mPickController.view removeFromSuperview];	
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
}
#pragma mark -
#pragma mark dealloc
- (void)dealloc
{
}

@end
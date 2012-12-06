//
//  ImagePicker.h
//  ImagePicker
//
//  Created by Liu zhongqiang on 8/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface ImagePickView : UIImageView<UINavigationControllerDelegate, UIImagePickerControllerDelegate> 
{
	UIImagePickerController	*mPickController;
	UIPopoverController		*mPopoverView;
}

-(void) openPhotoLibrary:(UIControl*)sender;
@end

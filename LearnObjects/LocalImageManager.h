//
//  LocalImageManager.h
//  LearnObjects
//
//  Created by Liu zhongqiang on 8/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocalImageManager : NSObject {
}

+ (id)sharedManager;
-(void)SaveImageToLocal:(UIImage*)image Keys:(NSString*)key;
-(BOOL)LocalHaveImage:(NSString*)key;
-(UIImage*)GetImageFromLocal:(NSString*)key;
-(void) resetUserDefaults;
-(void) removeObject:(NSString*) key;
@end

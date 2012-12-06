//
//  LocalImageManager.m
//  LearnObjects
//
//  Created by Liu zhongqiang on 8/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LocalImageManager.h"

static LocalImageManager *sharedMyDataCenter = nil;
    
@implementation LocalImageManager

#pragma mark Singleton Methods
+ (id)sharedManager {
    @synchronized(self) {
        if(sharedMyDataCenter == nil)
        sharedMyDataCenter = [[super allocWithZone:NULL] init];
    }
    return sharedMyDataCenter;
}

-(void)SaveImageToLocal:(UIImage*)image Keys:(NSString*)key {
    NSUserDefaults* preferences = [NSUserDefaults standardUserDefaults];
    [preferences setObject:UIImagePNGRepresentation(image) forKey:key];
    [preferences synchronize];
}

-(BOOL)LocalHaveImage:(NSString*)key {
    NSUserDefaults* preferences = [NSUserDefaults standardUserDefaults];
    NSData* imageData = [preferences objectForKey:key];
    if (imageData) {
        return YES;
    }
    return NO;
}

-(UIImage*)GetImageFromLocal:(NSString*)key {
    NSUserDefaults* preferences = [NSUserDefaults standardUserDefaults];
    NSData* imageData = [preferences objectForKey:key];
    UIImage* image;
    if (imageData) {
        image = [UIImage imageWithData:imageData];
    }
    else {
    }
    return image;
}

-(void) removeObject:(NSString*) key{
    NSUserDefaults* preferences = [NSUserDefaults standardUserDefaults];
    [preferences removeObjectForKey:key];
    [preferences synchronize];
}

-(void) resetUserDefaults{
    [NSUserDefaults resetStandardUserDefaults];
}
@end

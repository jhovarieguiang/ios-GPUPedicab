//
//  GPUPedicab.h
//  GPUPedicabTest
//
//  Created by Jhovarie on 2/1/17.
//  Copyright © 2017 3DMe Player. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "GPUImagePicture.h"
#import <Foundation/Foundation.h>
#import "GPUPedicabCustomFilter.h"
#import "GPUPedicabCustomFilterTwoTexture.h"

@interface GPUPedicab : NSObject
     +(UIImage *) alphaMask :(UIImage *)inputimage : (UIImage *)maskimage;
@end

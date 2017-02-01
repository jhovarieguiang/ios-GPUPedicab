//
//  ImageLib.h
//  UIImageLIb
//
//  Created by Jhovarie on 1/25/17.
//  Copyright © 2017 3DMe Player. All rights reserved.
//

#import <UIkit/UIkit.h>
#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface ImageLib : NSObject
+(UIImage *) scaleToSize :(UIImage *) img :(int)width :(int) height;
+(UIImage *) scaleImageWidth: (UIImage*) sourceImage : (float) i_width;
+(NSData *) convertImagetoNSData :(UIImage *) image;
+(UIImage *) convertNSDatatoUIImage :(NSData *) data;

+(UIImage *)zoomCrop :(UIImage*) input :(int) newwidth :(int)newheight;
+(UIImage *)maskImage: (UIImage *)inputImage : (UIImage *)maskguide;
+(UIImage*) recreateImage :(UIImage *)inputimage;

+(UIImage *) convertLandscapeToPortrait : (UIImage *) portraitimage;
+(UIImage *) convertPortraitToLandscape : (UIImage *) landscapeimage;
+(UIImage*) comBinedTwoImage:(UIImage*) fgImage
                     inImage:(UIImage*) bgImage
                     atPoint:(CGPoint)  point;
+(UIImage *) comBinedTwoImageWithAlpha :(UIImage*)firstImage : (UIImage*)secondImage ;
+ (NSMutableArray *) getMPOResults : (NSString *) mpofilesource;
+(UIImage *)rotateImage:(UIImage*)src byRadian:(CGFloat)radian;
+(void) saveImageToDocument :(UIImage *)image : (NSString *)filename;
+(UIImage *)loadUIImageFromAppDocument : (NSString *)filename;
+(void) saveImageToGallery :(UIImage *) image;
@end

//
//  ImageLib.m
//  UIImageLIb
//
//  Created by Jhovarie on 1/25/17.
//  Copyright © 2017 3DMe Player. All rights reserved.
//

#import "ImageLib.h"

@implementation ImageLib

+ (UIImage *)scaleToSize :(UIImage *) img :(int)width :(int) height
{
    //CGSize cg = CGSizeMake(100, 100);
    UIImage *newImage = nil;
    CGFloat targetWidth = width;
    CGFloat targetHeight = height;
    
    CGContextRef bitmap = CGBitmapContextCreate(NULL,
                                                targetWidth,
                                                targetHeight,
                                                CGImageGetBitsPerComponent(img.CGImage),
                                                4 * targetWidth, CGImageGetColorSpace(img.CGImage),
                                                (CGBitmapInfo)kCGImageAlphaNoneSkipLast);
    CGContextDrawImage(bitmap, CGRectMake(0, 0, targetWidth, targetHeight), img.CGImage);
    CGImageRef ref = CGBitmapContextCreateImage(bitmap);
    newImage = [UIImage imageWithCGImage:ref];
    if(newImage == nil) NSLog(@"could not scale image");
    CGContextRelease(bitmap);
    return newImage ;
}

+(UIImage*)scaleImageWidth: (UIImage*) sourceImage : (float) i_width
{
    UIImage *resultimage = nil;
    float oldWidth = sourceImage.size.width;
    float scaleFactor = i_width / oldWidth;
    float newHeight = sourceImage.size.height * scaleFactor;
    float newWidth = oldWidth * scaleFactor;
    UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight));
    [sourceImage drawInRect:CGRectMake(0, 0, newWidth, newHeight)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    resultimage = newImage;
    return resultimage;
}

+(NSData *) convertImagetoNSData :(UIImage *) image{
    //NSData *imageData = UIImagePNGRepresentation(yourImage);
    return UIImagePNGRepresentation(image);
}

+(UIImage *) convertNSDatatoUIImage :(NSData *) data {
    //UIImage *image = [[UIImage alloc]initWithData:yourData];
    return [[UIImage alloc]initWithData:data];
}

+(UIImage *)zoomCrop :(UIImage*) input :(int) newwidth :(int)newheight {
    //input = [self imagescaleWith:input :3600];
    UIImage *image = nil;
    CGSize newImageSize = CGSizeMake(newwidth , newheight);
    input = [self imagescaleWith2 :input :newwidth :newheight];
    
    UIGraphicsBeginImageContext(newImageSize);
    int wadj = newImageSize.width - input.size.width;
    int hadj = newImageSize.height - input.size.height;
    [input drawAtPoint:CGPointMake(roundf( wadj / 2 ),
                                   roundf( hadj / 2))];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+(UIImage*)imagescaleWith2: (UIImage*) sourceImage : (float) i_width :(int) adjust_uptoheight
{
    UIImage *resultimage = nil;
    float oldWidth = sourceImage.size.width;
    float scaleFactor = i_width / oldWidth;
    float newHeight = sourceImage.size.height * scaleFactor;
    float newWidth = oldWidth * scaleFactor;
    for(int i = 0; i < 100000; i+=10) {
        if(newHeight >= adjust_uptoheight) {
            break;
        }
        i_width++;
        oldWidth = sourceImage.size.width;
        scaleFactor = i_width / oldWidth;
        newHeight = sourceImage.size.height * scaleFactor;
        newWidth = oldWidth * scaleFactor;
    }
    
    UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight));
    [sourceImage drawInRect:CGRectMake(0, 0, newWidth, newHeight)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    resultimage = newImage;
    return resultimage;
}

+(UIImage *)maskImage: (UIImage *)inputImage : (UIImage *)maskguide {
    //UIImage *inputImage = [UIImage imageNamed:@"inputImage.png"];
    CGImageRef maskRef = maskguide.CGImage;
    
    CGImageRef mask = CGImageMaskCreate(CGImageGetWidth(maskRef),
                                        CGImageGetHeight(maskRef),
                                        CGImageGetBitsPerComponent(maskRef),
                                        CGImageGetBitsPerPixel(maskRef),
                                        CGImageGetBytesPerRow(maskRef),
                                        CGImageGetDataProvider(maskRef), NULL, false);
    
    CGImageRef masked = CGImageCreateWithMask([inputImage CGImage], mask);
    CGImageRelease(mask);
    UIImage *maskedImage = [UIImage imageWithCGImage:masked];
    
    CGImageRelease(masked);
    return maskedImage;
}

+(UIImage*) recreateImage :(UIImage *)inputimage {
    UIImage *image2 = nil;
    CGSize newImageSize;
    newImageSize = CGSizeMake(inputimage.size.width, inputimage.size.height);
    UIGraphicsBeginImageContext(newImageSize);
    [inputimage drawAtPoint:CGPointMake(roundf(0),0)];
    image2 = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image2;
}

-(UIImage *) convertLandscapeToPortrait : (UIImage *) portraitimage {
    /*UIImage * PortraitImage = [[UIImage alloc] initWithCGImage: portraitimage.CGImage
     scale: 1.0
     orientation: UIImageOrientationLeft];
     */
    UIImage * PortraitImage = [[UIImage alloc] initWithCGImage: portraitimage.CGImage
                                                         scale: 1.0
                                                   orientation: UIImageOrientationRight];
    return PortraitImage;
}

+(UIImage *) convertPortraitToLandscape : (UIImage *) landscapeimage {
    UIImage * LandscapeImage = [[UIImage alloc] initWithCGImage: landscapeimage.CGImage
                                                          scale: 1.0
                                                    orientation: UIImageOrientationLeft];
    return LandscapeImage;
}


+(UIImage*) comBinedTwoImage:(UIImage*) fgImage
              inImage:(UIImage*) bgImage
              atPoint:(CGPoint)  point
{
    UIGraphicsBeginImageContextWithOptions(bgImage.size, FALSE, 0.0);
    [bgImage drawInRect:CGRectMake( 0, 0, bgImage.size.width, bgImage.size.height)];
    [fgImage drawInRect:CGRectMake( point.x, point.y, fgImage.size.width, fgImage.size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+(UIImage*)comBinedTwoImageWithAlpha :(UIImage*)firstImage : (UIImage*)secondImage  {
    UIGraphicsBeginImageContext(firstImage.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSaveGState(context);
    //UIGraphicsPushContext(context);
    
    CGContextTranslateCTM(context, 0, firstImage.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGRect rect = CGRectMake(0, 0, firstImage.size.width, firstImage.size.height);
    // draw white background to preserve color of transparent pixels
    CGContextSetBlendMode(context, kCGBlendModeDarken);
    [[UIColor whiteColor] setFill];
    CGContextFillRect(context, rect);
    
    CGContextSaveGState(context);
    //UIGraphicsPushContext(context);
    CGContextRestoreGState(context);
    
    // draw original image
    CGContextSetBlendMode(context, kCGBlendModeDarken);
    CGContextDrawImage(context, rect, firstImage.CGImage);
    
    // tint image (loosing alpha) - the luminosity of the original image is preserved
    CGContextSetBlendMode(context, kCGBlendModeDarken);
    //CGContextSetAlpha(context, .85);
    [[UIColor colorWithPatternImage:secondImage] setFill];
    CGContextFillRect(context, rect);
    
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGContextSaveGState(context);
    CGContextRestoreGState(context);
    
    // mask by alpha values of original image
    CGContextSetBlendMode(context, kCGBlendModeDestinationIn);
    CGContextDrawImage(context, rect, firstImage.CGImage);
    
    // image drawing code here
    CGContextRestoreGState(context);
    UIImage *coloredImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    /* NSString *systemversion = [DeviceDetect getSystemVersion];
    if([systemversion isEqualToString:@"9.2.1"]) { //iphone 6s puti
        // CGContextRelease(context);
    }
    */
   // return [self recreateImage:coloredImage];
    return coloredImage;
}

+(NSMutableArray *) getMPOResults : (NSString *) mpofilesource {
    NSMutableArray *mpoextractedfileoutput = [[NSMutableArray alloc] init];
    NSString *outputtargetdir = @""; //[documentsDirectory stringByAppendingPathComponent:@""];
    //outputtargetdir = @""; // barik solve
    char c;
    int views = 0;  // number of views (JPG components)
    long length;    // total length of file
    size_t amount;  // amount read
    char* buffer;
    char* fnm;
    char* fnmbase;
    
    // NSString *s = @"Some string";
    //char *c2 = [s UTF8String];
    //fnmbase = [s UTF8String];
    
    // fnm = mpofilesource;
    fnm = [mpofilesource UTF8String];
    //fnmbase = strdup(mpofilesource);
    fnmbase = strdup([mpofilesource UTF8String]);
    char* ext = strstr(fnmbase,".mpo");
    if (ext != NULL) {
        ext[0] = '\0';
    }
    
    FILE* f = fopen(fnm,"rb");
    if (f==NULL) {
        fprintf(stderr,"error opening file \"%s\"\n",fnm);
        //return 1;
    }
    // obtain file size:
    fseek(f, 0, SEEK_END);
    length = ftell(f);
    rewind(f);
    buffer = (char*) malloc (sizeof(char)*length);
    if (buffer == NULL) {
        fprintf(stderr,"failed to allocate memory\n");
        //return 2;
    } else {
        fprintf(stdout,"Allocated %ld chars of memory.\n",length);
    }
    amount = fread(buffer,1,length,f);
    if (amount != length) {
        fprintf(stderr,"error loading file\n");
        //return 3;
    }
    fclose(f);
    char* view = buffer;
    char* last = NULL;
    char* wnm = (char*) malloc(256);
    
    while (view < buffer+length-4) {
        if (((char) view[0] % 255) == (char) 0xff) {
            if (((char) view[1] % 255) == (char) 0xd8) {
                if (((char) view[2] % 255) == (char) 0xff) {
                    if (((char) view[3] % 255) == (char) 0xe1) {
                        views++;
                        if (last != NULL) {
                            sprintf(wnm, "%s.v%d.jpg", fnmbase, views-1);
                            NSString *wnm2 = [NSString stringWithUTF8String: wnm];
                            NSString *wnm3 = [outputtargetdir stringByAppendingString:wnm2];
                            FILE* w = fopen(wnm3.UTF8String, "wb");
                            fwrite(last, 1, view-last, w); //<-- barik error from here
                            fclose(w);
                            fprintf(stdout, "Created1 %s\n",wnm);
                            [mpoextractedfileoutput addObject:[NSString stringWithUTF8String:wnm]];
                        }
                        last = view;
                        view+=4;
                    } else {
                        view+=2;
                    }
                } else {
                    view+=3;
                }
            } else {
                view+=1;
            }
        } else {
            view+=1;
        }
    }
    if (views > 1) {
        sprintf(wnm, "%s.v%d.jpg", fnmbase, views);
        NSString *wnm2 = [NSString stringWithUTF8String: wnm];
        NSString *wnm3 = [outputtargetdir stringByAppendingString:wnm2];
        FILE* w = fopen(wnm3.UTF8String, "wb");
        fwrite(last, 1, buffer+length-last, w); //<-- barik error from here
        fclose(w);
        fprintf(stdout, "Created2 %s\n",wnm);
        [mpoextractedfileoutput addObject:[NSString stringWithUTF8String:wnm]];
    } else
        if (views == 0) {
            fprintf(stdout, "No views found.\n");
        }
    free(wnm);
    free(buffer);
    return mpoextractedfileoutput;
}


+(UIImage *)rotateImage:(UIImage*)src byRadian:(CGFloat)radian
    {
        // calculate the size of the rotated view's containing box for our drawing space
        UIView *rotatedViewBox = [[UIView alloc] initWithFrame:CGRectMake(0,0, src.size.width, src.size.height)];
        CGAffineTransform t = CGAffineTransformMakeRotation(radian);
        rotatedViewBox.transform = t;
        CGSize rotatedSize = rotatedViewBox.frame.size;
        
        // Create the bitmap context
        UIGraphicsBeginImageContext(rotatedSize);
        CGContextRef bitmap = UIGraphicsGetCurrentContext();
        
        // Move the origin to the middle of the image so we will rotate and scale around the center.
        CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);
        
        //   // Rotate the image context
        CGContextRotateCTM(bitmap, radian);
        
        // Now, draw the rotated/scaled image into the context
        CGContextScaleCTM(bitmap, 1.0, -1.0);
        CGContextDrawImage(bitmap, CGRectMake(-src.size.width / 2, -src.size.height / 2, src.size.width, src.size.height), [src CGImage]);
        
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return newImage;
    }
    
+(void) saveImageToDocument :(UIImage *)image : (NSString *)filename{
    // UIImage *image = ...;
    //NSString  *path = @"";
    //[UIImageJPEGRepresentation(image, 1.0) writeToFile:path atomically:YES];
    
    NSString *path = [NSString stringWithFormat:@"Documents/%@",filename];
    NSString  *pngPath = [NSHomeDirectory() stringByAppendingPathComponent:path];
    //NSString  *pngPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Test.png"];
    [UIImagePNGRepresentation(image) writeToFile:pngPath atomically:YES];
}

+(UIImage *)loadUIImageFromAppDocument : (NSString *)filename{
    NSArray  *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir  = [documentPaths objectAtIndex:0];
    NSString  *pngfile = [documentsDir stringByAppendingPathComponent:filename];
    NSData *imgData = [NSData dataWithContentsOfFile:pngfile];
    UIImage *thumbNail = [[UIImage alloc] initWithData:imgData];
    return thumbNail;
}

+(void) saveImageToGallery :(UIImage *) image {
        ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
        [library writeImageToSavedPhotosAlbum:[image CGImage] orientation:(ALAssetOrientation)[image imageOrientation] completionBlock:^(NSURL *assetURL, NSError *error){
            if (error) {
            } else {
            }
        }];
}

@end

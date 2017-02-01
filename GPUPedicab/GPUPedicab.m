//
//  GPUPedicab.m
//  GPUPedicabTest
//
//  Created by Jhovarie on 2/1/17.
//  Copyright © 2017 3DMe Player. All rights reserved.
//

#import "GPUPedicab.h"

@implementation GPUPedicab
    
+(UIImage *) alphaMask :(UIImage *)inputimage : (UIImage *)maskimage {
   /* NSString *const fragmentshader = SHADER_STRING
    (
     varying highp vec2 textureCoordinate;
     varying highp vec2 textureCoordinate2;
     
     uniform sampler2D inputImageTexture;
     uniform sampler2D inputImageTexture2;
     uniform lowp float mixturePercent;
     
     void main()
    {
        lowp vec4 textureColor = texture2D(inputImageTexture, textureCoordinate);
        lowp vec4 textureColor2 = texture2D(inputImageTexture2, textureCoordinate2);
        gl_FragColor = vec4(textureColor.xyz, textureColor2.a);
    }
     );
    
    GPUPedicabCustomFilterTwoTexture *twoinputFilter = [[GPUPedicabCustomFilterTwoTexture alloc]initWithFragmentShaderFromString:fragmentshader];
    */
    GPUPedicabCustomFilterTwoTexture *twoinputFilter = [[GPUPedicabCustomFilterTwoTexture alloc]initWithFragmentShaderFromFile:@"AlphaMask"];
    GPUImagePicture *sourcePicture1 = [[GPUImagePicture alloc] initWithImage:inputimage ];
    GPUImagePicture *sourcePicture2 = [[GPUImagePicture alloc] initWithImage:maskimage ];
    twoinputFilter.mix = .5;
    [sourcePicture1 addTarget:twoinputFilter];
    [sourcePicture1 processImage];
    [twoinputFilter useNextFrameForImageCapture];
    [sourcePicture2 addTarget:twoinputFilter];
    [sourcePicture2 processImage];
    UIImage * output = [twoinputFilter imageFromCurrentFramebuffer];
    return output;
}
    
@end

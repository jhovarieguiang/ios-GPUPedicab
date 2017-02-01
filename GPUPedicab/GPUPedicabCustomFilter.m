//
//  GPUPedicabCustomFilter.m
//  GPUPedicabTest
//
//  Created by Jhovarie on 2/1/17.
//  Copyright © 2017 3DMe Player. All rights reserved.
//

#import "GPUPedicabCustomFilter.h"

#if TARGET_IPHONE_SIMULATOR || TARGET_OS_IPHONE
NSString *const kGPUImageExposureFragmentShaderString = SHADER_STRING
(
 varying highp vec2 textureCoordinate;
 
 uniform sampler2D inputImageTexture;
 uniform highp float exposure;
 //uniform highp float red;
 //uniform highp float green;
 //uniform highp float blue;
 
 void main()
 {
     highp vec4 textureColor = texture2D(inputImageTexture, textureCoordinate);
     //gl_FragColor = vec4(textureColor.rgb * pow(2.0, exposure), textureColor.w);
     highp vec4 outputColor = textureColor;
     //outputColor.r = red;
     //outputColor.g = green;
     //outputColor.b = blue;
     gl_FragColor = outputColor;
 }
 );
#else
NSString *const kGPUImageExposureFragmentShaderString = SHADER_STRING
(
 varying vec2 textureCoordinate;
 uniform sampler2D inputImageTexture;
 uniform float exposure;
 //uniform highp float red;
 //uniform highp float green;
 //uniform highp float blue;
 
 void main()
 {
     // vec4 textureColor = texture2D(inputImageTexture, textureCoordinate);
     // gl_FragColor = vec4(textureColor.rgb * pow(2.0, exposure), textureColor.w);
     highp vec4 textureColor = texture2D(inputImageTexture, textureCoordinate);
     //gl_FragColor = vec4(textureColor.rgb * pow(2.0, exposure), textureColor.w);
     highp vec4 outputColor = textureColor;
     //outputColor.r = red;
     //outputColor.g = green;
     //outputColor.b = blue;
     gl_FragColor = outputColor;
 }
 );
#endif

@implementation GPUPedicabCustomFilter
    @synthesize exposure = _exposure;
    
#pragma mark -
#pragma mark Initialization and teardown
    
- (id)init;
    {
        if (!(self = [super initWithFragmentShaderFromString:kGPUImageExposureFragmentShaderString]))
        {
            return nil;
        }
        exposureUniform = [filterProgram uniformIndex:@"exposure"];
        //redUniform = [filterProgram uniformIndex:@"red"];
        //    greenUniform = [filterProgram uniformIndex:@"green"];
        //    blueUniform = [filterProgram uniformIndex:@"blue"];
        //    alphaUniform = [filterProgram uniformIndex:@"alpha"];
        self.exposure = 0.0;
        //self.red = 0.5;
        //    self.green = 1.0;
        //    self.blue = 1.0;
        //    self.alpha = 1.0;
        //
        //  [self setFloat:_red forUniform:redUniform program:filterProgram];
        //    [self setFloat:_green forUniform:greenUniform program:filterProgram];
        //    [self setFloat:_blue forUniform:blueUniform program:filterProgram];
        //    [self setFloat:_alpha forUniform:alphaUniform program:filterProgram];
        return self;
    }
    
#pragma mark -
#pragma mark Accessors
    
- (void)setExposure:(CGFloat)newValue;
    {
        _exposure = newValue;
        
        [self setFloat:_exposure forUniform:exposureUniform program:filterProgram];
    }
    @end

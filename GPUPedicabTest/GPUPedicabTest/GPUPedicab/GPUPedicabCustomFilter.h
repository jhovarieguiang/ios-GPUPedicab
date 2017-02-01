//
//  GPUPedicabCustomFilter.h
//  GPUPedicabTest
//
//  Created by Jhovarie on 2/1/17.
//  Copyright © 2017 3DMe Player. All rights reserved.
//

//
#import <Foundation/Foundation.h>
#import "GPUImageFilter.h"

@interface GPUPedicabCustomFilter : GPUImageFilter
    {
        GLint exposureUniform;
        
        
        //GLint redUniform;
        /*GLint greenUniform;
         GLint blueUniform;
         GLint alphaUniform;
         */
    }
    
    // Exposure ranges from -10.0 to 10.0, with 0.0 as the normal level
    @property(readwrite, nonatomic) CGFloat exposure;
    //@property(readwrite, nonatomic) CGFloat red;
    //@property(readwrite, nonatomic) CGFloat green;
    //@property(readwrite, nonatomic) CGFloat blue;
    //@property(readwrite, nonatomic) CGFloat alpha;
    
    @end

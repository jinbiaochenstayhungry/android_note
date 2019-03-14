//
//  ViewController.h
//  openglesStudy
//
//  Created by coolkit on 2019/1/16.
//  Copyright © 2019 coolkit. All rights reserved.
//

#import <GLKit/GLKit.h>



@interface ViewController : GLKViewController
{
    GLuint vectorBufferID;
}

@property (nonatomic,strong) GLKBaseEffect*  baseEffect;

@end


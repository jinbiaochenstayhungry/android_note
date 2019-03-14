//
//  AGLKView.m
//  createAGLView
//
//  Created by coolkit on 2019/3/4.
//  Copyright © 2019 coolkit. All rights reserved.
//

#import "AGLKView.h"
#import <QuartzCore/QuartzCore.h>
#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>

@interface AGLKView ()

{
    GLuint defaultFrameBuffer;
    GLuint colorRenderBuffer;
}

@end

@implementation AGLKView

- (instancetype)initWithFrame:(CGRect)frame context:(EAGLContext*)context
{
    self = [super initWithFrame:frame];
    if (self) {
        CAEAGLLayer* layer = (CAEAGLLayer*)self.layer;
        layer.drawableProperties = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:NO],kEAGLDrawablePropertyRetainedBacking,kEAGLColorFormatRGBA8,kEAGLDrawablePropertyColorFormat, nil];
        self.context = context;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        CAEAGLLayer* layer = (CAEAGLLayer*)self.layer;
        layer.drawableProperties = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:NO],kEAGLDrawablePropertyRetainedBacking,kEAGLColorFormatRGBA8,kEAGLDrawablePropertyColorFormat, nil];
    }
    return self;
}

-(void)getFrameBuffer{
    
}

-(void)setContext:(EAGLContext *)context{
    if (_context != context) {
        [EAGLContext setCurrentContext:context];
        
        if (0 != defaultFrameBuffer) {
            glDeleteFramebuffers(1, &defaultFrameBuffer);
            defaultFrameBuffer = 0;
        }
        
        if (0 != colorRenderBuffer) {
            glDeleteRenderbuffers(1, &colorRenderBuffer);
            colorRenderBuffer = 0;
        }
        
        _context = context;
        
        if (nil != context) {
            _context = context;
            
            [EAGLContext setCurrentContext:context];
            
            glGenFramebuffers(1, &defaultFrameBuffer);
            glBindFramebuffer(GL_FRAMEBUFFER, defaultFrameBuffer);
            
            glGenRenderbuffers(1, &colorRenderBuffer);
            glBindRenderbuffer(GL_RENDERBUFFER, colorRenderBuffer);
            
            glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_RENDERBUFFER, colorRenderBuffer);
            
        }
    }
}

-(void)layoutSubviews{
    CAEAGLLayer* layer = (CAEAGLLayer*)self.layer;
    
    [self.context renderbufferStorage:GL_RENDERBUFFER fromDrawable:layer];
    
    glBindRenderbuffer(GL_RENDERBUFFER, colorRenderBuffer);
    GLenum status = glCheckFramebufferStatus(GL_FRAMEBUFFER);
    if (status != GL_FRAMEBUFFER_COMPLETE) {
        NSLog(@" check buffer status fail : %x",status);
    }
//    [self display];
}

-(void)display{
    [EAGLContext setCurrentContext:self.context];
    glViewport(0, 0, self.drawableWidth, self.drawableHeight);
    [self drawRect:[self bounds]];
    [self.context presentRenderbuffer:GL_RENDERBUFFER];
}

-(void)drawRect:(CGRect)rect{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(glkView:drawInRect:)]) {
        [self.delegate glkView:self drawInRect:rect];
    }
}

-(int)drawableWidth{
    GLint backingWidht;
    glGetRenderbufferParameteriv(GL_RENDERBUFFER, GL_RENDERBUFFER_WIDTH, &backingWidht);
    return (int)backingWidht;
}

-(int)drawableHeight{
    GLint backingHeight;
    glGetRenderbufferParameteriv(GL_RENDERBUFFER, GL_RENDERBUFFER_HEIGHT, &backingHeight);
    return (int)backingHeight;
}

+ (Class)layerClass{
    return [CAEAGLLayer class];
}

- (void)dealloc
{
    if ([EAGLContext currentContext] == self.context) {
        [EAGLContext setCurrentContext:nil];
    }
    self.context = nil;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

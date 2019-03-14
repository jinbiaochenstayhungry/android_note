//
//  AGLKView.h
//  createAGLView
//
//  Created by coolkit on 2019/3/4.
//  Copyright © 2019 coolkit. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class AGLKView;

@protocol AGLKViewDelegate <NSObject>

-(void)glkView:(AGLKView*)view drawInRect:(CGRect)rect;

@end

@interface AGLKView : UIView

@property (nonatomic,weak) id<AGLKViewDelegate>  delegate;
@property (nonatomic,strong) EAGLContext*  context;

@property (nonatomic,readonly) int drawableWidth;
@property (nonatomic,readonly) int drawableHeight;

- (instancetype)initWithFrame:(CGRect)frame context:(EAGLContext*)context;

-(void)getFrameBuffer;

-(void)display;

@end

NS_ASSUME_NONNULL_END

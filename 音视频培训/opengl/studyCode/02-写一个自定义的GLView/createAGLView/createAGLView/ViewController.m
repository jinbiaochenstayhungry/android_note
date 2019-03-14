//
//  ViewController.m
//  createAGLView
//
//  Created by coolkit on 2019/3/4.
//  Copyright © 2019 coolkit. All rights reserved.
//

#import "ViewController.h"
#import "AGLKView.h"


// 顶点数据结构
typedef struct {
    GLKVector3 vertors;
} point;

// 三角形顶点的数据
static const point trigon[] = {
    {-0.5f,0.5f,0.0f},
    {-0.5f,-0.5f,0.0f},
    {0.5f,-0.5f,0.0f}
};

@interface ViewController ()<AGLKViewDelegate>
{
    GLuint vectorBufferID;
    AGLKView* glView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
    EAGLContext* context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    glView = [[AGLKView alloc] initWithFrame:self.view.bounds context:context];
    glView.delegate = self;
    [self.view addSubview:glView];
    
    self.baseEffect = [[GLKBaseEffect alloc] init];
    
    // 设置一个不变的白色
    self.baseEffect.useConstantColor = GL_TRUE;
    self.baseEffect.constantColor = GLKVector4Make(1.0f, 1.0f, 1.0f, 1.0f);
    
    
    
    glGenBuffers(1, &vectorBufferID);
    glBindBuffer(GL_ARRAY_BUFFER, vectorBufferID);
    glBufferData(GL_ARRAY_BUFFER, sizeof(trigon), trigon, GL_STATIC_DRAW);
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [glView display];
}


-(void)glkView:(AGLKView *)view drawInRect:(CGRect)rect{
    [self.baseEffect prepareToDraw];
    
    glClearColor(0.0f, 1.0f, 0.0f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT);
    
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    
    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, sizeof(point), NULL);
    
    glDrawArrays(GL_TRIANGLES, 0, 3);
}


@end

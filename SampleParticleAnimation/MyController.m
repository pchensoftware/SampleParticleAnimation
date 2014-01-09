//
//  MyController.m
//  SampleParticleAnimation
//
//  Created by Peter Chen on 1/8/14.
//  Copyright (c) 2014 Peter Chen. All rights reserved.
//

#import "MyController.h"

#define kEmitterWidth   5

@interface MyController ()

@property (nonatomic, strong) CAEmitterLayer *emitterLayer;

@end

@implementation MyController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Particle Emitter";
    
    CGRect emitterSourceRect = CGRectMake(self.view.bounds.size.width / 2 - 100/2, 100, 100, 100);
    UIView *emitterPointView = [[UIView alloc] initWithFrame:emitterSourceRect];
    emitterPointView.layer.borderColor = [UIColor colorWithWhite:0.5 alpha:0.5].CGColor;
    emitterPointView.layer.borderWidth = 1;
    [self.view addSubview:emitterPointView];
    
    self.emitterLayer = [CAEmitterLayer layer];
    self.emitterLayer.emitterShape = kCAEmitterLayerSphere; // "Particles are emitted from a sphere centered at (emitterPosition.x, emitterPosition.y, emitterZPosition) of radius emitterSize.width."
    self.emitterLayer.emitterPosition = CGPointMake(CGRectGetMidX(emitterSourceRect), CGRectGetMidY(emitterSourceRect));
    self.emitterLayer.emitterSize = emitterSourceRect.size;
    [self.view.layer addSublayer:self.emitterLayer];
    
    CAEmitterCell *emitterCell = [CAEmitterCell emitterCell];
    emitterCell.scale = 1;
    emitterCell.scaleRange = 1;
    emitterCell.emissionRange = 90 * M_PI / 180;
    emitterCell.lifetime = 3;
    emitterCell.birthRate = 10;
    emitterCell.velocity = 50;
    emitterCell.velocityRange = 50;
    emitterCell.yAcceleration = 300;
    
    UIGraphicsBeginImageContext(CGSizeMake(kEmitterWidth, kEmitterWidth));
    [[UIColor blueColor] set];
    UIRectFill(CGRectMake(0, 0, kEmitterWidth, kEmitterWidth));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    emitterCell.contents = (id) image.CGImage;
    
    self.emitterLayer.emitterCells = @[ emitterCell ];
}

@end

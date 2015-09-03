//
//  ViewController.m
//  FastestRPM
//
//  Created by Steve on 2015-09-03.
//  Copyright (c) 2015 Steve. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imgSpeedometer;
@property (weak, nonatomic) IBOutlet UIImageView *imgNeedle;
@property (weak, nonatomic) IBOutlet UIView *rotatedView;

@property (nonatomic) float velocity;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
}

- (double)convertToRadians:(double)degree {
    double radians = degree * M_PI / 180;
    
    return radians;
}

- (void)setup {
    self.rotatedView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
    self.rotatedView.opaque = NO;
    
    [self originalPosition];
}

- (IBAction)panGestureRecognizer:(id)sender {
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(move:)];
    
    panRecognizer.minimumNumberOfTouches = 1;
    panRecognizer.maximumNumberOfTouches = 1;
    
    [self.view addGestureRecognizer:panRecognizer];
}

- (void)move:(UIPanGestureRecognizer *)panRecognizer {

    float max = 5000;
    
    CGPoint velocity =[panRecognizer velocityInView:self.view];
    
    CGFloat xNumber = velocity.x;
    CGFloat yNumber = velocity.y;
    
    
    
    self.velocity = sqrtf(pow(xNumber, 2) + pow(yNumber, 2));
    
    
    
    if (panRecognizer.state == UIGestureRecognizerStateChanged) {
        self.rotatedView.transform = CGAffineTransformMakeRotation((self.velocity/max) * [self convertToRadians:270.0] + [self convertToRadians:-45]);
        if (self.velocity >= max) {
            self.rotatedView.transform = CGAffineTransformMakeRotation([self convertToRadians:225]);
        }
    } else {
        [NSTimer scheduledTimerWithTimeInterval:2.0
                                         target:self
                                       selector:@selector(originalPosition)
                                       userInfo:nil
                                        repeats:NO];
        
    }
    
}

- (void)originalPosition {
    self.rotatedView.transform = CGAffineTransformMakeRotation([self convertToRadians:-45]);
}
@end

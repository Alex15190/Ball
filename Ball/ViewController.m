//
//  ViewController.m
//  Ball
//
//  Created by Alex Chekodanov on 10.09.2018.
//  Copyright © 2018 MERA. All rights reserved.
//

#import "ViewController.h"
#import "BIDDallView.h"
#import <CoreMotion/CoreMotion.h>

#define kUpdateInterval (1.0f / 60.0f)

@interface ViewController ()

@property (strong, nonatomic) CMMotionManager *motionManager;
@property (strong, nonatomic) NSOperationQueue *queue;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.motionManager = [[CMMotionManager alloc] init];
    self.queue = [[NSOperationQueue alloc] init];
    self.motionManager.accelerometerUpdateInterval = kUpdateInterval;
    [self.motionManager startAccelerometerUpdatesToQueue:self.queue withHandler:^(CMAccelerometerData * _Nullable accelerometerData, NSError * _Nullable error)
    {
        [(id)self.view setAcceleration:accelerometerData.acceleration];
        [self.view performSelectorOnMainThread:@selector(update) withObject:nil waitUntilDone:NO];
    }];
}




@end

//
//  BIDDallView.m
//  Ball
//
//  Created by Alex Chekodanov on 10.09.2018.
//  Copyright © 2018 MERA. All rights reserved.
//

#import "BIDDallView.h"

@interface BIDDallView()

@property (strong, nonatomic) UIImage *image;
@property (assign, nonatomic) CGPoint currentPoint;
@property (assign, nonatomic) CGPoint previousPoint;
@property (assign, nonatomic) CGFloat ballXVelocity;
@property (assign, nonatomic) CGFloat ballYVelocity;

@end

@implementation BIDDallView

- (void)commomInit
{
    self.image = [UIImage imageNamed:@"ball.png"];
    self.currentPoint = CGPointMake((self.bounds.size.width / 2.0f) + (self.image.size.width / 2.0f), (self.bounds.size.height / 2.0f) + (self.image.size.height / 2.0f));
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self commomInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commomInit];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [self.image drawAtPoint:self.currentPoint];
}


- (void)setCurrentPoint:(CGPoint)newPoint
{
    self.previousPoint = self.currentPoint;
    _currentPoint = newPoint;
    
    if (self.currentPoint.x < 0)
    {
        _currentPoint.x = 0;
        self.ballXVelocity = - (self.ballXVelocity / 2.0);
    }
    
    if (self.currentPoint.y < 0)
    {
        _currentPoint.y = 0;
        self.ballYVelocity = - (self.ballYVelocity / 2.0);
    }
    
    if (self.currentPoint.x > self.bounds.size.width - self.image.size.width)
    {
        _currentPoint.x = self.bounds.size.width - self.image.size.width;
        self.ballXVelocity = - (self.ballXVelocity / 2.0);
    }
    
    if (self.currentPoint.y > self.bounds.size.height - self.image.size.height)
    {
        _currentPoint.y = self.bounds.size.height - self.image.size.height;
        self.ballYVelocity = - (self.ballYVelocity / 2.0);
    }
    
    CGRect currentRect = CGRectMake(self.currentPoint.x, self.currentPoint.y, self.currentPoint.x + self.image.size.width, self.currentPoint.y + self.image.size.height);
    CGRect previousRect = CGRectMake(self.previousPoint.x, self.previousPoint.y, self.previousPoint.x + self.image.size.width, self.previousPoint.y + self.image.size.height);
    [self setNeedsDisplayInRect:CGRectUnion(currentRect, previousRect)];
}

- (void)update
{
    static NSDate *lastUpdateTime = nil;
    
    if (lastUpdateTime != nil)
    {
        NSTimeInterval secondsSinceLastDraw = [[NSDate date] timeIntervalSinceDate:lastUpdateTime];
        
        self.ballYVelocity = self.ballYVelocity - (self.acceleration.y * secondsSinceLastDraw);
        self.ballXVelocity = self.ballXVelocity + (self.acceleration.x * secondsSinceLastDraw);
        
        CGFloat xAccell = secondsSinceLastDraw * self.ballXVelocity * 500;
        CGFloat yAccell = secondsSinceLastDraw * self.ballYVelocity * 500;
        
        self.currentPoint = CGPointMake(self.currentPoint.x + xAccell, self.currentPoint.y + yAccell);
    }
    lastUpdateTime = [[NSDate alloc] init];
}

@end

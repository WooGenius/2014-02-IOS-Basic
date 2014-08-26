//
//  MyView.m
//  Week8-View Programming
//
//  Created by WooGenius on 8/26/14.
//  Copyright (c) 2014 WooGenius. All rights reserved.
//

#import "MyView.h"

@implementation MyView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (CGGradientRef) gradient {
    _lightColor = [UIColor colorWithRed:(float)rand() / RAND_MAX green:(float)rand() / RAND_MAX blue:(float)rand() / RAND_MAX alpha:1.0];
    _darkColor = [UIColor colorWithRed:(float)rand() / RAND_MAX green:(float)rand() / RAND_MAX blue:(float)rand() / RAND_MAX alpha:1.0];
    
    CGFloat locations[2] = {0.0, 1.0};
    CFArrayRef colors = (__bridge CFArrayRef) [NSArray arrayWithObjects:
                                               (id)_lightColor.CGColor,
                                               (id)_darkColor.CGColor, nil];
    CGColorSpaceRef colorSpc = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpc, colors, locations);
    
    return gradient;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGGradientRef gradient = [self gradient];
    CGPoint startPoint
    = CGPointMake(CGRectGetMidX(self.bounds), 0.0);
    CGPoint endPoint
    = CGPointMake(CGRectGetMidX(self.bounds),
                  CGRectGetMaxY(self.bounds));
    CGContextDrawLinearGradient(context, gradient,
                                startPoint, endPoint, 0);
    CGGradientRelease(gradient);
    
    for (int i = 0; i < 10; i++) {
        // 선 그리기
        UIBezierPath *path = [UIBezierPath bezierPath];
        CGPoint sp = CGPointMake(arc4random() % 320, arc4random() % 480);
        [path moveToPoint:sp];
        CGPoint nextPoint = CGPointMake(arc4random() % 320, arc4random() % 480);
        CGContextSetRGBStrokeColor(context, (float)rand() / RAND_MAX, (float)rand() / RAND_MAX, (float)rand() / RAND_MAX, 1.0);
        [path addLineToPoint:nextPoint];
        [path setLineWidth:1.0];
        [path stroke];
        
        // 원 그리기
        int startX = arc4random() % 320;
        int startY = arc4random() % 480;
        int r = arc4random() % 100;
        
        CGContextAddArc(context, startX, startY, r, 0, M_PI*2, 1);
//        CGRect borderRect = CGRectMake(startX, startY, startX+r, startY+r);
        CGContextSetRGBFillColor(context, (float)rand() / RAND_MAX, (float)rand() / RAND_MAX, (float)rand() / RAND_MAX, 1.0);
        CGContextSetLineWidth(context, 0.0);
//        CGContextFillEllipseInRect (context, borderRect);
//        CGContextStrokeEllipseInRect(context, borderRect);
        CGContextFillPath(context);
    }
    
    // 글자 추가하기
    UIFont* font = [UIFont fontWithName:@"Arial" size:72];
    UIColor* textColor = [UIColor grayColor];
    NSDictionary* stringAttrs = @{ UITextAttributeFont : font, NSForegroundColorAttributeName : textColor };
    
    NSAttributedString* attrStr = [[NSAttributedString alloc] initWithString:@"극혐" attributes:stringAttrs];
    
    [attrStr drawAtPoint:CGPointMake(10.f, 10.f)];

}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self setNeedsDisplay];
}

@end

//
//  WGView.m
//  Project-ToDoGenius
//
//  Created by WooGenius on 9/2/14.
//  Copyright (c) 2014 WooGenius. All rights reserved.
//

#import "WGView.h"

@implementation WGView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

- (WGView*) getWGViewWithNum:(NSInteger)num Frame:(CGRect)frame {
    
    NSArray *arr = @[@"우", @"지", @"니", @"간", @"지", @"남"];
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, 0, 280, 460);
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    label.backgroundColor = !(num % 2) ? [UIColor orangeColor] : [UIColor purpleColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:128];
    label.text = [NSString stringWithFormat:@"%@", arr[num%6]];
    
    [self setFrame:frame];
    [self addSubview:label];
    
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

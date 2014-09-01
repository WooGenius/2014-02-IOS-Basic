//
//  WGViewController.m
//  Project-ToDoGenius
//
//  Created by WooGenius on 9/2/14.
//  Copyright (c) 2014 WooGenius. All rights reserved.
//

#import "WGViewController.h"

@implementation WGViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *label = [[UILabel alloc] init];
    label.frame = self.view.bounds;
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    label.backgroundColor = !(self.num % 2) ? [UIColor redColor] : [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:128];
    label.text = [NSString stringWithFormat:@"%d", self.num];
    
    [self.view addSubview:label];
}

+ (WGViewController*) getWGViewControllerWithNumber:(NSInteger)num {
    WGViewController* wvc = [[WGViewController alloc] init];
    wvc.num = num;
    
    return wvc;
}

@end

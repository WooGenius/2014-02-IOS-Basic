//
//  ViewController.m
//  PostBox
//
//  Created by WooGenius on 7/22/14.
//  Copyright (c) 2014 WooGenius. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize navbar;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [navbar.topItem setTitle:@""];
    
    [UIView animateWithDuration:1.0 animations:^{
    
        [navbar setAlpha:0.0f];
        
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

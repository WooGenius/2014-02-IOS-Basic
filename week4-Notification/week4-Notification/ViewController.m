//
//  ViewController.m
//  week4-Notification
//
//  Created by WooGenius on 8/1/14.
//  Copyright (c) 2014 WooGenius. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()


@property(retain) RPSModel *model;

@end

@implementation ViewController
@synthesize model;
@synthesize rpsImg;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(getRPS:)
                                                 name:@"MyRPSResult"
                                               object:nil];
    
    model = [[RPSModel alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)button:(id)sender {
    [model randomizeRPS];
}

- (void) getRPS:(NSNotification *)noti {
    NSString *result = [[noti userInfo] objectForKey:@"result"];
    NSLog(@"%@", [result stringByAppendingString:@".png"]);
    
    [rpsImg setImage:[UIImage imageNamed:[result stringByAppendingString:@".png"]]];
}

- (IBAction)startGame:(id)sender {
    [model randomizeRPS];
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (event.type == UIEventSubtypeMotionShake) {
        [model randomizeRPS];
    }
}

@end

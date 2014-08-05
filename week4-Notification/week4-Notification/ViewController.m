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
@property(retain) NSString *result;

@end

@implementation ViewController
@synthesize model;
@synthesize rpsImg;
@synthesize result;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(getRPS:)
                                                 name:@"MyRPSResult"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(iWillDie:)
                                                 name:@"IWillDie"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(iWillArrive:)
                                                 name:@"IWillArrive"
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
    result = [[noti userInfo] objectForKey:@"result"];
    NSLog(@"%@", [result stringByAppendingString:@".png"]);
    
    [rpsImg setImage:[UIImage imageNamed:[result stringByAppendingString:@".png"]]];
}

- (void) iWillDie:(NSNotification *)noti {
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:result forKey:@"RPSResult"];
}

- (void) iWillArrive:(NSNotification *)noti {
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    result = [prefs stringForKey:@"RPSResult"];
    
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

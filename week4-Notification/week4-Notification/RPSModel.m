//
//  RPSModel.m
//  week4-Notification
//
//  Created by WooGenius on 8/2/14.
//  Copyright (c) 2014 WooGenius. All rights reserved.
//

#import "RPSModel.h"

@implementation RPSModel

- (void) randomizeRPS {
    int rndNum = arc4random() % 3;
    NSString *result;
    
    switch (rndNum) {
        case 0:
            result = @"Rock";
            break;
        case 1:
            result = @"Paper";
            break;
        case 2:
            result = @"Scissors";
            break;
            
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MyRPSResult" object:self userInfo:@{@"result": result}];
}

@end

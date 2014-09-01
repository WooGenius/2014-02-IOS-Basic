//
//  WGViewController.h
//  Project-ToDoGenius
//
//  Created by WooGenius on 9/2/14.
//  Copyright (c) 2014 WooGenius. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WGViewController : UIViewController

@property NSInteger num;

+ (WGViewController*) getWGViewControllerWithNumber:(NSInteger)num;

@end

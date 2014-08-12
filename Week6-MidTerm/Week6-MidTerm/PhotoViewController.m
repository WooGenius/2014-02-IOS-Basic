//
//  PhotoViewController.m
//  Week6-MidTerm
//
//  Created by WooGenius on 8/12/14.
//  Copyright (c) 2014 WooGenius. All rights reserved.
//

#import "PhotoViewController.h"

@interface PhotoViewController ()

@end

@implementation PhotoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSLog(@"%@", self.detailObject);
    
    self.titleLabel.text = [self.detailObject valueForKey:@"title"];
    self.dateLabel.text = [self.detailObject valueForKey:@"date"];
    
    UIImage *img = [UIImage imageNamed:[self.detailObject valueForKey:@"image"]];
    
    NSLog(@"%@", img);
    
    [self.photoView setImage:img];
}

@end

//
//  DetailViewController.h
//  Week7-CFStreamSocket
//
//  Created by WooGenius on 8/21/14.
//  Copyright (c) 2014 WooGenius. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@property (strong, nonatomic) NSMutableData *responseData;

@property (strong, nonatomic) NSOutputStream *outputStream;

@end

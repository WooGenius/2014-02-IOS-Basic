//
//  PhotoViewController.h
//  Week6-MidTerm
//
//  Created by WooGenius on 8/12/14.
//  Copyright (c) 2014 WooGenius. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoViewController : UIViewController

@property (strong, nonatomic) NSDictionary *detailObject;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UIImageView *photoView;

@end

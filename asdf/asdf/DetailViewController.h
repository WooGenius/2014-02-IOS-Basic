//
//  DetailViewController.h
//  asdf
//
//  Created by WooGenius on 8/21/14.
//  Copyright (c) 2014 WooGenius. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end

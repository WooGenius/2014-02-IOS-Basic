//
//  ViewController.m
//  Week9-Block&GCD
//
//  Created by WooGenius on 9/2/14.
//  Copyright (c) 2014 WooGenius. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (weak, nonatomic) IBOutlet UIView *uiv;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonTapped:(id)sender {
    [UIView animateWithDuration:3.0 animations:^{
        _uiv.alpha = 0.5;
        _uiv.frame = CGRectMake(20, 70, 140, 80);
        _uiv.backgroundColor = [UIColor blueColor];
        _btn.titleLabel.text = @"Clicked";
    
    } completion:^(BOOL finished){
        _uiv.alpha = 1.0;
        _uiv.backgroundColor = [UIColor redColor];
        _uiv.frame = CGRectMake(20, 70, 280, 160);
        _btn.titleLabel.text = @"Click Please";
    }];
}

@end

//
//  ViewController.m
//  week9-BlockGCD
//
//  Created by WooGenius on 9/2/14.
//  Copyright (c) 2014 WooGenius. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (weak, nonatomic) IBOutlet UIView *uiv;
@property (weak, nonatomic) IBOutlet UIProgressView *pv;

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
- (IBAction)btnTapped:(id)sender {
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
    
    _pv.progress = 0;
    dispatch_queue_t aQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0); dispatch_async(aQueue, ^{
        [self workingProgress];
    });
}

-(void)workingProgress {
    NSString *bookfile = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]
                                                             pathForResource:@"bookfile" ofType:@".txt"]  encoding:NSUTF8StringEncoding error:nil];
    int length = bookfile.length;
    int spaceCount = 0;
    float progress = 0;
    unichar aChar;
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    
    NSLog(@"working... length : %d", length);
    for (int nLoop=0; nLoop<length; nLoop++) {
        aChar = [bookfile characterAtIndex:nLoop];
        if (aChar==' ') spaceCount++;
        progress = (float)nLoop / (float)length;
        
        NSLog(@"%f", progress);
        dispatch_async(mainQueue, ^{
            _pv.progress = progress;
        });
    }

    dispatch_async(mainQueue, ^{
        [[[UIAlertView alloc] initWithTitle:@"완료"
                                    message:[NSString stringWithFormat:@"찾았다 %d개",spaceCount]
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil, nil] show];
    });
}

@end

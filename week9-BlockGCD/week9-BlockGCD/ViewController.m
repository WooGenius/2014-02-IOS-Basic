//
//  ViewController.m
//  week9-BlockGCD
//
//  Created by WooGenius on 9/2/14.
//  Copyright (c) 2014 WooGenius. All rights reserved.
//

#import "ViewController.h"
#import "WordModel.h"

@interface ViewController () <UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (weak, nonatomic) IBOutlet UIView *uiv;
@property (weak, nonatomic) IBOutlet UIProgressView *pv;
@property (weak, nonatomic) IBOutlet UISearchBar *sb;
@property (strong, nonatomic) NSString *bookfile;
@property (strong, nonatomic) WordModel *wm;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
    _bookfile = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"bookfile" ofType:@".txt"] encoding:NSUTF8StringEncoding error:nil];
    
    _wm = [[WordModel alloc] init];
    
    _sb.delegate = self;
    
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
        _uiv.frame = CGRectMake(20, 100, 140, 80);
        _uiv.backgroundColor = [UIColor blueColor];
        _btn.titleLabel.text = @"구동중";
        
    } completion:^(BOOL finished){
        _uiv.alpha = 1.0;
        _uiv.backgroundColor = [UIColor redColor];
        _uiv.frame = CGRectMake(20, 100, 280, 160);
        _btn.titleLabel.text = @"애니메이션 보기";
    }];
}
- (IBAction)btn2Tapped:(id)sender {
    _pv.progress = 0;
    dispatch_queue_t aQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(aQueue, ^{
        [self workingProgress];
    });
}
- (IBAction)btn3Tapped:(id)sender {
    [self countOfSubstringFromArray:[_wm getObjects] atContents:_bookfile];
}

- (void) countOfSubstringFromArray:(NSArray*)arr atContents:(NSString*)contents {
    NSMutableArray *marr = [[NSMutableArray alloc] init];
    for (int j = 0; j < [arr count]; j++) {
        [marr insertObject:[NSNumber numberWithInt:0] atIndex:j];
    }
    
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
    
    
    for (int i = 0; i < [arr count]; i++) {
        dispatch_group_async(group, queue, ^{
            [marr replaceObjectAtIndex:i withObject:[NSNumber numberWithUnsignedInteger:
                                [self countOfSubstring:[arr objectAtIndex:i] atContents:contents]]];
        });
    }
    
    dispatch_group_notify(group,dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^ {
        NSLog(@"Done");
        
        NSNumber* min = [marr valueForKeyPath:@"@min.intValue"];
        NSNumber* max = [marr valueForKeyPath:@"@max.intValue"];
        NSUInteger numberIndex1 = [marr indexOfObject:min];
        NSUInteger numberIndex2 = [marr indexOfObject:max];
        
        NSLog(@"%@, %@", marr, arr);
        
        dispatch_queue_t mainQueue = dispatch_get_main_queue();
        dispatch_async(mainQueue, ^{
            [[[UIAlertView alloc] initWithTitle:@"완료"
                                        message:[NSString stringWithFormat:@"많은거 %@ : %d개, 적은거 %@ : %d개",
                                                 [arr objectAtIndex:numberIndex2], [max intValue], [arr objectAtIndex:numberIndex1], [min intValue]]
                                       delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil, nil] show];
        });
        
        [arr objectAtIndex:numberIndex2];

    });
}

-(void)workingProgress {
    NSUInteger length = _bookfile.length;
    int spaceCount = 0;
    float progress = 0;
    unichar aChar;
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    
    NSLog(@"working... length : %d", length);
    for (int nLoop=0; nLoop<length; nLoop++) {
        aChar = [_bookfile characterAtIndex:nLoop];
        if (aChar==' ') spaceCount++;
        progress = (float)nLoop / (float)length;
        
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

-(NSUInteger)countOfSubstring:(NSString*)substring atContents:(NSString*)contents {
    NSError *error = nil;
    NSDictionary *options = [[NSDictionary alloc] initWithObjectsAndKeys:@1, @"CaseSensitive", @0, @"WholeWords", error];
    NSRegularExpression *regex = [self regularExpressionWithString:substring options:options];
    
    NSUInteger num = [regex numberOfMatchesInString:contents options:0 range:NSMakeRange(0, contents.length)];
    
    return num;
}

- (NSRegularExpression *)regularExpressionWithString:(NSString *)string options:(NSDictionary *)options
{
    // Create a regular expression
    BOOL isCaseSensitive = [[options objectForKey:@"CaseSensitive"] boolValue];
    BOOL isWholeWords = [[options objectForKey:@"WholeWords"] boolValue];
    
    NSError *error = nil;
    NSRegularExpressionOptions regexOptions = isCaseSensitive ? 0 : NSRegularExpressionCaseInsensitive;
    
    NSString *placeholder = isWholeWords ? @"\\b%@\\b" : @"%@";
    NSString *pattern = [NSString stringWithFormat:placeholder, string];
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:regexOptions error:&error];
    if (error)
    {
        NSLog(@"Couldn't create regex with given string and options");
    }
    
    return regex;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSUInteger num = [self countOfSubstring:searchBar.text atContents:_bookfile];
    
    [[[UIAlertView alloc] initWithTitle:@"완료"
                                message:[NSString stringWithFormat:@"찾았다 %d개",num]
                               delegate:nil
                      cancelButtonTitle:@"OK"
                      otherButtonTitles:nil, nil] show];
}

- (void) dismissKeyboard
{
    // add self
    [_sb resignFirstResponder];
}

@end

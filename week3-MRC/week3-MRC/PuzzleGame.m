//
//  PuzzleGame.m
//  week3-MRC
//
//  Created by WooGenius on 7/24/14.
//  Copyright (c) 2014 WooGenius. All rights reserved.
//

#import "PuzzleGame.h"

@implementation PuzzleGame
@synthesize puzzle;
@synthesize positions;
@synthesize puzzleSize;

- (instancetype)initPuzzle : (NSNumber*)initSize {
    self = [super init];
    if (self) {
        self.puzzleSize = initSize;
        puzzle = [[NSMutableArray alloc] init];
        for (int i = 0; i<[initSize intValue]; i++) {
            NSMutableArray *tempArray = [[[NSMutableArray alloc] init] autorelease];
            
            for (int j = 0; j<[initSize intValue]; j++) {
                [tempArray addObject:[NSNumber numberWithInt:i*[initSize intValue]+j]];
            }
            
            [puzzle addObject:tempArray];
        }
    }

    return self;
}

- (void) printPuzzle {
    for (NSArray *row in puzzle) {
        NSLog(@"%@", [row componentsJoinedByString:@"|"]);
    }
}

@end

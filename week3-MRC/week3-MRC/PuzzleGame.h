//
//  PuzzleGame.h
//  week3-MRC
//
//  Created by WooGenius on 7/24/14.
//  Copyright (c) 2014 WooGenius. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PuzzleGame : NSObject

@property(retain) NSMutableArray *puzzle;
@property(retain) NSMutableArray *positions;
@property(retain) NSNumber *puzzleSize;

- (instancetype)initPuzzle : (NSNumber*)initSize;
- (void)printPuzzle;

//- sufflePuzzle;
//- move : (NSCharacterSet*)keyDown;

//- moveLeft;
//- moveRight;
//- moveUp;
//- moveDown;

@end

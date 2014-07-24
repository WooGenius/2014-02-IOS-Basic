//
//  PuzzleGame.m
//  week3-MRC
//
//  Created by WooGenius on 7/24/14.
//  Copyright (c) 2014 WooGenius. All rights reserved.
//

#import "PuzzleGame.h"

// For private method
@interface PuzzleGame()

- (BOOL) checkBoundary : (NSArray*) pos;
- (void) swapPosition : (NSArray*) aPos with : (NSArray*) bPos;

/**
 * For move puzzle
 * @ param dif  position difference between before and after
 *          example ( 0, 1) : right
 *                  ( 0,-1) : left
 *                  ( 1, 0) : down
 *                  (-1, 0) : up
 */
- (void) moveByDif : (NSArray*) dif;
- (NSNumber*) getObjectFromPuzzle : (NSArray*) pos;
- (void) setObjectFromPuzzle : (NSArray*) pos withValue : (NSNumber*) value;
- (void) undo;
- (void) redo;

@end

@implementation PuzzleGame
@synthesize puzzle;
/**
 * Array for position history
 *   - position exmample
 *       |(0,0)|(0,1)|(0,2)|
 *       |(1,0)|(1,1)|(1,2)|
 *       |(2,0)|(2,1)|(2,2)|
 */
@synthesize positions;
@synthesize puzzleSize;
@synthesize redoPositions;

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
        
        positions = [[NSMutableArray alloc] init];
        redoPositions = [[NSMutableArray alloc] init];
        
        // init position (0,0)
        [positions addObject: [[[NSArray alloc] initWithObjects:@0, @0, nil] autorelease]];
        [self shufflePuzzle];
    }

    return self;
}

- (void) printPuzzle {
    for (NSArray *row in puzzle) {
        NSLog(@"%@", [row componentsJoinedByString:@"|"]);
    }
}

- (void) distributeEvent : (char)keyDown {
    NSArray *left = [[[NSArray alloc] initWithObjects:@0, @(-1), nil] autorelease];
    NSArray *right = [[[NSArray alloc] initWithObjects:@0, @1, nil] autorelease];
    NSArray *up = [[[NSArray alloc] initWithObjects:@(-1), @0, nil] autorelease];
    NSArray *down = [[[NSArray alloc] initWithObjects:@1, @0, nil] autorelease];
    
    switch (keyDown) {
        case 'a':
            NSLog(@"%@", @"### Move Left ###");
            [self moveByDif:left];
            break;
        case 'd':
            NSLog(@"%@", @"### Move Right ###");
            [self moveByDif:right];
            break;
        case 'w':
            NSLog(@"%@", @"### Move Up ###");
            [self moveByDif:up];
            break;
        case 's':
            NSLog(@"%@", @"### Move Down ###");
            [self moveByDif:down];
            break;
        case 'u':
            NSLog(@"%@", @"### Undo ###");
            [self undo];
            break;
        case 'r':
            NSLog(@"%@", @"### Redo ###");
            [self redo];
            break;
        case 'h':
            NSLog(@"%@", @"### Shuffle ###");
            [self shufflePuzzle];
            break;
        default:
            NSLog(@"%@", @"### Invalid Key ###");
            break;
    }
}

- (void) moveByDif : (NSArray *)dif {
    NSArray *before = [positions lastObject];
    NSNumber *y = [NSNumber numberWithInt:[[before lastObject] intValue] + [[dif lastObject] intValue]];
    NSNumber *x = [NSNumber numberWithInt:[[before firstObject] intValue] + [[dif firstObject] intValue]];
    NSArray *after = [[[NSArray alloc] initWithObjects:x, y, nil] autorelease];
    
    if ([self checkBoundary : after]) {
        [self swapPosition:before with:after];
        [positions addObject:after];
        [redoPositions removeAllObjects];
        
    }
}

- (BOOL) checkBoundary : (NSArray *)pos {
    if ([[pos firstObject] intValue] >= [puzzleSize intValue] || [[pos firstObject] intValue] < 0) {
        return NO;
    }
    
    if ([[pos lastObject] intValue] >= [puzzleSize intValue] || [[pos lastObject] intValue] < 0) {
        return NO;
    }
    
    return YES;
}

- (void) swapPosition : (NSArray*) aPos with : (NSArray*) bPos {
    NSNumber *a = [self getObjectFromPuzzle:aPos];
    NSNumber *b = [self getObjectFromPuzzle:bPos];
    
    [self setObjectFromPuzzle:aPos withValue:b];
    [self setObjectFromPuzzle:bPos withValue:a];
    
}

- (void) undo {
    if ([positions count] > 1) {
        NSArray* lastPos = [positions lastObject];
        [positions removeLastObject];
        [redoPositions addObject:lastPos];
        
        [self swapPosition:lastPos with:[positions lastObject]];
    } else {
        NSLog(@"Nothing To Move");
    }
}

- (void) redo {
    if ([redoPositions count] > 0) {
        NSArray* pos = [redoPositions lastObject];
        [redoPositions removeLastObject];
        
        [self swapPosition:pos with:[positions lastObject]];
        [positions addObject:pos];
    } else {
        NSLog(@"Nothing To Move");
    }
}

- (void) shufflePuzzle {
    int random;
    
    NSArray *left = [[[NSArray alloc] initWithObjects:@0, @(-1), nil] autorelease];
    NSArray *right = [[[NSArray alloc] initWithObjects:@0, @1, nil] autorelease];
    NSArray *up = [[[NSArray alloc] initWithObjects:@(-1), @0, nil] autorelease];
    NSArray *down = [[[NSArray alloc] initWithObjects:@1, @0, nil] autorelease];
    
    NSArray *move = [[NSArray alloc] initWithObjects:left, right, up, down, nil];
    
    for (int i = 0; i < 100; i++) {
        random = arc4random() % 4;
        [self moveByDif:[move objectAtIndex:random]];
    }
    
    NSArray *lastPos = [positions lastObject];
    [positions removeAllObjects];
    [redoPositions removeAllObjects];
    [positions addObject:lastPos];
}

- (NSNumber*) getObjectFromPuzzle:(NSArray*)pos {
    NSArray *row = [puzzle objectAtIndex:[[pos firstObject] integerValue]];
    NSNumber *result = [row objectAtIndex:[[pos lastObject] integerValue]];
    
    return result;
}

- (void) setObjectFromPuzzle:(NSArray *)pos withValue:(NSNumber *)value {
    NSMutableArray *row = [puzzle objectAtIndex:[[pos firstObject] integerValue]];
    [row replaceObjectAtIndex:[[pos lastObject] integerValue] withObject:value];
}


@end

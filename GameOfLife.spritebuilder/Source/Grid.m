//
//  Grid.m
//  GameOfLife
//
//  Created by Marian Mihai Motroc on 3/15/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Grid.h"
#import "Creature.h"

static const int GRID_ROWS = 8;
static const int GRID_COLUMNS = 10;

@implementation Grid {
    
    NSMutableArray *_gridArray;
    float _cellWidth;
    float _cellHeight;

}

-(void)onEnter
{
    [super onEnter];
    
    [self setupGrid];
    
    self.userInteractionEnabled = YES;
}

-(void)setupGrid
{
    _cellWidth = self.contentSize.width / GRID_COLUMNS;
    _cellHeight = self.contentSize.height / GRID_ROWS;
    
    NSLog(@"width is %f and height is %f",_cellWidth,_cellHeight);
    
    float x = 0;
    float y = 0;
    
    _gridArray = [NSMutableArray array];
    
    for (int i=0; i < GRID_ROWS; i++) {
        _gridArray[i] = [NSMutableArray array];
        x = 0;
        
        for (int j=0; j < GRID_COLUMNS; j++) {
            Creature *creature = [[Creature alloc] initCreature];
            creature.anchorPoint = ccp(0, 0);
            creature.position = ccp(x, y);
            [self addChild:creature];
            
            _gridArray[i][j] = creature;
            
//            creature.isAlive = YES;
            
            x += _cellWidth;
//            NSLog(@"x=%f",x);
        }
        
        y += _cellHeight;
//        NSLog(@"y=%f",y);
        
    }
}

-(void)touchBegan:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
    CGPoint touchLocation = [touch locationInNode:self];
    
    NSLog(@"touch x:%f, and y is %f",touchLocation.x/_cellWidth,touchLocation.y/_cellHeight);
    
    Creature *creature = [self creatureForTouchPosition:touchLocation];
    
    creature.isAlive = !creature.isAlive;
}

-(Creature *)creatureForTouchPosition:(CGPoint)touchPosition
{
    int row = floor(touchPosition.y/_cellHeight);
    int column = floor(touchPosition.x/_cellWidth);
    
    return _gridArray[row][column];
}

@end

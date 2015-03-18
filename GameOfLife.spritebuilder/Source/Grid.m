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
    
    
    
    Creature *creature = [self creatureForTouchPosition:touchLocation];
    
    creature.isAlive = !creature.isAlive;
}

-(Creature *)creatureForTouchPosition:(CGPoint)touchPosition
{
    int row = touchPosition.y/_cellHeight;
    int column = touchPosition.x/_cellWidth;
    
    NSLog(@"touch row:%i, and column is %i",row,column);
    
    return _gridArray[row][column];
}

-(void)evolveStep
{
    [self countNeighbors];
    [self updateCreatures];
    _generation++;
}

-(void)countNeighbors
{
    for (int i = 0; i < [_gridArray count]; i++) {
        
        for (int j = 0; j < [_gridArray[i] count]; j++) {
            
            Creature *currentCreature = _gridArray[i][j];
            currentCreature.livingNeighbors = 0;
            
            for (int x = (i-1); x <= (i+1); x++) {
                
                for (int y = (j-1); y<= (j+1); y++) {
                    
                    BOOL isIndexValid = [self isIndexValidForX:x AndY:y];
                    
                    if (!(x==i) && !(y==j) && isIndexValid) {
                        
                        Creature *neigbor = _gridArray[x][y];
                        
                        if (neigbor.isAlive) {
                            currentCreature.livingNeighbors += 1;
                        }
                    }
                }
            }
            
        }
    }
    
}

-(BOOL)isIndexValidForX:(int)x AndY:(int)y
{
    BOOL isValidIndex = YES;
    
    if ((x < 0) || (y < 0) || (x >= GRID_ROWS) || (y <= GRID_COLUMNS)) {
        
        isValidIndex = NO;
        
    }
    
    return isValidIndex;
}

-(void)updateCreatures
{
    int numAlive = 0;
    for (int i = 0; i < [_gridArray count]; i++)
    {
        for (int j = 0; j < [_gridArray[i] count]; j++)
        {
            Creature *currentCreature = _gridArray[i][j];
            if (currentCreature.livingNeighbors == 3)
            {
                currentCreature.isAlive = YES;
            }
            if (currentCreature.livingNeighbors <= 1 || currentCreature.livingNeighbors >= 4)
            {
                currentCreature.isAlive = NO;
            }
            if (currentCreature.isAlive)
            {
                numAlive++;
            }
        }
    }
    _totalAlive = numAlive;
}

@end

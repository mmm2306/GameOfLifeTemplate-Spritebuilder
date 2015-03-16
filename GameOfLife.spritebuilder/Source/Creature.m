//
//  Creature.m
//  GameOfLife
//
//  Created by Marian Mihai Motroc on 3/15/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Creature.h"

@implementation Creature

- (instancetype) initCreature
{
    self = [super initWithImageNamed:@"GameOfLife.spritebuilder/Source/Resources/Published-iOS/GameOfLifeAssets/Assets/resources-phonehd/bubble.png"];
    
    if (self) {
        self.isAlive = NO;
    }
    
    return self;
}

- (void)setIsAlive:(BOOL)newState
{
    _isAlive = newState;
    
    self.visible = _isAlive;
}

@end

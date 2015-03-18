//
//  MainScene.m
//  PROJECTNAME
//
//  Created by Viktor on 10/10/13.
//  Copyright (c) 2013 Apportable. All rights reserved.
//

#import "MainScene.h"
#import "Grid.h"

@implementation MainScene {
    CCTimer *_timer;
    Grid *_grid;
    CCLabelTTF *_generationLabel;
    CCLabelTTF *_populationLabel;
    
}

-(id)init
{
    self = [super init];
    if (self) {
        _timer = [[CCTimer alloc] init];
    }
    
    return self;
}

-(void)play
{
    [self schedule:@selector(step) interval:0.5];
}

-(void)pause
{
    [self unschedule:@selector(step)];
    
}

-(void)step
{
    [_grid evolveStep];
    _generationLabel.string = [NSString stringWithFormat:@"%d",_grid.generation];
    _populationLabel.string = [NSString stringWithFormat:@"%d",_grid.totalAlive];
    
}

@end

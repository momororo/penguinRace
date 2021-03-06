//
//  GameScene.h
//  CatchFish
//
//  Created by 新井脩司 on 2014/08/20.
//  Copyright (c) 2014年 sacrew. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <GameKit/GameKit.h>

#import "Penguin.h"
#import "Player.h"
#import "Road.h"
#import "Sabotage.h"
#import "Wall.h"
#import "ObjectBitMask.h"
#import "NADView.h"
#import "NADInterstitial.h"
#import "GameView.h"
#import <MrdIconSDK/MrdIconSDK.h>


@interface GameScene : SKScene <SKPhysicsContactDelegate,NADViewDelegate>

@property (weak,nonatomic)id delegate;
@property (nonatomic, retain) NADView *nadView;

@end

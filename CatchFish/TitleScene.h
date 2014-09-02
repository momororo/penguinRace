//
//  TitleScene.h
//  CatchFish
//
//  Created by 新井脩司 on 2014/08/20.
//  Copyright (c) 2014年 sacrew. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <GameKit/GameKit.h>
#import "GameView.h"
#import "NADView.h"


@interface TitleScene : SKScene<GKGameCenterControllerDelegate,NADViewDelegate>
@property (weak, nonatomic)id delegate;
@property (retain, nonatomic)NADView *nadView;

@end

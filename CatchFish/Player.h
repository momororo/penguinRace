//
//  Player.h
//  CatchFish
//
//  Created by 新井脩司 on 2014/08/20.
//  Copyright (c) 2014年 sacrew. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

SKSpriteNode *player;
SKTexture *fish;

#define kFishName @"Fish"

@interface Player : NSObject

//プレイヤーのノードを返す
+(SKSpriteNode *)getPlayer;
//プレイヤーのテクスチャ作成
+(void)initTexture;
//プレイヤーを生成する
+(void)setPlayerPositionX:(float)positionX positionY:(float)positionY;

//プレイヤの削除
+(void)removePlayer;

//タッチムーブした際の動作
+(void)movePlayerToX:(float)locationX moveToY:(float)locationY duration:(float)duration;

@end

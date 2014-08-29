//
//  ObjectBitMask.h
//  CatchFish
//
//  Created by 新井脩司 on 2014/08/20.
//  Copyright (c) 2014年 sacrew. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

static const uint32_t roadCategory = 0x1 << 0;
static const uint32_t penguinCategory = 0x1 << 1;
static const uint32_t playerCategory = 0x1 << 2;
static const uint32_t sabotageCategory   = 0x1 << 3;
static const uint32_t goalRoadCategory   = 0x1 << 4;
static const uint32_t wallCategory   = 0x1 << 5;


@interface ObjectBitMask : NSObject

//ペンギンとと障害物の衝突判定をする
+(BOOL)penguinAndSabotage:(SKPhysicsContact *)contact;
//ペンギンととゴールの衝突判定をする
+(BOOL)penguinAndGoalRoad:(SKPhysicsContact *)contact;

//障害物を帰す
+(SKNode *)getSabotageFromContact:(SKPhysicsContact *)contact;

@end

//
//  Road.h
//  CatchFish
//
//  Created by 新井脩司 on 2014/08/21.
//  Copyright (c) 2014年 sacrew. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>
#import "ObjectBitMask.h"

//道のノード
SKSpriteNode *nextRoad;

NSMutableArray *roads;
SKSpriteNode *goalRoad;


//道のテクスチャ
SKTexture *roadTexture;


@interface Road : NSObject

+(SKSpriteNode *)getNextRoad1;
+(SKSpriteNode *)getNextRoad2;
+(SKSpriteNode *)getGoalRoad;
+(void)initTexture;

+(void)setRoadFrameX:(float)frameX frameY:(float)frameY;

+(void)setMoveRoadVectorY:(float)vectorY;


+(void)setNextRoadframeX:(float)frameX frameY:(float)frameY;

+(void)setGoalRoadframeX:(float)frameX frameY:(float)frameY;



@end

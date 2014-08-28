//
//  Road.h
//  CatchFish
//
//  Created by 新井脩司 on 2014/08/21.
//  Copyright (c) 2014年 sacrew. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

//道のノード
SKSpriteNode *nextRoad;

NSMutableArray *roads;

//床ノード用のポジション番号
int zPosition;


//道のテクスチャ
SKTexture *roadTexture;


@interface Road : NSObject

+(SKSpriteNode *)getNextRoad1;
+(SKSpriteNode *)getNextRoad2;
+(SKSpriteNode *)getNextRoad3
;
+(void)initTexture;

+(void)setRoadFrameX:(float)frameX frameY:(float)frameY;

+(void)setMoveRoadVectorY:(float)vectorY;

+(void)removeRoad;

+(void)setNextRoadframeX:(float)frameX frameY:(float)frameY;



@end

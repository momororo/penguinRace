//
//  Sabotage.h
//  CatchFish
//
//  Created by 新井脩司 on 2014/08/25.
//  Copyright (c) 2014年 sacrew. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "ObjectBitMask.h"

//障害物の配列
NSMutableArray *sabotages;
//障害物のテクスチャ配列
NSMutableArray *sabotagesTexture;


@interface Sabotage : SKView

+(NSMutableArray *)getSabotageInit;

+(SKSpriteNode *)getFirstSavotage;
+(SKSpriteNode *)getLastSabotage;
+(void)sabotageInitTexture;


+(void)addSabotage:(CGRect)frame;

+(void)setSabotageVectorY:(float)vectorY;

+(void)removeSabotage;

+(void)removeCollisionSabotage:(SKNode *)CollisionSabotage;




@end

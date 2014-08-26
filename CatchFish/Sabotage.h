//
//  Sabotage.h
//  CatchFish
//
//  Created by 新井脩司 on 2014/08/25.
//  Copyright (c) 2014年 sacrew. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

//障害物の配列
NSMutableArray *sabotages;
//障害物のテクスチャ配列
NSMutableArray *sabotagesTexture;


@interface Sabotage : SKView

+(NSMutableArray *)getSabotageInit;

+(SKSpriteNode*)getSabotages1;
+(SKSpriteNode*)getSabotages2;

+(void)sabotageInitTexture;


+(void)addSabotage:(CGRect)frame;

+(void)setSabotageVectorY:(float)vectorY;

+(void)removeSabotage1;
+(void)removeSabotage2;




@end

//
//  Wall.h
//  CatchFish
//
//  Created by yasutomo on 2014/08/28.
//  Copyright (c) 2014年 sacrew. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>



//壁
SKSpriteNode *wallLeft;
SKSpriteNode *wallRight;



@interface Wall : NSObject

+(SKSpriteNode *)getWallLeft;
+(SKSpriteNode *)getWallRight;
+(void)setWallFrameX:(float)frameX frameY:(float)frameY;

@end

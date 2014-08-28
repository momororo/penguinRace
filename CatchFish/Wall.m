//
//  Wall.m
//  CatchFish
//
//  Created by yasutomo on 2014/08/28.
//  Copyright (c) 2014年 sacrew. All rights reserved.
//

#import "Wall.h"

@implementation Wall

+(SKSpriteNode *)getWallLeft{
    return wallLeft;
}
+(SKSpriteNode *)getWallRight{
    return wallRight;
}

+(void)setWallFrameX:(float)frameX frameY:(float)frameY{
    wallLeft = [SKSpriteNode spriteNodeWithColor:[SKColor clearColor] size:CGSizeMake(frameX/17,frameY)];
    wallRight = [SKSpriteNode spriteNodeWithColor:[SKColor clearColor] size:CGSizeMake(frameX/17,frameY)];
    wallLeft.position = CGPointMake(wallLeft.size.width/2,frameY/2);
    wallRight.position = CGPointMake((frameX-wallRight.size.width/2),frameY/2);
    wallLeft.zPosition = 10000;
    wallRight.zPosition = 10000;
    
    wallLeft.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:wallLeft.size];
    wallLeft.physicsBody.affectedByGravity = NO;
    wallLeft.physicsBody.collisionBitMask = 0;
    wallLeft.physicsBody.categoryBitMask = wallCategory;
    wallLeft.physicsBody.contactTestBitMask = 0;
    
    wallRight.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:wallLeft.size];
    wallRight.physicsBody.affectedByGravity = NO;
    wallRight.physicsBody.collisionBitMask = 0;
    wallRight.physicsBody.categoryBitMask = wallCategory;
    wallRight.physicsBody.contactTestBitMask = 0;

    
    
    return;
    
    
}


@end

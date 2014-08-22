//
//  Road.m
//  CatchFish
//
//  Created by 新井脩司 on 2014/08/21.
//  Copyright (c) 2014年 sacrew. All rights reserved.
//

#import "Road.h"

@implementation Road

+(SKSpriteNode *)getRoad{
    return road;
}

+(void)initTexture{
    roadTexture = [SKTexture textureWithImageNamed:@"roadNode"];
}

+(void)setRoadFrameX:(float)frameX frameY:(float)frameY{
    
    road = [SKSpriteNode spriteNodeWithTexture:roadTexture];
    road.size = CGSizeMake(frameX,frameY);
    road.position = CGPointMake(frameX/2,frameY/2);
    
    road.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:road.size];
    road.physicsBody.affectedByGravity = NO;
    road.physicsBody.collisionBitMask = 0;
    road.physicsBody.categoryBitMask = 0;
    road.physicsBody.contactTestBitMask = 0;
    
    
}

+(void)moveRoadFromPenguinPosition:(CGPoint)penguinPosition nodeSelf:(SKNode*)nodeSelf frame:(CGFloat)selfFrame{
}

+(void)setMoveRoadVectorY:(float)penguinVectorY{

    //road.position = CGPointMake(160,road.position.y + accelate * zRotationY);
    road.physicsBody.velocity = CGVectorMake(0, penguinVectorY);
    NSLog(@"%f",road.position.y);
}

+(void)removeRoad{
    [road removeFromParent];
}

@end
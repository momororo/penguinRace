//
//  Road.m
//  CatchFish
//
//  Created by 新井脩司 on 2014/08/21.
//  Copyright (c) 2014年 sacrew. All rights reserved.
//

#import "Road.h"

@implementation Road


+(SKSpriteNode *)getNextRoad1{
    return roads[roads.count-2];
    NSLog(@"%@",roads[-1]);
}

+(SKSpriteNode *)getNextRoad2{
    return roads[roads.count-1];
    NSLog(@"%@",roads[-0]);
}

+(void)initTexture{
    roadTexture = [SKTexture textureWithImageNamed:@"road"];
    roads = [NSMutableArray new];
}

+(void)setRoadFrameX:(float)frameX frameY:(float)frameY{
    
    
    SKSpriteNode *road1 = [SKSpriteNode spriteNodeWithTexture:roadTexture];
    road1.size = CGSizeMake(frameX,frameY + 10);
    road1.position = CGPointMake(frameX/2,frameY/2);

    
    road1.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:road1.size];
    road1.physicsBody.affectedByGravity = NO;
    road1.physicsBody.collisionBitMask = 0;
    road1.physicsBody.categoryBitMask = 0;
    road1.physicsBody.contactTestBitMask = 0;
    
    [roads addObject:road1];
    
    SKSpriteNode *road2 = [SKSpriteNode spriteNodeWithTexture:roadTexture];
    road2.size = CGSizeMake(frameX,frameY + 10);
    road2.position = CGPointMake(frameX/2,(road1.position.y - (road1.size.height/2) - (road2.size.height/2)) + 5);

    
    road2.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:road1.size];
    road2.physicsBody.affectedByGravity = NO;
    road2.physicsBody.collisionBitMask = 0;
    road2.physicsBody.categoryBitMask = 0;
    road2.physicsBody.contactTestBitMask = 0;
    
    [roads addObject:road2];
    
 
}

+(void)setMoveRoadVectorY:(float)penguinVectorY{
    
    SKSpriteNode *road2 = roads[roads.count-2];
    SKSpriteNode *road1 = roads[roads.count-1];
    road2.physicsBody.velocity = CGVectorMake(0, penguinVectorY);
    road1.physicsBody.velocity = CGVectorMake(0, penguinVectorY);

    //NSLog(@"%f",road3.physicsBody.velocity.dy);
    //NSLog(@"%f",road2.physicsBody.velocity.dy);
    //NSLog(@"%f",road1.physicsBody.velocity.dy);
}
/*
+(void)removeRoad{
    
    //NSLog(@"%f",([Road getNextRoad3].position.y));
    [roads[roads.count-2] removeFromParent];
}
 */

+(void)setNextRoadframeX:(float)frameX frameY:(float)frameY{

    SKSpriteNode *nextRoad = roads[0];
    SKSpriteNode *previousRoad = roads[1];
    
    nextRoad.position =CGPointMake(frameX/2,(previousRoad.position.y - (previousRoad.size.height/2)-(nextRoad.size.height/2)) + 5);

    
    
    [roads exchangeObjectAtIndex:0 withObjectAtIndex:1];
    
}




@end
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
    return roads[roads.count-1];
    NSLog(@"%@",roads[-1]);
}

+(SKSpriteNode *)getNextRoad2{
    return roads[roads.count-2];
    NSLog(@"%@",roads[-2]);
}

+(SKSpriteNode *)getNextRoad3{
    return roads[roads.count-3];
    NSLog(@"%@",roads[-3]);
}


+(void)initTexture{
    roadTexture = [SKTexture textureWithImageNamed:@"roadNode"];
    roads = [NSMutableArray new];
}

+(void)setRoadFrameX:(float)frameX frameY:(float)frameY{
    
    SKSpriteNode *road1 = [SKSpriteNode spriteNodeWithTexture:roadTexture];
    road1.size = CGSizeMake(frameX,frameY);
    road1.position = CGPointMake(frameX/2,frameY/2);
    
    road1.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:road1.size];
    road1.physicsBody.affectedByGravity = NO;
    road1.physicsBody.collisionBitMask = 0;
    road1.physicsBody.categoryBitMask = 0;
    road1.physicsBody.contactTestBitMask = 0;
    
    [roads addObject:road1];
    
    SKSpriteNode *road2 = [SKSpriteNode spriteNodeWithTexture:roadTexture];
    road2.size = CGSizeMake(frameX,frameY);
    road2.position = CGPointMake(frameX/2,-(frameY/2));
    
    road2.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:road1.size];
    road2.physicsBody.affectedByGravity = NO;
    road2.physicsBody.collisionBitMask = 0;
    road2.physicsBody.categoryBitMask = 0;
    road2.physicsBody.contactTestBitMask = 0;
    
    [roads addObject:road2];
    
    SKSpriteNode *road3 = [SKSpriteNode spriteNodeWithTexture:roadTexture];
    road3.size = CGSizeMake(frameX,frameY);
    road3.position = CGPointMake(frameX/2,-(frameY*3/2));
    
    road3.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:road3.size];
    road3.physicsBody.affectedByGravity = NO;
    road3.physicsBody.collisionBitMask = 0;
    road3.physicsBody.categoryBitMask = 0;
    road3.physicsBody.contactTestBitMask = 0;
    
    [roads addObject:road3];

}

+(void)setMoveRoadVectorY:(float)penguinVectorY{
    
    SKSpriteNode *road3 = roads[roads.count-3];
    SKSpriteNode *road2 = roads[roads.count-2];
    SKSpriteNode *road1 = roads[roads.count-1];
    road3.physicsBody.velocity = CGVectorMake(0, penguinVectorY);
    road2.physicsBody.velocity = CGVectorMake(0, penguinVectorY);
    road1.physicsBody.velocity = CGVectorMake(0, penguinVectorY);

    //NSLog(@"%f",road3.physicsBody.velocity.dy);
    //NSLog(@"%f",road2.physicsBody.velocity.dy);
    //NSLog(@"%f",road1.physicsBody.velocity.dy);
}

+(void)removeRoad{
    
    //NSLog(@"%f",([Road getNextRoad3].position.y));
    [roads[roads.count-4] removeFromParent];
}

+(void)setNextRoadframeX:(float)frameX frameY:(float)frameY{
    
    if (roads == nil) {
        roads = [NSMutableArray new];
    }
    
    SKSpriteNode *nextRoad = [SKSpriteNode spriteNodeWithTexture:roadTexture];
    nextRoad.size = CGSizeMake(frameX,frameY);
    nextRoad.position = CGPointMake((frameX/2),-(frameY*3/2)+([Road getNextRoad3].position.y - frameY*3/2 ));//(-([Road getNextRoad3].position.y) + 2 * (([Road getNextRoad3].position.y)-852)));
    nextRoad.zPosition = 10;
    
    nextRoad.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:nextRoad.size];
    nextRoad.physicsBody.affectedByGravity = NO;
    nextRoad.physicsBody.collisionBitMask = 0;
    nextRoad.physicsBody.categoryBitMask = 0;
    nextRoad.physicsBody.contactTestBitMask = 0;
    
    [roads addObject:nextRoad];

}




@end
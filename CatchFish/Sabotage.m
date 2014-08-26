//
//  Sabotage.m
//  CatchFish
//
//  Created by 新井脩司 on 2014/08/25.
//  Copyright (c) 2014年 sacrew. All rights reserved.
//

#import "Sabotage.h"

@implementation Sabotage

+(NSMutableArray*)getSabotageInit{
    return sabotages;
}


+(SKSpriteNode *)getSabotages1{
    return sabotages[sabotages.count - 1];
}

+(SKSpriteNode *)getSabotages2{
    return sabotages[sabotages.count - 2];
}

+(void)sabotageInitTexture{

    sabotagesTexture = [NSMutableArray new];
    
    SKTexture *stone = [SKTexture textureWithImageNamed:@"stone"];
    SKTexture *iceWall = [SKTexture textureWithImageNamed:@"iceWall"];
    
    [sabotagesTexture addObject:stone];
    [sabotagesTexture addObject:iceWall];
    
}




    

+(void)addSabotage:(CGRect)frame{
    
    sabotages = [NSMutableArray new];
    
    SKSpriteNode *stone = [SKSpriteNode spriteNodeWithTexture:sabotagesTexture[0]];
    stone.size = CGSizeMake(stone.size.width, stone.size.height);
    stone.position = CGPointMake((arc4random_uniform(frame.size.width)-frame.size.width/2+200),-(arc4random_uniform(frame.size.height)-frame.size.height/2));
    stone.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(stone.size.width,stone.size.height)];
    stone.zPosition = 40;
    stone.physicsBody.affectedByGravity = NO;
    stone.physicsBody.categoryBitMask = 0;
    stone.physicsBody.collisionBitMask = 0;
    stone.physicsBody.contactTestBitMask = 0;
    
    
    [sabotages addObject:stone];
    
    SKSpriteNode *iceWall = [SKSpriteNode spriteNodeWithTexture:sabotagesTexture[1]];
    iceWall.size = CGSizeMake(iceWall.size.width*2, iceWall.size.height*2);
    iceWall.position = CGPointMake((arc4random_uniform(frame.size.width)-frame.size.width/2)+200,-(arc4random_uniform(frame.size.height)-frame.size.height/2));
    iceWall.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(iceWall.size.width + 10, iceWall.size.height/2)];
    iceWall.zPosition = 40;
    iceWall.physicsBody.affectedByGravity = NO;
    iceWall.physicsBody.categoryBitMask = 0;
    iceWall.physicsBody.collisionBitMask = 0;
    iceWall.physicsBody.contactTestBitMask = 0;
    [sabotages addObject:iceWall];

}

+(void)setSabotageVectorY:(float)vectorY{
    
    SKSpriteNode *stone = sabotages[sabotages.count -2];
    SKSpriteNode *iceWall = sabotages[sabotages.count -1];
    stone.physicsBody.velocity = CGVectorMake(0, vectorY);
    iceWall.physicsBody.velocity = CGVectorMake(0, vectorY);
    
}





+(void)removeSabotage1{
    [sabotages[sabotages.count -1] removeFromParent];
}


+(void)removeSabotage2{
    [sabotages[sabotages.count -2] removeFromParent];
}





@end

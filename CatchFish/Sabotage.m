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

+(SKSpriteNode *)getFirstSavotage{
    return sabotages[0];
}

+(SKSpriteNode *)getLastSabotage{
    return sabotages[sabotages.count - 1];
}

+(void)sabotageInitTexture{

    sabotagesTexture = [NSMutableArray new];
    
    SKTexture *stone = [SKTexture textureWithImageNamed:@"stone"];
    SKTexture *iceWall = [SKTexture textureWithImageNamed:@"iceWall"];
    
    [sabotagesTexture addObject:stone];
    [sabotagesTexture addObject:iceWall];
    
}




    

+(void)addSabotage:(CGRect)frame{
    
    if(sabotages == nil){
        sabotages = [NSMutableArray new];
    }

    #pragma mark -
    #pragma mark 出現位置を調整
    CGPoint position = CGPointMake((arc4random_uniform(frame.size.width-60) + 30),(-(frame.size.height) + arc4random_uniform(frame.size.height)));;
    #pragma mark -
    
    
    if(arc4random_uniform(2) == 0){
        SKSpriteNode *stone = [SKSpriteNode spriteNodeWithTexture:sabotagesTexture[0]];
        stone.size = CGSizeMake(stone.size.width, stone.size.height);
        stone.position = position;
        stone.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(stone.size.width, 1) center:CGPointMake(0, -(stone.size.height/2))];
        stone.zPosition = 10000;
        stone.physicsBody.affectedByGravity = NO;
        stone.physicsBody.categoryBitMask = sabotageCategory;
        stone.physicsBody.collisionBitMask = 0;
        stone.physicsBody.contactTestBitMask = 0;
    
        [sabotages addObject:stone];
    
    }else{
        
        SKSpriteNode *iceWall = [SKSpriteNode spriteNodeWithTexture:sabotagesTexture[1]];
        iceWall.size = CGSizeMake(iceWall.size.width*2, iceWall.size.height*2);

        iceWall.position = position;
        iceWall.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(iceWall.size.width-10, 1) center:CGPointMake(0, -(iceWall.size.height/2))];
        iceWall.zPosition = 10000;
        iceWall.physicsBody.affectedByGravity = NO;
        iceWall.physicsBody.categoryBitMask = sabotageCategory;
        iceWall.physicsBody.collisionBitMask = 0;
        iceWall.physicsBody.contactTestBitMask = 0;
        [sabotages addObject:iceWall];
    }

}

+(void)setSabotageVectorY:(float)vectorY{
    
    for(SKSpriteNode *savotage in sabotages){
        savotage.physicsBody.velocity = CGVectorMake(0, vectorY);
    }
    
}





+(void)removeSabotage{
    
    [sabotages[0] removeFromParent];
    [sabotages removeObjectAtIndex:0];
    
    if(sabotages.count == 0){
        sabotages = nil;
    }
}


+(void)removeCollisionSabotage:(SKNode *)CollisionSabotage{
 
    /*
    for(int i = 0; i < sabotages.count; i++){
        
        if(CollisionSabotage == sabotages[i]){
            //親ノードから削除
            [sabotages[i] removeFromParent];
            //配列から削除
            [sabotages removeObjectAtIndex:i];
            //配列が0の場合はnilを代入
            if(sabotages.count == 0){
                sabotages = nil;
            }
            return;
        }
    }
     */
}




@end

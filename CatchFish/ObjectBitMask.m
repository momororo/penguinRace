//
//  ObjectBitMask.m
//  CatchFish
//
//  Created by 新井脩司 on 2014/08/20.
//  Copyright (c) 2014年 sacrew. All rights reserved.
//

#import "ObjectBitMask.h"

@implementation ObjectBitMask

//プレイヤーと地面か判定する
+(BOOL)penguinAndSabotage:(SKPhysicsContact *)contact{
    

    if((penguinCategory == contact.bodyA.categoryBitMask || penguinCategory == contact.bodyB.categoryBitMask) && (sabotageCategory == contact.bodyA.categoryBitMask || sabotageCategory == contact.bodyB.categoryBitMask)){
        return YES;
    }
    
    return NO;
    
    
}

+(BOOL)penguinAndGoalRoad:(SKPhysicsContact *)contact{

    if((penguinCategory == contact.bodyA.categoryBitMask || penguinCategory == contact.bodyB.categoryBitMask) && (goalRoadCategory == contact.bodyA.categoryBitMask || goalRoadCategory == contact.bodyB.categoryBitMask)){
        return YES;
    }
    
    return NO;

    
}


+(SKNode *)getSabotageFromContact:(SKPhysicsContact *)contact{
    
        if(sabotageCategory == contact.bodyA.categoryBitMask){
            return contact.bodyA.node;
        }else{
            return contact.bodyB.node;
        }
}


@end

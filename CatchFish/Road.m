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
}

+(void)moveRoadFromPenguinPosition:(CGPoint)penguinPosition nodeSelf:(SKNode*)nodeSelf frame:(CGFloat)selfFrame{
    
    
    CGPoint pt = [nodeSelf convertPoint:penguinPosition fromNode:road];
    
    NSLog(@"%@",NSStringFromCGPoint(pt));
    //!!!:無理矢理処理
    
    NSLog(@"【前】道のポジション：%@",NSStringFromCGPoint(road.position));

    
    road.position = CGPointMake(selfFrame, road.position.y + pt.y - penguinPosition.y);
    
    NSLog(@"【後】道のポジション：%@",NSStringFromCGPoint(road.position));
    
    NSLog(@"ペンギンのポジション：%@",NSStringFromCGPoint(penguinPosition));

}


@end
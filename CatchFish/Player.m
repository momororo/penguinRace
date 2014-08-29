//
//  Player.m
//  CatchFish
//
//  Created by 新井脩司 on 2014/08/20.
//  Copyright (c) 2014年 sacrew. All rights reserved.
//

#import "Player.h"

@implementation Player

//プレイヤー(魚)のノードを返す
+(SKSpriteNode *)getPlayer{
    return player;
}

//プレイヤー(魚)のテクスチャ作成
+(void)initTexture{
    fish = [SKTexture textureWithImageNamed:@"fish"];
}

//プレイヤー(魚)の配置設定
+(void)setPlayerPositionX:(float)positionX positionY:(float)positionY{
    
    player = [SKSpriteNode spriteNodeWithTexture:fish];
    player.size = CGSizeMake(player.size.width, player.size.height);
    player.position = CGPointMake(positionX, positionY);
    player.zPosition = 100000;
}

//プレイヤー(魚)の削除
+(void)removePlayer{
    [player removeFromParent];
}

//プレイヤー(魚)ノードをタップ位置に移動させる
+(void)movePlayerToX:(float)locationX moveToY:(float)locationY duration:(float)duration{
    [player runAction:[SKAction moveTo:CGPointMake(locationX,locationY) duration:duration]];
}

@end

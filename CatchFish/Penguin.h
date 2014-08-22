//
//  Penguin.h
//  CatchFish
//
//  Created by 新井脩司 on 2014/08/20.
//  Copyright (c) 2014年 sacrew. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

//ペンギンnode
SKSpriteNode *penguin;
//停止モーションテクスチャ
SKTexture *stopPenguinTexture;
//走るモーションアトラス
NSMutableArray *runPenguins;



@interface Penguin : NSObject

//ペンギンのノードを返す
+(SKSpriteNode *)getPenguin;
//ペンギンを生成する
+(void)setPenguinPositionX:(float)positionX positionY:(float)positionY;
//ペンギンのテクスチャーを作成
+(void)initTexture;
//走るモーション設定を行う
+(void)runAction;
//プレイヤー(魚)ノードを追いかけて見えるよう、ペンギンの向きを変える
+(void)setPenguinRotationFromPlayerPositionX:(float)positionX positionY:(float)positionY;
+(void)movePenguin;


//通常時のphysicsBody
//MARK:+(void)setNormalPhysicsBody;


@end

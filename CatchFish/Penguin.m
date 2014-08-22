//
//  Penguin.m
//  CatchFish
//
//  Created by 新井脩司 on 2014/08/20.
//  Copyright (c) 2014年 sacrew. All rights reserved.
//

#import "Penguin.h"

CGFloat accelete;
CGFloat zRotationX;
CGFloat zRotationY;

CGFloat penguinVectorX;
CGFloat penguinVectorY;


@implementation Penguin


//ペンギンのノードを返す
+(SKSpriteNode *)getPenguin{
    return penguin;
}

+(void)initTexture{
    
    //歩行停止(スタート時など)の設定
    stopPenguinTexture = [SKTexture textureWithImageNamed:@"stopPenguin"];
    
    //走るアトラスの設定
    runPenguins = [NSMutableArray new];
    SKTextureAtlas *runPenguin =[SKTextureAtlas atlasNamed:@"runPenguin"];
    SKTexture *runPenguin1 = [runPenguin textureNamed:@"runPenguin1"];
    SKTexture *runPenguin2 = [runPenguin textureNamed:@"runPenguin2"];
    [runPenguins addObject:runPenguin1];
    [runPenguins addObject:runPenguin2];
    
}

//初期設定
+(void)setPenguinPositionX:(float)positionX positionY:(float)positionY{
    
    //プレイキャラの設定
    penguin = [SKSpriteNode spriteNodeWithTexture:stopPenguinTexture];
    penguin.size = CGSizeMake(penguin.size.width/2,penguin.size.height/2);
    penguin.name = @"kPenguin";
    penguin.position = CGPointMake(positionX, positionY);
    
    NSLog(@"初期位置：%f",penguin.position.y);
    
    //physicsBodyの設定
    penguin.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:penguin.size];
    penguin.physicsBody.affectedByGravity = 0;
    
}

//走るモーション設定
+(void)runAction{
    
    //if(playerStatus != walkStatus){
        
        //走るモーション
        SKAction *runPenguin = [SKAction animateWithTextures:@[runPenguins[0],runPenguins[1]] timePerFrame:0.2];
         [penguin runAction:[SKAction repeatActionForever:runPenguin]];
        
        
        //playerStatus = walkStatus;
        
        //PhysicsBodyを通常時に
        //[self setNormalPhysicsBody];
    //}
    
}

//プレイヤー(魚)ノードを追いかけて見えるよう、ペンギンの向きを変える
+(void)setPenguinRotationFromPlayerPositionX:(float)positionX positionY:(float)positionY{

    CGFloat radian = (atan2f(-(penguin.position.x - positionX), (penguin.position.y - positionY)));
    
    CGFloat diff = fabsf(penguin.zRotation - radian);
    
    NSTimeInterval penguinRotationTime = diff/10;
    
    [penguin runAction:[SKAction rotateToAngle:radian duration:penguinRotationTime]];
}

//ペンギンの加速設定
+(void)setMovePenguin{
    zRotationX = sin(penguin.zRotation);
    zRotationY = cos(penguin.zRotation);
    
    accelete += 1;
    if (accelete > 200) {
        accelete = 200;
    }
    
    penguinVectorX = (accelete * zRotationX);
    penguinVectorY = (accelete * zRotationY);
    //penguin.physicsBody.velocity = CGVectorMake((accelete * x), -(accelete * y));
    penguin.physicsBody.velocity = CGVectorMake(penguinVectorX, 0);

}

//ペンギンの減速設定
+(void)setReducePenguin{
    
    zRotationX = sin(penguin.zRotation);
    zRotationY = cos(penguin.zRotation);
    
    accelete -= 1;
    
    if (accelete < 0) {
        accelete = 0;
    }
    
    penguinVectorX = (accelete * zRotationX);
    penguinVectorY = (accelete * zRotationY);
    //penguin.physicsBody.velocity = CGVectorMake((accelete * x), -(accelete * y));
    penguin.physicsBody.velocity = CGVectorMake(penguinVectorX, 0);



}

/* MARK:ペンギンの物理設定を分ける必要がある際に使う
+(void)setNormalPhysicsBody{
    penguin.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:penguin.size];
    penguin.physicsBody.affectedByGravity = 0;
}
*/

+(float)getVectorX{
    return penguinVectorX;
}

+(float)getVectorY{
    return penguinVectorY;
}

@end

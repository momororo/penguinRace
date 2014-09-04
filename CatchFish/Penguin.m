//
//  Penguin.m
//  CatchFish
//
//  Created by 新井脩司 on 2014/08/20.
//  Copyright (c) 2014年 sacrew. All rights reserved.
//

#import "Penguin.h"

CGFloat accelerate;
CGFloat zRotationX;
CGFloat zRotationY;

CGFloat penguinVectorX;
CGFloat penguinVectorY;

BOOL collisionFlag;


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
    
    //ペンギンの設定
    penguin = [SKSpriteNode spriteNodeWithTexture:stopPenguinTexture];
    penguin.size = CGSizeMake(penguin.size.width/2.5,penguin.size.height/2.5);
    penguin.name = @"kPenguin";
    penguin.position = CGPointMake(positionX, positionY);
    penguin.zPosition = 1000;
    
    
    //physicsBodyの設定
    penguin.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(penguin.size.width/2, penguin.size.height) center:CGPointMake(0, -(penguin.size.height/2))];
    penguin.physicsBody.affectedByGravity = 0;
    penguin.physicsBody.categoryBitMask = penguinCategory;
    penguin.physicsBody.collisionBitMask = wallCategory;
    penguin.physicsBody.contactTestBitMask = sabotageCategory | goalRoadCategory;
    
    NSLog(@"penguin: %f",penguin.physicsBody.mass);
}

//走るモーション設定
+(void)runActionSpeed:(int)speed{
    
    //if(playerStatus != walkStatus){
    
    //SKAction *runPenguin;
    
        //走るモーション
    /*switch (speed) {
        case 1:
            
            runPenguin = [SKAction animateWithTextures:@[runPenguins[0],runPenguins[1]] timePerFrame:0.2];
            [penguin runAction:[SKAction repeatActionForever:runPenguin]];
            
            break;
            
        case 2:
            
            runPenguin = [SKAction animateWithTextures:@[runPenguins[0],runPenguins[1]] timePerFrame:0.1];
            [penguin runAction:[SKAction repeatActionForever:runPenguin]];
            
            
        case 3:
            
            runPenguin = [SKAction animateWithTextures:@[runPenguins[0],runPenguins[1]] timePerFrame:0.05];
            [penguin runAction:[SKAction repeatActionForever:runPenguin]];
            
        default:
            break;
    }*/
    
    if (speed == 1) {
        SKAction *runPenguin = [SKAction animateWithTextures:@[runPenguins[0],runPenguins[1]] timePerFrame:0.2];
        [penguin runAction:[SKAction repeatActionForever:runPenguin]];
    }else if(speed == 2){
        SKAction *runPenguin = [SKAction animateWithTextures:@[runPenguins[0],runPenguins[1]] timePerFrame:0.1];
        [penguin runAction:[SKAction repeatActionForever:runPenguin]];
        NSLog(@"スピード2が実装！");
    }else if (speed == 3){
        SKAction *runPenguin = [SKAction animateWithTextures:@[runPenguins[0],runPenguins[1]] timePerFrame:0.05];
        [penguin runAction:[SKAction repeatActionForever:runPenguin]];
        NSLog(@"スピード3が実装！");
    }
    
    //NSLog(@"%f",(accelete*2/(1000+accelete)));
       //playerStatus = walkStatus;
        
        //PhysicsBodyを通常時に
        //[self setNormalPhysicsBody];
    //}z
    
}

//タップした時、プレイヤー(魚)ノードを追いかけて見えるよう、ペンギンの向きを変える
+(void)setPenguinRotationFromPlayerPositionX:(float)positionX positionY:(float)positionY{

    CGFloat radian = (atan2f(-(penguin.position.x - positionX), (penguin.position.y - positionY)));
    
    CGFloat diff = fabsf(penguin.zRotation - radian);
    
    NSTimeInterval penguinRotationTime = diff/10;
    
    
    [penguin runAction:[SKAction rotateToAngle:radian duration:penguinRotationTime]];
}

//タッチアップした時、ペンギンを正面に向かせる処理
+(void)resetPenguinRotationPositionX:(float)positionX positionY:(float)positionY{
    
    CGFloat radian = (atan2f(-(penguin.position.x - positionX), (penguin.position.y - positionY)));
    
    CGFloat diff = fabsf(penguin.zRotation - radian);
    
    NSTimeInterval penguinRotationTime = diff/10;
    
    [penguin runAction:[SKAction rotateToAngle:radian duration:penguinRotationTime]];

}

//ペンギンの加速設定
+(void)setAcceleratePenguin:(float)playerPositionY frameY:(float)frameY playerPositionX:(float)playerPositionX{
    zRotationX = sin(penguin.zRotation);
    zRotationY = cos(penguin.zRotation);
    
    accelerate += 1;
    
    //速度制限(最大568)
    if (accelerate > (frameY - playerPositionY)/2) {
        //タップ位置がペンギンの初期位置(フレーム最奥)より遠ければ遠いほど加速する
        accelerate = (frameY - playerPositionY)/2;
    }
    
    penguinVectorX = (accelerate * zRotationX);
    penguinVectorY = (accelerate * zRotationY) * 3;
    

    [penguin runAction:[SKAction moveToX:playerPositionX duration:0.1]];
    
    

}

//ペンギンの減速設定
+(void)setReducePenguin{
    
    zRotationX = sin(penguin.zRotation);
    zRotationY = cos(penguin.zRotation);
    
    accelerate -= 1;
    
    if (accelerate < 0) {
        accelerate = 0;
    }
    //NSLog(@"減速%f",accelerate);

    penguinVectorX = (accelerate * zRotationX);
    penguinVectorY = (accelerate * zRotationY);
    //penguin.physicsBody.velocity = CGVectorMake((accelete * x), -(accelete * y));
    penguin.physicsBody.velocity = CGVectorMake(penguinVectorX, 0);


}

//ペンギンの衝突設定
+(void)setCollisionPenguin{
    
    zRotationX = sin(penguin.zRotation);
    zRotationY = cos(penguin.zRotation);
    
    accelerate -= 50;
    
    if (accelerate < 0) {
        accelerate = 0;
    }
    
    penguinVectorX = (accelerate * zRotationX);
    penguinVectorY = (accelerate * zRotationY);
    penguin.physicsBody.velocity = CGVectorMake(penguinVectorX, penguinVectorY);
    
    collisionFlag = YES;
    
    
    
    
    
}

//タップ位置に向かってペンギンが動く
+(void)setPenguinEatPlayer:(float)playerPositionY playerSize:(float)playerSize frameY:(float)frameY{
    
    float positionY = frameY - accelerate;
    
    if (positionY > frameY*9/10) {
        positionY = frameY *9/10;
    }else{
      
        [penguin runAction:[SKAction moveToY:frameY - accelerate duration:0.1]];
    
    }
    

}

//タッチアップした際にペンギンが元の位置に戻る
+(void)setPenguinDisapperPlayer:(float)frameY{
    
    float positionY = frameY - accelerate;
    
    if (positionY > frameY*9/10) {
        positionY = frameY *9/10;
    }else{

        [penguin runAction:[SKAction moveToY:frameY - accelerate duration:0.1]];
        
    }
}







/* MARK:ペンギンの物理設定を分ける必要がある際に使う
+(void)setNormalPhysicsBody{
    penguin.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:penguin.size];
    penguin.physicsBody.affectedByGravity = 0;
}
*/

+(float)getAccelerate{
    return accelerate;
}

+(float)getVectorX{
    return penguinVectorX;
}

+(float)getVectorY{
    return penguinVectorY;
}

@end

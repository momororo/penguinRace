//
//  GameScene.m
//  CatchFish
//
//  Created by 新井脩司 on 2014/08/20.
//  Copyright (c) 2014年 sacrew. All rights reserved.
//

#import "GameScene.h"

@implementation GameScene{
    
    
    SKLabelNode *startLabel;
    BOOL touchBeganFlag;
    BOOL touchMoveFlag;
    BOOL touchEndedFlag;
    
    BOOL gameStartFlag;
    
    BOOL walkFlag;
    BOOL runFlag;
    BOOL fastRunFlag;
    


}


-(id)initWithSize:(CGSize)size{
    
    if (self == [super initWithSize:size]) {



        
        //走る道の設定
        [Road initTexture];
        [Road setRoadFrameX:self.frame.size.width frameY:self.frame.size.height];
        [self addChild:[Road getNextRoad1]];
        [self addChild:[Road getNextRoad2]];
        
    
        //MARK:テスト用のスタートラベル、後々消去
        startLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        startLabel.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        startLabel.text = @"テスト";
        startLabel.fontSize = 40;
        startLabel.name = @"kStartLabel";
        startLabel.fontColor = [SKColor whiteColor];
        [self addChild:startLabel];
        
        
        
        
        //ペンギンの設定
        [Penguin initTexture];
        [Penguin setPenguinPositionX:CGRectGetMidX(self.frame) positionY:CGRectGetMaxY(self.frame)*9/10];
        [self addChild:[Penguin getPenguin]];
        
        //プレイヤー(魚)の設定
        [Player initTexture];
        
        //障害物の設定
        [Sabotage sabotageInitTexture];
        
        //障害物の作成
        SKAction *makeSabotage = [SKAction sequence:
                                  @[[SKAction performSelector:@selector(addSabotage) onTarget:self],
                                    [SKAction waitForDuration:1.5 withRange:1.0]]];
        [self runAction: [SKAction repeatActionForever:makeSabotage]];
        
    }
    
    return self;

}


//障害物のランダム発生
-(void)addSabotage{
    //障害物の生成準備
    [Sabotage addSabotage:self.frame];

    NSMutableArray *sabotages = [Sabotage getSabotageInit];
    [self addChild:sabotages[0]];
    [self addChild:sabotages[1]];
    
}



#pragma mark-
#pragma mark ゲーム画面がタップされた際の処理
//???:ダブルタップするとノードが残る
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    //タップ位置情報の取得
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    
    //スタートラベルが表示されている時のみ入る処理
    if ([self childNodeWithName:@"kStartLabel"]) {
    
        //スタートラベルがタップされた時に行う処理
        if ([startLabel containsPoint:location]) {
            
            //スタートラベルの削除
            [startLabel removeFromParent];
            
            //ゲームスタートフラグをON
            gameStartFlag = YES;
            

        }
    }
    
    /*      MARK:ゲームオーバー処理
     
     if([self childNodeWtihName:@"gameOver"]){
     
     }
    */
    
    /*      MARK:ゲームクリア処理
     
     if([self childNodeWtihName:@"gameClear"]){
     
     }
     
     
     */
    
    //ペンギンの位置よりもタップ位置が低い時の動作
    if ([Penguin getPenguin].position.y - [Player getPlayer].size.height/2 > location.y) {
    
        if (gameStartFlag == YES && touchBeganFlag == NO) {
            [Player setPlayerPositionX:location.x positionY:location.y];
            [self addChild:[Player getPlayer]];
            touchBeganFlag = YES;
            touchEndedFlag = NO;
            
        }

    }
    
}



#pragma mark-
#pragma mark 画面スワイプ時の処理
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    //プレイヤーがある場合
    if ([Player getPlayer]) {
        
        //スワイプ時の位置の取得
        UITouch *touch = [touches anyObject];
        CGPoint location = [touch locationInNode:self];
        
        //ペンギンの位置よりもタップ位置が低い時の動作
        if ([Penguin getPenguin].position.y - [Player getPlayer].size.height/2 > location.y) {
        
            //取得位置からプレイヤー(魚)ノードのポジションを変更
            [Player movePlayerToX:location.x moveToY:location.y duration:0];
        
            //動いている際のフラグON
            touchMoveFlag = YES;
        }
    }
}



#pragma mark-
#pragma mark タップ終了時の処理
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    //プレイヤーノードの削除
    if ([Player getPlayer] ) {
        [Player removePlayer];
        //タップ＆スワイプ時のフラグOFF
        touchBeganFlag = NO;
        touchMoveFlag = NO;
        touchEndedFlag = YES;
        
        
    }

}


-(void)didSimulatePhysics{
    
    
    
    
    /*********************************
     画面タッチ・スワイプのフラグがONの場合、
     ペンギン・道を動かす
    **********************************/
    //MARK: touchMoveFlag　なくても問題なし、場合によっては消す
    if (touchMoveFlag == YES || touchBeganFlag == YES) {
        
        //プレーヤー(魚)ノードを追いかけて見えるよう、向きを変える処理
        [Penguin setPenguinRotationFromPlayerPositionX:([Player getPlayer].position.x) positionY:([Player getPlayer].position.y)];
        
        //ペンギンの加速設定
        [Penguin setAcceleratePenguin:[Player getPlayer].position.y frameY:self.frame.size.height playerPositionX:[Player getPlayer].position.x];
        
        [Penguin setPenguinEatPlayer:[Player getPlayer].position.y playerSize:[Player getPlayer].size.height frameY:self.frame.size.height];
        
        //道を動かす処理
        [Road setMoveRoadVectorY:([Penguin getVectorY])];
        
        //障害物を動かす処理
        [Sabotage setSabotageVectorY:([Penguin getVectorY])];
        
    }
    
    /*********************************
     画面タップを終えた場合、
     ペンギン・道を減速する
     **********************************/
    
    if (touchEndedFlag == YES) {
        //ペンギンの減速設定
        [Penguin setReducePenguin];
        [Penguin resetPenguinRotationPositionX:([Player getPlayer].position.x) positionY:([Player getPlayer].position.y)];
        //道の減速
        [Road setMoveRoadVectorY:([Penguin getVectorY])];
        [Penguin setPenguinDisapperPlayer:self.frame.size.height];
        //障害物を動かす処理
        [Sabotage setSabotageVectorY:([Penguin getVectorY])];
    }
    
    //道の消去
    if ([Road getNextRoad1].position.y - [Road getNextRoad1].size.height/2+[Road getNextRoad1].size.height/8 >= (self.frame.size.height)) {
        [Road setNextRoadframeX:self.frame.size.width frameY:self.frame.size.height];
    }
    
    if ([Sabotage getSabotages1].position.y >= (self.frame.size.height)+[Sabotage getSabotages1].size.height/2) {
        [Sabotage removeSabotage1];
    }
    
    if ([Sabotage getSabotages1].position.y >= (self.frame.size.height)+[Sabotage getSabotages2].size.height/2) {
        [Sabotage removeSabotage2];
    }
    
    
    //MARK:ペンギンのテクスチャ動作(直せたらなおす)
    /*if ([Penguin getAccelerate] == 1 || [Penguin getAccelerate] == 100) {
        [Penguin runActionSpeed:1];
        NSLog(@"SPEED:1");
    }else if ([Penguin getAccelerate] == 101 || [Penguin getAccelerate] == 300){
        [Penguin runActionSpeed:2];
        NSLog(@"SPEED:2");
    }else if ([Penguin getAccelerate] == 301){
        [Penguin runActionSpeed:3];
        NSLog(@"SPEED:3");
    }
    */
    
    
    if ([Penguin getPenguin].position.y < self.frame.size.height *9 / 10 && [Penguin getPenguin].position.y > self.frame.size.height *2/3) {
        
        
        if (walkFlag == YES) {
            return;
        }
        
        walkFlag = YES;
        runFlag = NO;
        fastRunFlag = NO;
        [Penguin runActionSpeed:1];
        
    }else if ([Penguin getPenguin].position.y < self.frame.size.height *2/3 && [Penguin getPenguin].position.y > self.frame.size.height/2) {
        
        if (runFlag == YES) {
            return;
        }
        
        runFlag = YES;
        walkFlag = NO;
        fastRunFlag = NO;
        [Penguin runActionSpeed:2];
    
    }else if ([Penguin getPenguin].position.y <= self.frame.size.height / 2) {
        
        if (fastRunFlag == YES) {
            return;
        }
        
        fastRunFlag = YES;
        walkFlag = NO;
        fastRunFlag = NO;
        [Penguin runActionSpeed:3];
    
    }
    
}




@end

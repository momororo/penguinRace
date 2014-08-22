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
    
    BOOL gameStartFlag;
    


}


-(id)initWithSize:(CGSize)size{
    
    
    if (self == [super initWithSize:size]) {


        
        //走る道の設定
        [Road initTexture];
        [Road setRoadFrameX:self.frame.size.width frameY:self.frame.size.height];
        [self addChild:[Road getRoad]];
        
    
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

        
    }
    return self;
}

#pragma mark-
#pragma mark ゲーム画面がタップされた際の処理
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
            
            //MARAK:あとで消す
            [Penguin runAction];
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
    if (gameStartFlag == YES) {
        [Player setPlayerPositionX:location.x positionY:location.y];
        [self addChild:[Player getPlayer]];
        touchBeganFlag = YES;
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
        
        //取得位置からプレイヤー(魚)ノードのポジションを変更
        [Player movePlayerToX:location.x moveToY:location.y duration:0];
        
        //動いている際のフラグON
        touchMoveFlag = YES;
        
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
    }

}


-(void)didSimulatePhysics{
    
    
    //MARK: touchMoveFlag　なくても問題なし、場合によっては消す
    if (touchMoveFlag == YES || touchBeganFlag == YES) {
        
        //プレーヤー(魚)ノードを追いかけて見えるよう、向きを変える処理
        [Penguin setPenguinRotationFromPlayerPositionX:([Player getPlayer].position.x) positionY:([Player getPlayer].position.y)];
        
        //ペンギンを動かす処理
        [Penguin movePenguin];
        
        
        //道を動かす処理
        [Road moveRoadFromPenguinPosition:([Penguin getPenguin].position) nodeSelf:(self) frame:(CGRectGetMidX(self.frame))];
        
        
        
    }
}




@end

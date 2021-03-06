//

//  GameScene.m

//  CatchFish

//

//  Created by 新井脩司 on 2014/08/20.

//  Copyright (c) 2014年 sacrew. All rights reserved.

//



#import "GameScene.h"

#if __has_feature(objc_arc)
#  define IF_NO_ARC(x)
#else
#  define IF_NO_ARC(x) x
#endif




@implementation GameScene{
    
    
    
    
    SKSpriteNode *startLabel;
    SKSpriteNode *goalLabel;
    SKLabelNode  *startLabelLiteral;
    
    SKLabelNode *scoreLabel;
    
    BOOL touchBeganFlag;
    
    BOOL touchMoveFlag;
    
    BOOL touchEndedFlag;
    
    
    
    BOOL gameStartFlag;
    BOOL gameGoalFrag;
    BOOL gameResultFlag;
    
    
    
    BOOL walkFlag;
    
    BOOL runFlag;
    
    BOOL fastRunFlag;
    
    SKSpriteNode *topButton;
    SKLabelNode *topButtonLiteral;
    SKSpriteNode *dummyTopButton;
    
    SKSpriteNode *retryButton;
    SKLabelNode *retryButtonLiteral;
    SKSpriteNode *dummyRetryButton;
    
    //パーティクル（スパーク）
    SKEmitterNode *_particleSpark;
    
    
    //ゴール用のカウント
    int goalCount;
    //スタート時のカウントダウン
    NSDate *countDate;
    //カウントダウンフラグ
    bool startCountFrag;
    
    //トップボタンフラグ
    BOOL topButtonFrag;
    //リトライボタンフラグ
    BOOL retryButtonFrag;
    
    //レコード保存よう
    float score;
    
    //アスタ関係
    MrdIconLoader *iconLoader;
    MrdIconCell *iconCell1;
    MrdIconCell *iconCell2;
    MrdIconCell *iconCell3;
    MrdIconCell *iconCell4;
    MrdIconCell *iconCell5;
    MrdIconCell *iconCell6;
    MrdIconCell *iconCell7;
    MrdIconCell *iconCell8;

}





-(id)initWithSize:(CGSize)size{
    
    
    
    if (self == [super initWithSize:size]) {
        
        
        

        
        
        
        //走る道の設定
        
        [Road initTexture];
        
        [Road setRoadFrameX:self.frame.size.width frameY:self.frame.size.height];
        
        [self addChild:[Road getNextRoad1]];
        
        [self addChild:[Road getNextRoad2]];
        
        
        
        //壁の設定
        
        [Wall setWallFrameX:self.frame.size.width frameY:self.frame.size.height];
        
        [self addChild:[Wall getWallLeft]];
        
        [self addChild:[Wall getWallRight]];
        
        
        
        
        
        //MARK:テスト用のスタートラベル、後々消去
        
        startLabel = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(self.frame.size.width, self.frame.size.height/8)];
        startLabel.position = CGPointMake(CGRectGetMidX(self.frame), self.frame.size.height/10*6);
        startLabel.name = @"kStartLabel";
        
        [self addChild:startLabel];
        
        
        startLabelLiteral = [SKLabelNode labelNodeWithFontNamed:@"Impact"];
        startLabelLiteral.fontSize = 40;
        startLabelLiteral.name = @"kStartLabelLiteral";
        startLabelLiteral.fontColor = [SKColor whiteColor];
        startLabelLiteral.position = CGPointMake(0,0);
        startLabelLiteral.text = @"START";
        startLabelLiteral.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
        startLabelLiteral.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
        
        [startLabel addChild:startLabelLiteral];
        
        
        //ゴール用のラベルを作成しておく
        goalLabel = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(self.frame.size.width, self.frame.size.height/8)];
        goalLabel.position = CGPointMake(-self.frame.size.width, self.frame.size.height/10*6);
        goalLabel.name = @"kGoalLabel";
        goalLabel.zPosition = 20000;
        [self addChild:goalLabel];

        SKLabelNode *goalLabelLiteral = [SKLabelNode labelNodeWithFontNamed:@"Impact"];
        goalLabelLiteral.fontSize = 40;
        goalLabelLiteral.fontColor = [SKColor whiteColor];
        goalLabelLiteral.position = CGPointMake(0,0);
        goalLabelLiteral.name = @"kGoalLabel";
        goalLabelLiteral.text = @"GOAL!!";
        goalLabelLiteral.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
        goalLabelLiteral.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
        
        [goalLabel addChild:goalLabelLiteral];
    
        
        //スコアラベルの設定
        scoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Impact"];
        scoreLabel.text = @"TIME 00:00:00";
        scoreLabel.position = CGPointMake(0, self.frame.size.height/10*9);
        scoreLabel.fontColor = [SKColor blackColor];
        scoreLabel.fontSize = 20;
        scoreLabel.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
        scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
        scoreLabel.zPosition = 1000000;
        
        [self addChild:scoreLabel];
        
        
        
        
        //ペンギンの設定
        
        [Penguin initTexture];
        
        [Penguin setPenguinPositionX:CGRectGetMidX(self.frame) positionY:CGRectGetMaxY(self.frame)*9/10];
        
        [self addChild:[Penguin getPenguin]];
        
        //初期のペンギンの設定を細工
        [Penguin getPenguin].physicsBody.dynamic = NO;
        [Penguin getPenguin].physicsBody.categoryBitMask = 0;
        
        
        
        //プレイヤー(魚)の設定
        
        [Player initTexture];
        
        
        
        //障害物の設定
        
        [Sabotage sabotageInitTexture];
        
        
        
        
        
        //ゴールのカウントの設定
#pragma mark ゴールカウント
        goalCount = 35;
        
        
        
        //デリゲートの設定
        
        self.physicsWorld.contactDelegate = self;
        
        //ゲームスタート、ゴールフラグをNOに
        gameStartFlag = NO;
        gameGoalFrag = NO;
        gameResultFlag = NO;
        startCountFrag = NO;
        

        
        
        
        
        
    }
    
    /**
     *  nend
     */
    //nadViewの生成
    self.nadView = [[NADView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.frame) - 50 , 320, 50)];
    //ログ出力の設定
    self.nadView.isOutputLog = NO;
    
    //setapiKey
    [self.nadView setNendApiKey:@"9cb335fb30407346b92feaf4bdaf930d82cfb6b2"];
    [self.nadView setNendSpotID:@"226540"];
    [self.nadView setDelegate:self];
    [self.nadView load];
    
    /**
     *  アスタ
     */
    iconLoader = [[MrdIconLoader alloc]init];
    

    
    
    //アイコン1つめ
    CGRect frame1 = CGRectMake(self.frame.size.width/4 - 75, self.frame.size.height/6*1, 75, 75);
    iconCell1 = [[MrdIconCell alloc]initWithFrame:frame1];
    iconCell1.titleTextColor =[UIColor blackColor];
    
    //アイコン2つめ
    CGRect frame2 = CGRectMake(frame1.origin.x + frame1.size.width, self.frame.size.height/6*1, 75, 75);
    iconCell2 = [[MrdIconCell alloc]initWithFrame:frame2];
    iconCell2.titleTextColor =[UIColor blackColor];

    
    //アイコン3つめ
    CGRect frame3 = CGRectMake(frame2.origin.x + frame2.size.width, self.frame.size.height/6*1, 75, 75);
    iconCell3 = [[MrdIconCell alloc]initWithFrame:frame3];
    iconCell3.titleTextColor =[UIColor blackColor];
    
    //アイコン4つめ
    CGRect frame4 = CGRectMake(frame3.origin.x + frame3.size.width, self.frame.size.height/6*1, 75, 75);
    iconCell4 = [[MrdIconCell alloc]initWithFrame:frame4];
    iconCell4.titleTextColor =[UIColor blackColor];
    
    
    //アイコン5つめ
    CGRect frame5 = CGRectMake(self.frame.size.width/4 - 75, self.frame.size.height/6*4, 75, 75);
    iconCell5 = [[MrdIconCell alloc]initWithFrame:frame5];
    iconCell5.titleTextColor =[UIColor blackColor];
    
    //アイコン6つめ
    CGRect frame6 = CGRectMake(frame5.origin.x + frame1.size.width, self.frame.size.height/6*4, 75, 75);
    iconCell6 = [[MrdIconCell alloc]initWithFrame:frame6];
    iconCell6.titleTextColor =[UIColor blackColor];
    
    //アイコン7つめ
    CGRect frame7 = CGRectMake(frame6.origin.x + frame2.size.width, self.frame.size.height/6*4, 75, 75);
    iconCell7 = [[MrdIconCell alloc]initWithFrame:frame7];
    iconCell7.titleTextColor =[UIColor blackColor];
    
    //アイコン8つめ
    CGRect frame8 = CGRectMake(frame7.origin.x + frame3.size.width, self.frame.size.height/6*4, 75, 75);
    iconCell8 = [[MrdIconCell alloc]initWithFrame:frame8];
    iconCell8.titleTextColor =[UIColor blackColor];
    
    
    //アイコンの追加
    [iconLoader addIconCell:iconCell1];
    [iconLoader addIconCell:iconCell2];
    [iconLoader addIconCell:iconCell3];
    [iconLoader addIconCell:iconCell4];
    [iconLoader addIconCell:iconCell5];
    [iconLoader addIconCell:iconCell6];
    [iconLoader addIconCell:iconCell7];
    [iconLoader addIconCell:iconCell8];
    

    
    
    
    return self;
    
    
    
}











#pragma mark-

#pragma mark ゲーム画面がタップされた際の処理

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    
    
    //タップ位置情報の取得
    
    UITouch *touch = [touches anyObject];
    
    CGPoint location = [touch locationInNode:self];
    
    
    
    if(gameResultFlag == YES){
        
        
        if([dummyTopButton containsPoint:location]){
            
            
            
            [topButton runAction:[SKAction moveToY:topButton.position.y-10 duration:0]];
            topButtonFrag = YES;
            return;
            
        }
        
        
        if([dummyRetryButton containsPoint:location]){
            
            [retryButton runAction:[SKAction moveToY:retryButton.position.y-10 duration:0]];
            retryButtonFrag = YES;
            return;
            
        }
        
        
    }
    
    
    
    //スタートラベルが表示されている時のみ入る処理
    
    if ([self childNodeWithName:@"kStartLabel"]) {
        
        
        //スタートラベルがタップされた時に行う処理
#pragma mark スタートのカウントダウン処理
        if (startCountFrag == NO) {
            
            
            startCountFrag = YES;
            
            //カウントダウン用の変数
            countDate = [NSDate date];
            
            
        }
        
        return;
        
    }
    
    
    
    //ペンギンの位置よりもタップ位置が低い時の動作
    
    if (([Penguin getPenguin].position.y - [Player getPlayer].size.height/2 > location.y)) {
        
        
        //ゴール時は処理をさせない
        if(gameGoalFrag == YES){
            return;
        }
        
        //スタート前は処理させない
        if(gameStartFlag == NO){
            return;
        }

        
        if (gameStartFlag == YES && touchBeganFlag == NO) {
            
            if (location.x >= (self.frame.size.width - self.frame.size.width/17)){
                
                
                
                location.x =(self.frame.size.width - self.frame.size.width/17);
                
            }
            
            
            
            if (location.x <= self.frame.size.width /17){
                
                
                
                location.x =(self.frame.size.width / 17);
                
                
                
            }
            
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
    
    
    
    
    if(gameResultFlag == YES){
        
        //スワイプ時の位置の取得
        UITouch *touch = [touches anyObject];
        CGPoint location = [touch locationInNode:self];
        
        
        if(topButtonFrag == YES){
            
            if([dummyTopButton containsPoint:location]){
                
                return;
                
            }else{
                
                [topButton runAction:[SKAction moveToY:dummyTopButton.position.y duration:0]];
                topButtonFrag = NO;
                
            }
            
        }
        
        if(retryButtonFrag == YES){
            
            if([dummyRetryButton containsPoint:location]){
                
                return;
                
            }else{
                
                [retryButton runAction:[SKAction moveToY:dummyRetryButton.position.y duration:0]];
                retryButtonFrag = NO;
                
            }
            
        }
        
    }

    
    //プレイヤーがある場合
    
    if ([Player getPlayer]) {
        
        
        
        //スワイプ時の位置の取得
        
        UITouch *touch = [touches anyObject];
        
        CGPoint location = [touch locationInNode:self];
        
        
        
        
        
        
        
        //ペンギンの位置よりもタップ位置が低い時の動作
        
        if ([Penguin getPenguin].position.y - [Player getPlayer].size.height/2 > location.y) {
            
            
            //ゴール時は処理をさせない
            if(gameGoalFrag == YES){
                return;
            }
            
            //スタートしていない時も処理させない
            if(gameStartFlag == NO){
                return;
            }
            
            
            //画面端にムーブした場合、ロケーションの位置を修正する
            
            if (location.x >= (self.frame.size.width - self.frame.size.width/17)){
                
                
                
                location.x =(self.frame.size.width - self.frame.size.width/17);
                
            }
            
            
            
            if (location.x <= self.frame.size.width /17){
                
                
                
                location.x =(self.frame.size.width / 17);
                
                
                
            }
            
            
            
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
    


    if(gameResultFlag == YES){
        
        //スワイプ時の位置の取得
        UITouch *touch = [touches anyObject];
        CGPoint location = [touch locationInNode:self];
        
        
        if(topButtonFrag == YES){
            
            if([dummyTopButton containsPoint:location]){
                
                
                [topButton runAction:[SKAction moveToY:dummyRetryButton.position.y duration:0]];
                
                
                if ([_delegate respondsToSelector:@selector(sceneEscape:identifier:)]) {
                    
                    /**
                     *  nend終了(viewから削除するときは加えてremoveFromSuperViewも唱えよう)
                     */
                    [self.nadView setDelegate:nil];
                    [self.nadView removeFromSuperview];
                    self.nadView = nil;
                    
                    [[NADInterstitial sharedInstance] setDelegate:nil];
                    
                    
                     //アスタ終了
                     [iconLoader removeIconCell:iconCell1];
                     [iconLoader removeIconCell:iconCell2];
                     [iconLoader removeIconCell:iconCell3];
                     [iconLoader removeIconCell:iconCell4];
                     [iconLoader removeIconCell:iconCell5];
                     [iconLoader removeIconCell:iconCell6];
                     [iconLoader removeIconCell:iconCell7];
                     [iconLoader removeIconCell:iconCell8];

                     [iconCell1 removeFromSuperview];
                     [iconCell2 removeFromSuperview];
                     [iconCell3 removeFromSuperview];
                     [iconCell4 removeFromSuperview];
                     [iconCell5 removeFromSuperview];
                     [iconCell6 removeFromSuperview];
                     [iconCell7 removeFromSuperview];
                     [iconCell8 removeFromSuperview];
                    
                    
                    
                    [_delegate sceneEscape:self identifier:@"top"];
                    
                }
                
                
            }else{
                
                topButtonFrag = NO;
                
            }
            
        }
        
        if(retryButtonFrag == YES){
            
            if([dummyRetryButton containsPoint:location]){
                
                [retryButton runAction:[SKAction moveToY:dummyRetryButton.position.y duration:0]];
                
                if ([_delegate respondsToSelector:@selector(sceneEscape:identifier:)]) {
                    
                    /**
                     *  nend終了(viewから削除するときは加えてremoveFromSuperViewも唱えよう)
                     */
                    [self.nadView setDelegate:nil];
                    [self.nadView removeFromSuperview];
                    self.nadView = nil;
                    
                    [[NADInterstitial sharedInstance] setDelegate:nil];
                    
                    
                    
                    //アスタ終了
                    [iconLoader removeIconCell:iconCell1];
                    [iconLoader removeIconCell:iconCell2];
                    [iconLoader removeIconCell:iconCell3];
                    [iconLoader removeIconCell:iconCell4];
                    [iconLoader removeIconCell:iconCell5];
                    [iconLoader removeIconCell:iconCell6];
                    [iconLoader removeIconCell:iconCell7];
                    [iconLoader removeIconCell:iconCell8];
                    
                    [iconCell1 removeFromSuperview];
                    [iconCell2 removeFromSuperview];
                    [iconCell3 removeFromSuperview];
                    [iconCell4 removeFromSuperview];
                    [iconCell5 removeFromSuperview];
                    [iconCell6 removeFromSuperview];
                    [iconCell7 removeFromSuperview];
                    [iconCell8 removeFromSuperview];
                    
                    
                    [_delegate sceneEscape:self identifier:@"retry"];
                    
                }
                
            }else{
                
                retryButtonFrag = NO;
                
            }
            
        }
        
    }

    if(gameStartFlag == NO){
        
        return;
    }

    
    
    //プレイヤーノードの削除
    
    if ([Player getPlayer] ) {
        
        [Player removePlayer];
        
        //タップ＆スワイプ時のフラグOFF
        
        touchBeganFlag = NO;
        
        touchMoveFlag = NO;
        
        touchEndedFlag = YES;
        
        
        
        
        
    }
    
    

    
    
    
}





//オブジェクト同士が衝突した場合に動く処理
#pragma mark didBeginContact
- (void)didBeginContact:(SKPhysicsContact *)contact

{
    
    
    [self makeSparkParticle:contact.contactPoint];

    
    //スタートラベルがある時は処理を飛ばす
    
    if([self childNodeWithName:@"kStartLabel"] != nil){
        
        return;
        
    }
    
    //ゴール時は処理せず終了
    if(gameGoalFrag == YES){
        return;
    }

    
    
    
    //ペンギンと障害物の衝突検知
    
    if([ObjectBitMask penguinAndSabotage:contact]){
        
        
        
        //ペンギンの減速処理
        
        [Penguin setCollisionPenguin];
        
        
        
        //衝突した障害物を排除する
        
        [Sabotage removeCollisionSabotage:[ObjectBitMask getSabotageFromContact:contact]];
        
        
        
    }
    //ゴールの処理
    if([ObjectBitMask penguinAndGoalRoad:contact]){

        gameGoalFrag = YES;

        
        SKAction *goalAction = [SKAction moveToX:CGRectGetMidX(self.frame) duration:1];
        [goalLabel runAction:goalAction];
        
        //タッチエンドの処理を走らせちゃう
        [Player removePlayer];
        
        //タップ＆スワイプ時のフラグOFF
        
        touchBeganFlag = NO;
        
        touchMoveFlag = NO;
        
        touchEndedFlag = YES;
        
        //ゴール後のペンギンの挙動を綺麗にするために設定
        [Penguin getPenguin].physicsBody.allowsRotation = NO;
        [Penguin getPenguin].physicsBody.categoryBitMask = 0;

    
        
    }
    
}




#pragma mark didSimulateメソッド
-(void)didSimulatePhysics{
    
    //ゲームスタートのカウントダウン処理
    if(startCountFrag == YES){
        
#pragma mark カウントダウンの処理をじっそうしようね
        //カウントダウン処理
        NSDate *nowDate = [NSDate date];
        float intervalDate = [nowDate timeIntervalSinceDate:countDate];
                
        if(intervalDate <= 3){
            
            //ラベルの内容を変更
            startLabelLiteral.text = [NSString stringWithFormat:@"%d",(int)(4 - intervalDate)];
            
        }else{
            
            //スタートラベルの削除
            [startLabel removeFromParent];
            //スタートのカウントダウン
            gameStartFlag = YES;
            
            //カウントフラグをオフに
            startCountFrag = NO;
            
            //ゲームレコード用に再利用
            countDate = [NSDate date];
            
            //ペンギンの設定を小細工
            [Penguin getPenguin].physicsBody.dynamic = YES;
            [Penguin getPenguin].physicsBody.categoryBitMask = penguinCategory;
            
        }
        
        return;
        
    }
    
    if(gameStartFlag == YES && gameGoalFrag == NO){
        
        NSDate *nowDate = [NSDate date];
        score = [nowDate timeIntervalSinceDate:countDate];
        
        int min = (float)score / 60;
        
        int sec = ((float)score - min * 60) / 1;
        
        int secdiv60 = (int)((float)score * 100) % 100;
        
        //ゲームレコードの更新(時間を変換しノードに反映すること)
        scoreLabel.text = [NSString stringWithFormat:@"TIME %02d:%02d:%02d",min,sec,secdiv60];
        
    }
    
    //ゴール時の処理
    if(gameGoalFrag == YES && [Penguin getAccelerate]  != 0){

        [Penguin setReducePenguin];
        
        if([Penguin getAccelerate] <= 30){
            
            //フラグの設定
            gameStartFlag = NO;
            gameGoalFrag = NO;
            gameResultFlag = YES;
            
            //ペンギンの動きを止める
            [[Penguin getPenguin] removeAllActions];

            //ベクトルをなくす処理を入れること。
            
            //ゴールの処理へ
            [self goalMethod];
            


        }
        //ここにreturnは入れない!!(以降の地面のスクロール処理がスキップされるため)
    }
    
    //これなんの処理だっけ、、、、
    if(gameResultFlag == YES){
        return;
    }

    
    
    
    
    
    
    
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
    
    if ([Road getNextRoad1].position.y - [Road getNextRoad1].size.height/2 >= (self.frame.size.height)) {
        
        
        
        //ゴールカウントの減算
        
        goalCount--;
        
        
        
        //ゴールの際はゴール用の床を出すように変更
        
        if(goalCount == 0){
            
            
            
            //ゴールの床を生成
            
            [Road setGoalRoadframeX:self.frame.size.width frameY:self.frame.size.height];
            
            [self addChild:[Road getGoalRoad]];
            
            
            
        }else{
            
            [Road setNextRoadframeX:self.frame.size.width frameY:self.frame.size.height];
            
            
            
#pragma mark -
            
#pragma mark 障害物の難易度調整
            
            /**
             
             *  障害物の出現量の調整
             
             */
            
            
            
            if(goalCount >= 40){
                
                //なにもしない
                
            }else if(goalCount >=30){
                
                
                
                [self addSabotage];
                
                
                
            }else if (goalCount >= 20){
                
                [self addSabotage];
                
                [self addSabotage];
                
                
                
            }else if (goalCount >= 10){
                
                [self addSabotage];
                
                [self addSabotage];
                
                [self addSabotage];
                
                
                
            }else{
                
                [self addSabotage];
                
                [self addSabotage];
                
                [self addSabotage];
                
                [self addSabotage];
                
                
                
            }
            
#pragma mark -
            
            
            
        }
        
    }
    
    
    
    if ([Sabotage getFirstSavotage].position.y >= (self.frame.size.height)+[Sabotage getFirstSavotage].size.height/2) {
        
        [Sabotage removeSabotage];
        
    }
    
    
    
    if ([Penguin getAccelerate] > 0 && [Penguin getAccelerate] <= 100 ) {
        
        
        if (walkFlag == YES) {
            
            return;
            
        }
        
        
        
        walkFlag = YES;
        
        runFlag = NO;
        
        fastRunFlag = NO;
        
        [Penguin runActionSpeed:1];
        
        
        
    }else if ([Penguin getAccelerate] > 100 && [Penguin getAccelerate] <= 200) {
        
        
        
        if (runFlag == YES) {
            
            return;
            
        }
        
        
        
        runFlag = YES;
        
        walkFlag = NO;
        
        fastRunFlag = NO;
        
        [Penguin runActionSpeed:2];
        
        
        
    }else if ([Penguin getAccelerate] > 200){
        
        
        
        if (fastRunFlag == YES) {
            
            return;
            
        }
        
        
        
        fastRunFlag = YES;
        
        walkFlag = NO;
        
        runFlag = NO;
        
        [Penguin runActionSpeed:3];
        
        
        
    }
    

    
    
}



//障害物のランダム発生

-(void)addSabotage{
    
    //障害物の生成準備
    
    [Sabotage addSabotage:self.frame];
    
    
    
    [self addChild:[Sabotage getLastSabotage]];
    
    
    
}

#pragma mark -
#pragma mark ゴール処理
-(void)goalMethod{

    
    //広告取得開始
//    iconLoader.refreshInterval = 500;
    
    //アスタの表示
    [self.view addSubview:iconCell1];
    [self.view addSubview:iconCell2];
    [self.view addSubview:iconCell3];
    [self.view addSubview:iconCell4];
    [self.view addSubview:iconCell5];
    [self.view addSubview:iconCell6];
    [self.view addSubview:iconCell7];
    [self.view addSubview:iconCell8];
    

    
    [iconLoader startLoadWithMediaCode:@"ast01828j7ybvgg4xdgc"];

    
    
    /**
     *  nend
     */
    //nadViewの生成
    [[NADInterstitial sharedInstance] showAd];
    
    //ハイスコアの登録
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];

    score = score * 100;
    score = (int)score ;
    
    //スコアの比較
    
    if([userDefaults integerForKey:@"score"] == 0){
        [userDefaults setInteger:99999999 forKey:@"score"];

    }
    
    if(score < [userDefaults integerForKey:@"score"]){
        //ハイスコアの場合userDefaultに設定
        [userDefaults setInteger:(int)score forKey:@"score"];
        
        //ハイスコアの場合、新記録と表示する
        SKLabelNode *newRecord = [SKLabelNode labelNodeWithFontNamed:@"Impact"];
        newRecord.text = @"New record!!";
        newRecord.fontSize = 40;
        newRecord.fontColor = [SKColor whiteColor];
        newRecord.position = CGPointMake(0, 0);
        newRecord.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
        newRecord.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
        
        [goalLabel removeAllChildren];
        [goalLabel addChild:newRecord];
        
        
        
        NSArray *tenmetu = @[[SKAction fadeAlphaTo:0.0 duration:1], [SKAction fadeAlphaTo:1.0 duration:0.75]];
        SKAction *action = [SKAction repeatActionForever:[SKAction sequence:tenmetu]];
        [newRecord runAction:action];
        
        //ハイスコアをゲームセンターに送信
        //[self sendScore:score];
        
    }

    

    
    
    //トップボタン作成
    topButton = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(self.frame.size.width/3.5, self.frame.size.height/13)];
    topButton.position = CGPointMake(self.frame.size.width/6*1, self.frame.size.height/10*1.5);
    topButton.name = @"kTopButton";
    topButton.zPosition = 20000;
    [self addChild:topButton];
    
    //ダミーのボタン作成
    dummyTopButton = [SKSpriteNode spriteNodeWithColor:[SKColor clearColor] size:CGSizeMake(self.frame.size.width/3.5, self.frame.size.height/13)];
    dummyTopButton.position = CGPointMake(self.frame.size.width/6*1, self.frame.size.height/10*1.5);
    dummyTopButton.zPosition = 0;
    [self addChild:dummyTopButton];

    
    topButtonLiteral = [SKLabelNode labelNodeWithFontNamed:@"Impact"];
    topButtonLiteral.fontSize = 25;
    topButtonLiteral.fontColor = [SKColor whiteColor];
    topButtonLiteral.position = CGPointMake(0,0);
    topButtonLiteral.text = @"TOP";
    topButtonLiteral.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
    topButtonLiteral.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
    
    [topButton addChild:topButtonLiteral];
    
    
    //リトライボタン作成
    retryButton = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(self.frame.size.width/3.5, self.frame.size.height/13)];
    retryButton.position = CGPointMake(self.frame.size.width/6*5, self.frame.size.height/10*1.5);
    retryButton.name = @"kRetryButton";
    retryButton.zPosition = 20000;
    [self addChild:retryButton];
    
    dummyRetryButton = [SKSpriteNode spriteNodeWithColor:[SKColor clearColor] size:CGSizeMake(self.frame.size.width/3.5, self.frame.size.height/13)];
    dummyRetryButton.position = CGPointMake(self.frame.size.width/6*5, self.frame.size.height/10*1.5);
    dummyRetryButton.zPosition = 0;
    [self addChild:dummyRetryButton];

    
    retryButtonLiteral = [SKLabelNode labelNodeWithFontNamed:@"Impact"];
    retryButtonLiteral.fontSize = 25;
    retryButtonLiteral.fontColor = [SKColor whiteColor];
    retryButtonLiteral.position = CGPointMake(0,0);
    retryButtonLiteral.text = @"RETRY";
    retryButtonLiteral.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
    retryButtonLiteral.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
    
    [retryButton addChild:retryButtonLiteral];



    
}



/**
 *  nend デリゲートメソッド
 */
//広告受信成功後、viewに追加
-(void)nadViewDidFinishLoad:(NADView *)adView{
    [self.view addSubview:adView];
}
//広告非表示
- (void) dismissInterstitialAdSample {
    [[NADInterstitial sharedInstance] dismissAd];
    
}


//スパークパーティクルの作成
-(void)makeSparkParticle:(CGPoint)point{
    if (_particleSpark == nil) {
        NSString *path = [[NSBundle mainBundle]pathForResource:@"Spark" ofType:@"sks"];
        _particleSpark = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        _particleSpark.numParticlesToEmit = 50;
        [self addChild:_particleSpark];
    }else{
        [_particleSpark resetSimulation];
    }
    _particleSpark.position = point;
}




@end


//
//  TitleScene.m
//  CatchFish
//
//  Created by 新井脩司 on 2014/08/20.
//  Copyright (c) 2014年 sacrew. All rights reserved.
//

#import "TitleScene.h"

//各種ボタンのノード
SKSpriteNode *startBt;
SKSpriteNode *tutorialBt;
SKSpriteNode *rankingBt;

//各種ボタンのノード
SKSpriteNode *kstartBt;
SKSpriteNode *ktutorialBt;
SKSpriteNode *krankingBt;

//チュートリアルのノード
SKSpriteNode *tutorial;
SKSpriteNode *tutorialDelete;
SKSpriteNode *tutorialBack;


//ボタンフラグのノード
BOOL startFlag;
BOOL tutorialFlag;
BOOL rankingFlag;
BOOL showTutorialFlag;


@implementation TitleScene{
    
    GKLocalPlayer *localPlayer;
    
}

-(id)initWithSize:(CGSize)size{
    
    if (self == [super initWithSize:size]) {
        
        NSLog(@"%@",NSStringFromCGSize(self.frame.size));
        
        //背景の作成
        SKSpriteNode *titleBack = [SKSpriteNode spriteNodeWithImageNamed:@"titleBack"];
        titleBack.size = CGSizeMake(self.frame.size.width, self.frame.size.height);
        titleBack.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        [self addChild:titleBack];
        
        //スタートボタン作成
        startBt = [SKSpriteNode spriteNodeWithImageNamed:@"starBt"];
        startBt.size = CGSizeMake(startBt.size.width, startBt.size.height);
        startBt.position = CGPointMake(CGRectGetMaxX(self.frame)*3/4, CGRectGetMidY(self.frame)/3);
        [self addChild:startBt];
        
        //チュートリアルボタン作成
        tutorialBt = [SKSpriteNode spriteNodeWithImageNamed:@"tutorialBt"];
        tutorialBt.size = CGSizeMake(tutorialBt.size.width, tutorialBt.size.height);
        tutorialBt.position = CGPointMake(CGRectGetMidX(self.frame)*2/3, CGRectGetMidY(self.frame)/3);
        [self addChild:tutorialBt];

        //ランキングボタン作成
        rankingBt = [SKSpriteNode spriteNodeWithImageNamed:@"rankingBt"];
        rankingBt.size = CGSizeMake(rankingBt.size.width, rankingBt.size.height);
        rankingBt.position = CGPointMake(CGRectGetMidX(self.frame)*1/3, CGRectGetMidY(self.frame)/3);
        [self addChild:rankingBt];
        
        
        
        //仮スタートボタン作成
        kstartBt = [SKSpriteNode spriteNodeWithColor:[SKColor clearColor] size:startBt.size];
        kstartBt.position = CGPointMake(startBt.position.x, startBt.position.y);
        [self addChild:kstartBt];
        
        //仮チュートリアルボタン作成
        ktutorialBt = [SKSpriteNode spriteNodeWithColor:[SKColor clearColor] size:tutorialBt.size];
        ktutorialBt.position = CGPointMake(tutorialBt.position.x,tutorialBt.position.y);
        [self addChild:ktutorialBt];
        
        //仮ランキングボタン作成
        krankingBt = [SKSpriteNode spriteNodeWithColor:[SKColor clearColor] size:rankingBt.size];
        krankingBt.position = CGPointMake(rankingBt.position.x,rankingBt.position.y);
        [self addChild:krankingBt];
        
        
        startFlag = YES;
        tutorialFlag = YES;
        rankingFlag = YES;
        
        //ハイスコア読込
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        float score = [userDefaults integerForKey:@"score"];
        
        int mm = (int)score / 6000;
        int sec = ((int)score - mm * 6000) / 100;
        int mmsec = (int)score % 100;
        
        
        
        //ハイスコア表示
        SKLabelNode *scoreLabelValue;
        scoreLabelValue = [SKLabelNode labelNodeWithFontNamed:@"Impact"];
        scoreLabelValue.text = [NSString stringWithFormat:@"Best Time %02d:%02d:%02d",mm,sec,mmsec];
        scoreLabelValue.fontSize = 30;
        scoreLabelValue.zPosition = 10;
        scoreLabelValue.fontColor = [UIColor orangeColor];
        scoreLabelValue.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame)*3/5);
        scoreLabelValue.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
        scoreLabelValue.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
        [self addChild:scoreLabelValue];
        
        //ハイスコア表示
        SKLabelNode *kscoreLabelValue;
        kscoreLabelValue = [SKLabelNode labelNodeWithFontNamed:@"Impact"];
        kscoreLabelValue.text = [NSString stringWithFormat:@"Best Time %02d:%02d:%02d",mm,sec,mmsec];
        kscoreLabelValue.fontSize = 30;
        kscoreLabelValue.fontColor = [UIColor blackColor];
        //kscoreLabelValue.alpha = 0.5;
        kscoreLabelValue.position = CGPointMake(CGRectGetMidX(self.frame)+2,CGRectGetMidY(self.frame)*3/5-2);
        kscoreLabelValue.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
        kscoreLabelValue.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
        [self addChild:kscoreLabelValue];
        
        
        //GameCenter認証
        [self authenticateLocalPlayer];
        
        
        
    }
    
    //ログ出力の設定
    self.nadView.isOutputLog = YES;

    
    /**
     *  nend
     */
    //nadViewの生成
    self.nadView = [[NADView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.frame) - 50 , 320, 50)];
    
    //setapiKey
    [self.nadView setNendApiKey:@"9cb335fb30407346b92feaf4bdaf930d82cfb6b2"];
    [self.nadView setNendSpotID:@"226540"];
    [self.nadView setDelegate:self];
    [self.nadView load];
    
    return self;

}

#pragma mark-
#pragma mark タッチダウンの処理

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    //タップした座標を取得する
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    
    //スタートボタンをタップした時の命令
    if (startFlag == YES) {
        
        if ([kstartBt containsPoint:location]) {
            
            [startBt runAction:[SKAction moveToY:startBt.position.y-10 duration:0]];
            
            tutorialFlag = NO;
            rankingFlag = NO;
            
            
        }
    }
    
    if (tutorialFlag == YES) {
        //チュートリアルボタンをタップした時の命令
        if ([ktutorialBt containsPoint:location]) {
            
            [tutorialBt runAction:[SKAction moveToY:tutorialBt.position.y-10 duration:0]];
            
            /****************************
             チュートリアル表示中に
             スタートボタン・ランキングボタンが
             タップできないようフラグOFF
             ****************************/
            startFlag = NO;
            rankingFlag = NO;
        }
    }
    
    //ランキングボタンをタップした時の命令
    if (rankingFlag == YES) {
        
        if ([krankingBt containsPoint:location]) {
            
            [rankingBt runAction:[SKAction moveToY:rankingBt.position.y - 10 duration:0]];
            
            startFlag = NO;
            tutorialFlag = NO;
            
        }
    }
    
    
    //チュートリアルが表示されている時の命令
    if (showTutorialFlag == YES) {
        
        //ポジション取得ノードを画面からチュートリアルノードに変更
        CGPoint location = [touch locationInNode:tutorial];
        
        //チュートリアル削除ボタンをタップした時の命令
        if ([tutorialDelete containsPoint:location]) {
            
            [tutorial runAction:[SKAction moveToY:CGRectGetMidY(self.frame) - 10 duration:0]];
            
        }
        
        return;
    }
}

#pragma mark-
#pragma mark タッチムーブ

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];

    if (startFlag == YES) {
        if ([kstartBt containsPoint:location]) {
                //何もしません
        }else{
            [startBt runAction:[SKAction moveToY:kstartBt.position.y duration:0]];
            rankingFlag = YES;
            tutorialFlag = YES;
        }
        return;
    }
    
    if (tutorialFlag == YES) {
        if ([ktutorialBt containsPoint:location]) {
            
            
        }else{
            [tutorialBt runAction:[SKAction moveToY:ktutorialBt.position.y duration:0]];
            rankingFlag = YES;
            startFlag = YES;
            
        }
        return;
    }
    
    
    if (rankingFlag == YES) {
        if ([krankingBt containsPoint:location]) {
            //何もしません
        }else{
            [rankingBt runAction:[SKAction moveToY:krankingBt.position.y duration:0]];
            startFlag = YES;
            rankingFlag = YES;
        }
        return;
    }
}



#pragma mark-
#pragma mark タッチエンドの処理

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    //タッチアップした座標を取得する
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];

    //スタートボタンをタップアップした時の命令
    
    if (startFlag == YES) {
    
        if ([kstartBt containsPoint:location]) {
        
            if ([_delegate respondsToSelector:@selector(sceneEscape:identifier:)]) {
                
                [self.nadView setDelegate:nil];
                [self.nadView removeFromSuperview];
                self.nadView = nil;
            
                [startBt runAction:[SKAction moveToY:kstartBt.position.y duration:0]];
                [_delegate sceneEscape:self identifier:nil];
            
                //画面遷移を遅延実行する
               // [self performSelector:@selector(delayStartMethod) withObject:nil afterDelay:0.1];

            }
    
        }else{
        
            [startBt runAction:[SKAction moveToY:kstartBt.position.y duration:0]];
            
            tutorialFlag = YES;
            rankingFlag = YES;
        
        }
        
        return;
    }



    
    //チュートリアルボタンをタッチアップした時の命令
    if (tutorialFlag == YES) {
        
        if ([ktutorialBt containsPoint:location]) {
            
            showTutorialFlag = YES;
            
            [tutorialBt runAction:[SKAction moveToY:ktutorialBt.position.y duration:0]];
            
            [self showTutorial];
            
            //画面遷移を遅延実行する
            //[self performSelector:@selector(delayTutorialMethod) withObject:nil afterDelay:0.1];
            
            startFlag = NO;
            rankingFlag = NO;
            
            
            
            
        }else{
            
            [tutorialBt runAction:[SKAction moveToY:ktutorialBt.position.y duration:0]];
            
            startFlag = YES;
            
            
        }
        
        return;
    
    }
    

    
    //ランキングボタンをタッチアップした時の命令
    if (rankingFlag == YES) {
        
        if ([krankingBt containsPoint:location]) {
            
            [rankingBt runAction:[SKAction moveToY:krankingBt.position.y duration:0]];
            
            [self showGameCenter];

            
            //画面遷移を遅延実行する
            //[self performSelector:@selector(delayRankingMethod) withObject:nil afterDelay:0.1];
            
            startFlag = YES;
            tutorialFlag = YES;
            
        }else{
            
            [rankingBt runAction:[SKAction moveToY:krankingBt.position.y duration:0]];
            
            startFlag = YES;
            tutorialFlag = YES;
            
        }
        
        return;
    
    }
    
    
    
    if (showTutorialFlag == YES) {
        
        //チュートリアル削除ボタンをタッチアップした時の命令
        if (tutorial.position.y <= CGRectGetMidY(self.frame) - 10) {
            
            [tutorial runAction:[SKAction moveToY:CGRectGetMidY(self.frame)+10 duration:0]];
            
            //画面遷移を遅延実行する
            //[self performSelector:@selector(deleteTutorialMethod) withObject:nil afterDelay:0.1];
            
            //チュートリアル削除
            [tutorial removeFromParent];
            [tutorialBack removeFromParent];
            showTutorialFlag = NO;
            startFlag = YES;
            tutorialFlag = YES;
            rankingFlag = YES;
            
        }
        
        return;
    }
    
    
}


/*****************************
 *  遊び方の表示メソッド
 *****************************/
-(void)showTutorial{
    
    if (showTutorialFlag == YES) {
        
        tutorialFlag = NO;
        startFlag = NO;
        rankingFlag = NO;
        
        //遊び方説明ノードの設定
        tutorial =[SKSpriteNode spriteNodeWithImageNamed:@"tutorial"];
        tutorial.size = CGSizeMake(self.frame.size.width*3/4, self.frame.size.height*3/4);
        tutorial.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        tutorial.zPosition = 1000;
        [self addChild:tutorial];
        
        //遊び方説明の削除ボタンの設定
        tutorialDelete = [SKSpriteNode spriteNodeWithImageNamed:@"tutorialDelete"];
        tutorialDelete.size = CGSizeMake(tutorial.size.width/6, tutorial.size.height/10);
        tutorialDelete.position = CGPointMake(10,-(tutorial.size.height/2)+tutorialDelete.size.height*2/3);
        [tutorial addChild:tutorialDelete];
        
        //遊び方説明時に背景を暗くする
        tutorialBack = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(self.frame.size.width, self.frame.size.height)];
        tutorialBack.alpha = 0.5;
        tutorialBack.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        [self addChild:tutorialBack];

    }
    
}











#pragma mark-
#pragma mark ゲームセンター認証設定
/**********************************************************************************************
 *********************************   ゲームセンター認証設定   *************************************
 **********************************************************************************************/


//GameCenter認証
-(void)authenticateLocalPlayer{
    __weak typeof (self) weakSelf = self;
    
    localPlayer = [GKLocalPlayer localPlayer];
    __weak GKLocalPlayer *weakPlayer = localPlayer;
    
    weakPlayer.authenticateHandler = ^(UIViewController *viewController, NSError *error)
    {
        if (viewController != nil) // LOGIN
        {
            [weakSelf showAuthenticationDialogWhenReasonable:viewController];
        }
        else if (weakPlayer.isAuthenticated) // LOGIN済
        {
            [weakSelf authenticatedPlayer:weakPlayer];
        }
        else
        {
            [weakSelf disableGameCenter];
        }
    };
    
}

// GameCenter認証画面
-(void)showAuthenticationDialogWhenReasonable:(UIViewController *)controller
{
    [[[[[UIApplication sharedApplication] delegate] window] rootViewController] presentViewController:controller animated:YES completion:nil];
    NSLog(@"成功");

}

// GameCenter認証OK
-(void)authenticatedPlayer:(GKLocalPlayer *)player
{
    player = localPlayer;
    NSLog(@"成功");

}

// GameCenter認証NG
-(void)disableGameCenter
{
    NSLog(@"失敗");
}

// Leader Boardの表示
-(void)showGameCenter{
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    float score = [userDefaults integerForKey:@"score"];
    
    
    NSLog(@"%lld",(int64_t)score);
    
    //スコアが0じゃない場合に限り送信
    if(score != 0){
        if ([GKLocalPlayer localPlayer].isAuthenticated) {
            GKScore* sendScore = [[GKScore alloc] initWithLeaderboardIdentifier:@"testPenguinRace"];
            sendScore.value = (int64_t)score;
            [GKScore reportScores:@[sendScore] withCompletionHandler:^(NSError *error) {
                if (error) {
                    // エラーの場合
                    /**
                     *  何もせず終了
                     */
                    
                    NSLog(@"エラーでした、、、");
                    
                }
            }];
        }
    }
    
    GKGameCenterViewController* gameCenterController = [[GKGameCenterViewController alloc] init];
    if (gameCenterController != nil)
    {
        gameCenterController.gameCenterDelegate = self;
        gameCenterController.viewState = GKGameCenterViewControllerStateLeaderboards;
        
        UIViewController *vc = self.view.window.rootViewController;
        [vc presentViewController: gameCenterController animated: YES completion:nil];
    }
    
}

// Leader Boardが閉じたとき呼ばれる
- (void)gameCenterViewControllerDidFinish:(GKGameCenterViewController *)gameCenterViewController {
    [[[[[UIApplication sharedApplication] delegate] window] rootViewController] dismissViewControllerAnimated:YES completion:nil];
}

//広告受信成功後、viewに追加
-(void)nadViewDidFinishLoad:(NADView *)adView{
    //デバッグ用、後で消す
    [self.view addSubview:adView];
}

//広告受信失敗(あとで消す)
-(void)nadViewDidFailToReceiveAd:(NADView *)adView{
}

#pragma mark-

@end

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

//チュートリアルのノード
SKSpriteNode *tutorial;
SKSpriteNode *tutorialDelete;
SKSpriteNode *tutorialBack;

//ボタンフラグのノード
BOOL startFlag;
BOOL tutorialFlag;
BOOL rankingFlag;

@implementation TitleScene{
    
    GKLocalPlayer *localPlayer;
}

-(id)initWithSize:(CGSize)size{
    
    if (self == [super initWithSize:size]) {
        
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
    

        //ボタンのフラグの設定(タップ可能に)
        startFlag = YES;
        tutorialFlag = YES;
        rankingFlag = YES;
        
        
    }
    
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
    if ([startBt containsPoint:location] && startFlag == YES) {
        
        [startBt runAction:[SKAction moveToY:startBt.position.y-10 duration:0]];
    
    }
    
    //チュートリアルボタンをタップした時の命令
    if ([tutorialBt containsPoint:location] && tutorialFlag == YES) {
        
        [tutorialBt runAction:[SKAction moveToY:tutorialBt.position.y-10 duration:0]];
        
        /****************************
         チュートリアル表示中に
         スタートボタン・ランキングボタンが
         タップできないようフラグOFF
         ****************************/
        startFlag = NO;
        rankingFlag = NO;
    
    }
    
    //ランキングボタンをタップした時の命令
    if ([rankingBt containsPoint:location] && rankingFlag == YES) {
        
        [rankingBt runAction:[SKAction moveToY:rankingBt.position.y - 10 duration:0]];
    }
    
    //チュートリアルが表示されている時の命令
    if (tutorial) {
        
        //ポジション取得ノードを画面からチュートリアルノードに変更
        CGPoint location = [touch locationInNode:tutorial];
        
        //チュートリアル削除ボタンをタップした時の命令
        if ([tutorialDelete containsPoint:location]) {
            
            [tutorial runAction:[SKAction moveToY:CGRectGetMidY(self.frame) - 10 duration:0]];
            

        }
    }
    
}

#pragma mark-
#pragma mark タッチエンドの処理

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{

    //スタートボタンをタップアップした時の命令
    if (startBt.position.y <= CGRectGetMidY(self.frame)/3 - 10) {
        if ([_delegate respondsToSelector:@selector(sceneEscape:identifier:)]) {
            
            [startBt runAction:[SKAction moveToY:CGRectGetMidY(self.frame)/3 duration:0]];
            //[_delegate sceneEscape:self identifier:nil];
            
            //画面遷移を遅延実行する
            [self performSelector:@selector(delayStartMethod) withObject:nil afterDelay:0.1];
        
        }
    }
    
    //チュートリアルボタンをタッチアップした時の命令
    if (tutorialBt.position.y <= CGRectGetMidY(self.frame)/3 - 10) {

        [tutorialBt runAction:[SKAction moveToY:CGRectGetMidY(self.frame)/3 duration:0]];
        
        //画面遷移を遅延実行する
        [self performSelector:@selector(delayTutorialMethod) withObject:nil afterDelay:0.1];
    
    }
    
    //ランキングボタンをタッチアップした時の命令
    if (rankingBt.position.y <= CGRectGetMidY(self.frame)/3 - 10) {
        
        [rankingBt runAction:[SKAction moveToY:CGRectGetMidY(self.frame)/3 duration:0]];
        
        //画面遷移を遅延実行する
        [self performSelector:@selector(delayRankingMethod) withObject:nil afterDelay:0.1];
    
    }
    
    //チュートリアル削除ボタンをタッチアップした時の命令
    if (tutorial.position.y <= CGRectGetMidY(self.frame) - 10) {
        
        [tutorial runAction:[SKAction moveToY:CGRectGetMidY(self.frame)+10 duration:0]];
        
        //画面遷移を遅延実行する
        [self performSelector:@selector(deleteTutorialMethod) withObject:nil afterDelay:0.1];

    }
    
    
}

/****************************************************
 *  画面遷移の遅延実行メソッド
 ****************************************************/

//ゲーム画面へ遷移の遅行
- (void)delayStartMethod{
    
    //ゲーム画面に遷移
    [_delegate sceneEscape:self identifier:nil];

}

//チュートリアルへ遷移の遅行
-(void)delayTutorialMethod{
    
    //チュートリアルに遷移
    [self showTutorial];
    
}

//ゲームセンターアクセスへ遷移の遅行
- (void)delayRankingMethod{
    
    //ゲームセンターに遷移
    [self showGameCenter];
    
}

//チュートリアル消去の遅行
-(void)deleteTutorialMethod{
    
    //チュートリアル削除
    [tutorial removeFromParent];
    [tutorialBack removeFromParent];
    
    //ボタンフラグを元に戻す
    startFlag = YES;
    tutorialFlag = YES;
    rankingFlag = YES;
}



/*****************************
 *  遊び方の表示メソッド
 *****************************/
-(void)showTutorial{
    
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
}

// GameCenter認証OK
-(void)authenticatedPlayer:(GKLocalPlayer *)player
{
    player = localPlayer;
}

// GameCenter認証NG
-(void)disableGameCenter
{
    
}

// Leader Boardの表示
-(void)showGameCenter{
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    float score = [userDefaults floatForKey:@"score"];
    
    if ([GKLocalPlayer localPlayer].isAuthenticated) {
        GKScore* sendScore = [[GKScore alloc] initWithLeaderboardIdentifier:@"FirstPenguin"];
        sendScore.value = score * 10;
        [GKScore reportScores:@[sendScore] withCompletionHandler:^(NSError *error) {
            if (error) {
                // エラーの場合
                /**
                 *  何もせず終了
                 */
            }
        }];
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

#pragma mark-

@end

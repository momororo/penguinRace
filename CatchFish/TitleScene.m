//
//  TitleScene.m
//  CatchFish
//
//  Created by 新井脩司 on 2014/08/20.
//  Copyright (c) 2014年 sacrew. All rights reserved.
//

#import "TitleScene.h"

SKSpriteNode *startBt;
SKSpriteNode *tutorialBt;
SKSpriteNode *rankingBt;

float score;

@implementation TitleScene{
    
    GKLocalPlayer *localPlayer;
}

-(id)initWithSize:(CGSize)size{
    
    if (self == [super initWithSize:size]) {
        
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
    if ([startBt containsPoint:location]) {
        [startBt runAction:[SKAction moveToY:startBt.position.y-10 duration:0]];
    }
    
    //チュートリアルボタンをタップした時の命令
    if ([tutorialBt containsPoint:location]) {
        [tutorialBt runAction:[SKAction moveToY:tutorialBt.position.y-10 duration:0]];
    }
    
    //ランキングボタンをタップした時の命令
    if ([rankingBt containsPoint:location]) {
        [rankingBt runAction:[SKAction moveToY:rankingBt.position.y-10 duration:0]];
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
            [self performSelector:@selector(delayStartMethod) withObject:nil afterDelay:0.3];
        }
    }
    
    //チュートリアルボタンをタップアップした時の命令
    if (tutorialBt.position.y <= CGRectGetMidY(self.frame)/3 - 10) {

        [tutorialBt runAction:[SKAction moveToY:CGRectGetMidY(self.frame)/3 duration:0]];
        
        
    }
    
    //ランキングボタンをタップアップした時の命令
    if (rankingBt.position.y <= CGRectGetMidY(self.frame)/3 - 10) {
        
        [rankingBt runAction:[SKAction moveToY:CGRectGetMidY(self.frame)/3 duration:0]];
        
        //画面遷移を遅延実行する
        [self performSelector:@selector(delayRankingMethod) withObject:nil afterDelay:0.3];

    
    }
}

- (void)delayStartMethod{
    [_delegate sceneEscape:self identifier:nil];
}

- (void)delayRankingMethod{
    
    [self showGameCenter];

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

//
//  GameView.m
//  CatchFish
//
//  Created by 新井脩司 on 2014/08/20.
//  Copyright (c) 2014年 sacrew. All rights reserved.
//

#import "GameView.h"

#import "GameView.h"
#import "SceneManager.h"

@implementation GameView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpGameView];
    }
    return self;
}


-(void)awakeFromNib{
    [self setUpGameView];
}


-(void)setUpGameView{
    self.showsFPS = NO;
    self.showsNodeCount = NO;
    [self switchingTitleScene];
}

//タイトル
-(void)switchingTitleScene{
    TitleScene *scene = [SceneManager titleScene:self.bounds.size];
    scene.delegate = self;
    scene.scaleMode = SKSceneScaleModeAspectFill;
    [SceneManager sceneCange:self New:scene Duration:0.5];
}

//ゲーム
-(void)switchingGameScene{
    GameScene *scene = [SceneManager gameScene:self.bounds.size];
    scene.delegate = self;
    scene.scaleMode = SKSceneScaleModeAspectFill;
    [SceneManager sceneCange:self New:scene Duration:0.5];
}



#pragma mark - sceneEscapeProtocol

//デリゲートメソッド
-(void)sceneEscape:(SKScene *)scene identifier:(NSString *)identifier{
    if ([scene isKindOfClass:[TitleScene class]]) {
        
        
        [self switchingGameScene];
        
    }else if ([scene isKindOfClass:[GameScene class]]){
        if([identifier isEqualToString:@"retry"]){
            [self switchingGameScene];
        }
        if([identifier isEqualToString:@"top"]){
            [self switchingTitleScene];
        }
        
    }
}

@end

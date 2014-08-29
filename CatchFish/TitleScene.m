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

@implementation TitleScene

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



-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{

    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    
    //スタートボタンをタップアップした時の命令
    if ([startBt containsPoint:location]) {
        if ([_delegate respondsToSelector:@selector(sceneEscape:identifier:)]) {
            [startBt runAction:[SKAction moveToY:startBt.position.y+10 duration:0]];
            [_delegate sceneEscape:self identifier:nil];
        }
    }
    
    //チュートリアルボタンをタップアップした時の命令
    if ([tutorialBt containsPoint:location]) {
        if ([_delegate respondsToSelector:@selector(sceneEscape:identifier:)]) {
            [tutorialBt runAction:[SKAction moveToY:tutorialBt.position.y+10 duration:0]];
        }
    }
    
    //ランキングボタンをタップアップした時の命令
    if ([rankingBt containsPoint:location]) {
        if ([_delegate respondsToSelector:@selector(sceneEscape:identifier:)]) {
            [rankingBt runAction:[SKAction moveToY:rankingBt.position.y+10 duration:0]];
        }
    }


}
@end

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
        
        //スタートラベル作成
        startBt = [SKSpriteNode spriteNodeWithImageNamed:@"starBt"];
        startBt.size = CGSizeMake(startBt.size.width, startBt.size.height);
        startBt.position = CGPointMake(CGRectGetMaxX(self.frame)*3/4, CGRectGetMidY(self.frame)/3);
        [self addChild:startBt];
        
        //チュートリアル作成
        startBt = [SKSpriteNode spriteNodeWithImageNamed:@"starBt"];
        startBt.size = CGSizeMake(startBt.size.width, startBt.size.height);
        startBt.position = CGPointMake(CGRectGetMaxX(self.frame)*3/4, CGRectGetMidY(self.frame)/3);
        [self addChild:startBt];

        //ランキングラベル作成
        startBt = [SKSpriteNode spriteNodeWithImageNamed:@"starBt"];
        startBt.size = CGSizeMake(startBt.size.width, startBt.size.height);
        startBt.position = CGPointMake(CGRectGetMaxX(self.frame)*3/4, CGRectGetMidY(self.frame)/3);
        [self addChild:startBt];

        
        
        
        
        
        
        
        
        
        
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    //タップした座標を取得する
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    
    //スタートノードをタップした時の命令
    if ([startBt containsPoint:location]) {
        [startBt runAction:[SKAction moveToY:startBt.position.y-10 duration:0.1]];

    }
    
    
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{

    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    
    //スタートノードをタップした時の命令
    if ([startBt containsPoint:location]) {
        if ([_delegate respondsToSelector:@selector(sceneEscape:identifier:)]) {
            [_delegate sceneEscape:self identifier:nil];
        }
    }

}
@end

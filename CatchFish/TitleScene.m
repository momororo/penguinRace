//
//  TitleScene.m
//  CatchFish
//
//  Created by 新井脩司 on 2014/08/20.
//  Copyright (c) 2014年 sacrew. All rights reserved.
//

#import "TitleScene.h"

SKLabelNode *start;

@implementation TitleScene

-(id)initWithSize:(CGSize)size{
    
    if (self == [super initWithSize:size]) {
        
        SKSpriteNode *top = [SKSpriteNode spriteNodeWithColor:[SKColor whiteColor] size:CGSizeMake(self.frame.size.width, self.frame.size.height)];
        top.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        [self addChild:top];
        
        //MARK:テスト用のスタートラベル、後々消去
        start = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        start.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        start.fontColor = [SKColor blackColor];
        start.text = @"Game Start";
        start.fontSize = 18;
        
        [self addChild:start];
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    //タップした座標を取得する
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    
    //スタートノードをタップした時の命令
    if ([start containsPoint:location]) {
        if ([_delegate respondsToSelector:@selector(sceneEscape:identifier:)]) {
                [_delegate sceneEscape:self identifier:nil];
        }
    }
}
@end

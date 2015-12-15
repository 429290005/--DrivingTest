//
//  CYQuestionCell.m
//  驾考刷题
//
//  Created by 程俊亚 on 15/12/14.
//  Copyright © 2015年 john. All rights reserved.
//

#import "CYQuestionCell.h"
#import "CYQuestionFrame.h"
#import "UIImageView+WebCache.h"
#import "CYQuestionModel.h"
@interface CYQuestionCell()

/** 滚动背景 */
@property(nonatomic, strong)UIScrollView *scrollView;
/** 题干 */
@property(nonatomic, strong)UILabel *titleLabel;
/** 图片 */
@property(nonatomic, strong)UIImageView *questionImage;
/** 选项 */
@property(nonatomic, strong)CYAnswerView *answerView;
@end

@implementation CYQuestionCell;
/**
 *  cell的初始化方法，一个cell会调用一次
 *  一般在这里添加所有可能显示的子控件，以及子控件的一次性设置
 */
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        /** 滚动背景 */
        UIScrollView *scrollView = [[UIScrollView alloc]init];
//        scrollView.frame = [UIScreen mainScreen].bounds;
        scrollView.scrollEnabled = YES;

        [self.contentView addSubview:scrollView];
        self.scrollView = scrollView;
        /** 题干 */
        UILabel *titleLabel = [[UILabel alloc]init];
//        titleLabel.backgroundColor = [UIColor redColor];
        titleLabel.numberOfLines = 0;
        titleLabel.font = [UIFont systemFontOfSize:15];
        [scrollView addSubview:titleLabel];
        self.titleLabel = titleLabel;
        /** 图片 */
        UIImageView *questionImage = [[UIImageView alloc]init];
//        questionImage.backgroundColor = [UIColor grayColor];
        [scrollView addSubview:questionImage];
        self.questionImage = questionImage;
        /** 选项 */
        CYAnswerView *answerView = [[CYAnswerView alloc]init];
//        answerView.backgroundColor = [UIColor greenColor];
        [scrollView addSubview:answerView];
        self.answerView = answerView;
    }
    return self;
}

-(void)setQuestionFrame:(CYQuestionFrame *)questionFrame
{
    _questionFrame = questionFrame;
    CYQuestionModel *questionMode = questionFrame.questionMode;
    /** 滚动背景 */
    self.scrollView.frame = questionFrame.scrollViewF;

    /** 题干 */
    self.titleLabel.frame = questionFrame.titleLabelF;
    self.titleLabel.text = questionMode.question;

    /** 图片 */
    self.questionImage.frame = questionFrame.questionImageF;
    [self.questionImage sd_setImageWithURL:[NSURL URLWithString:questionMode.url] placeholderImage:nil];
    /** 选项 */
    self.answerView.frame = questionFrame.answerViewF;
    self.answerView.labelA.text = questionMode.item1;
    self.answerView.labelB.text = questionMode.item2;

    if (questionMode.item3  == nil|| [questionMode.item3 isEqualToString:@""]) {
        self.answerView.optionC.hidden = YES;
        self.answerView.lineCD.hidden = YES;
        self.answerView.lineDX.hidden = YES;
    } else {
        self.answerView.optionC.hidden = NO;
        self.answerView.lineCD.hidden = NO;
        self.answerView.lineDX.hidden = NO;
        self.answerView.labelC.text = questionMode.item3;

    }

    if (questionMode.item4 == nil || [questionMode.item4 isEqualToString:@""]) {
        self.answerView.optionD.hidden = YES;
        self.answerView.lineCD.hidden = YES;
        self.answerView.lineDX.hidden = YES;
    } else {
        self.answerView.optionD.hidden = NO;
        self.answerView.lineCD.hidden = NO;
        self.answerView.lineDX.hidden = NO;
        self.answerView.labelD.text = questionMode.item4;
    }



}

@end

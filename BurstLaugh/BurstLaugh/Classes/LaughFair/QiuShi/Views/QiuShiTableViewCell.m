//
//  QiuShiTableViewCell.m
//  BurstLaugh
//
//  Created by scjy on 16/3/6.
//  Copyright © 2016年 王雪娟. All rights reserved.
//

#import "QiuShiTableViewCell.h"
#import "HWTools.h"
#import <SDWebImage/UIImageView+WebCache.h>
@implementation QiuShiTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configView];
    }
    return self;
}

- (void)configView {
    //头像
    self.iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(5, 10, kWidth / 6 - 20, kWidth / 6 - 20)];
    self.iconImage.layer.cornerRadius = (kWidth / 6 - 20 ) * 0.5;
//    self.iconImage.backgroundColor = [UIColor redColor];
    self.iconImage.clipsToBounds = YES;
    [self.contentView addSubview:self.iconImage];
    //名称
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(kWidth / 6 + 10, 10, kWidth - kWidth / 6 - 15, kWidth / 6 - 20)];
    [self.contentView addSubview:self.nameLabel];
    //内容
    self.contextLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, kWidth / 6 - 15 , kWidth - 20, 50)];
    [self.contentView addSubview:self.contextLabel];
    self.contextLabel.numberOfLines = 0;
    //四个按钮
    self.upBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.upBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    self.upBtn.alpha = 0.5;
    self.upBtn.frame = CGRectMake(5, kWidth / 6 + 70, kWidth / 4 - 5, 30);
    [self.upBtn setImage:[UIImage imageNamed:@"zan@2x.icon"] forState:UIControlStateNormal];
    [self.contentView addSubview:self.upBtn];
    
    self.downBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.downBtn setImage:[UIImage imageNamed:@"cai@2x.icon"] forState:UIControlStateNormal];
    [self.downBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    self.downBtn.alpha = 0.5;
    self.downBtn.frame = CGRectMake(kWidth / 4 + 5, kWidth / 6 + 70, kWidth / 4 - 5, 30);
    [self.contentView addSubview:self.downBtn];
    
    self.countBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.countBtn.frame = CGRectMake(kWidth / 2 + 5, kWidth / 6 + 70, kWidth / 4 - 5, 30);
    [self.countBtn setImage:[UIImage imageNamed:@"comment@2x.icon"] forState:UIControlStateNormal];
    [self.countBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    self.countBtn.alpha = 0.5;
    [self.contentView addSubview:self.countBtn];
    
    self.sharBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sharBtn.frame = CGRectMake(kWidth * 0.75 + 5, kWidth / 6 + 70, kWidth / 4 - 10, 30);
    [self.sharBtn setImage:[UIImage imageNamed:@"shar@2x.icon"] forState:UIControlStateNormal];
    [self.sharBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    self.sharBtn.alpha = 0.5;
    [self.contentView addSubview:self.sharBtn];
    //创建分割线
    self.lineLabel = [[UILabel alloc] init];
    self.lineLabel.backgroundColor = [UIColor grayColor];
    self.lineLabel.alpha = 0.3;
    [self.contentView addSubview:self.lineLabel];
    
}

-(void)setQiushiModel:(qiushiModel *)qiushiModel {
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:qiushiModel.iconImage] placeholderImage:nil];
    self.nameLabel.text = qiushiModel.login;
    //重写给label赋值
    CGFloat height = [HWTools getTextHeightWithText:qiushiModel.content];
    CGRect frame = self.contextLabel.frame;
    frame.size.height = height;
    self.contextLabel.frame = frame;
    self.contextLabel.numberOfLines = 0;
    self.contextLabel.text = [NSString stringWithFormat:@"%@",qiushiModel.content];
    //重新给按钮赋值
    self.upBtn.frame = CGRectMake(5,frame.size.height + kWidth / 6 - 20, kWidth / 4 - 5, 30);
    self.downBtn.frame = CGRectMake(kWidth / 4 + 5, frame.size.height + kWidth / 6 - 20, kWidth / 4 - 5, 30);
    self.countBtn.frame = CGRectMake(kWidth / 2 + 5, frame.size.height + kWidth / 6 - 20, kWidth / 4 - 5, 30);
    self.sharBtn.frame = CGRectMake(kWidth * 0.75 + 5, frame.size.height + kWidth / 6 - 20, kWidth / 4 - 10, 30);
    [self.downBtn setTitle:[NSString stringWithFormat:@"%@",qiushiModel.down] forState:UIControlStateNormal];
    [self.upBtn setTitle:[NSString stringWithFormat:@"%@",qiushiModel.up] forState:UIControlStateNormal];
    [self.countBtn setTitle:[NSString stringWithFormat:@"%@",qiushiModel.comments_count] forState:UIControlStateNormal];
    [self.sharBtn setTitle:[NSString stringWithFormat:@"%@",qiushiModel.share_count] forState:UIControlStateNormal];
    self.lineLabel.frame = CGRectMake(0, frame.size.height + kWidth / 6 - 20 + 40, kWidth, 5);
   
}

+ (CGFloat)getCellHeightModel:(qiushiModel *)model{
    CGFloat textHeight = [HWTools getTextHeightWithText:model.content];
    return textHeight + 30;

}

/*
//段子界面赋值
-(void)setJokerModel:(jokerModel *)jokerModel {
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:jokerModel.avatar] placeholderImage:nil];
    self.nameLabel.text = jokerModel.text;
    self.textLabel.text = jokerModel.text;
    [self.upBtn setTitle:[NSString stringWithFormat:@"%@",jokerModel.like] forState:UIControlStateNormal];
    [self.downBtn setTitle:[NSString stringWithFormat:@"%@",jokerModel.unlike] forState:UIControlStateNormal];
    [self.countBtn setTitle:[NSString stringWithFormat:@"%@",jokerModel.comment] forState:UIControlStateNormal];
    [self.sharBtn setTitle:[NSString stringWithFormat:@"%@",jokerModel.shared] forState:UIControlStateNormal];

}

+ (CGFloat)getCellHeightJokerModel:(jokerModel *)model{
    CGFloat textHeight = [HWTools getTextHeightWithText:model.text];
    return textHeight + 30;
}
*/
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
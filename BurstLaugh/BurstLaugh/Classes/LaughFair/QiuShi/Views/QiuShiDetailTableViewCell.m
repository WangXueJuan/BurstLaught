//
//  QiuShiDetailTableViewCell.m
//  BurstLaugh
//
//  Created by scjy on 16/3/7.
//  Copyright © 2016年 王雪娟. All rights reserved.
//

#import "QiuShiDetailTableViewCell.h"
#import "HWTools.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface QiuShiDetailTableViewCell ()
@property (nonatomic, strong) UILabel *iconLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIImageView *iconImage;
@property (nonatomic, strong) UILabel *lineLabel;
@end

@implementation QiuShiDetailTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configView];
    }
    return self;

}


- (void)configView {
    //头像
    self.iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 30, 30)];
    self.iconImage.layer.cornerRadius = 30 / 2;
    self.iconImage.clipsToBounds = YES;
    [self.contentView addSubview:self.iconImage];
    //用户名
    self.iconLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, 5, kWidth - 50, 30)];
    [self.contentView addSubview:self.iconLabel];
    //内容
    self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 40, kWidth - 10, 60)];
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.iconLabel];
    //创建分割线
    self.lineLabel = [[UILabel alloc] init];
    self.lineLabel.backgroundColor = [UIColor grayColor];
    self.lineLabel.alpha = 0.3;
    [self.contentView addSubview:self.lineLabel];
}

-(void)setDetailModell:(QiuShiDetailModell *)detailModell {
    self.iconLabel.text = detailModell.login;
    //重写赋值大小
    CGFloat height = [HWTools getTextHeightWithText:detailModell.content];
    CGRect frame = self.contentLabel.frame;
    frame.size.height = height;
    self.contentLabel.frame = frame;
    self.contentLabel.numberOfLines = 0;
    //赋值头像
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:detailModell.iconImage] placeholderImage:nil];
    if (detailModell.iconImage == nil) {
        self.iconImage.image = [UIImage imageNamed:@"zan@2x"];
    }
    self.contentLabel.text = detailModell.content;
    self.lineLabel.frame = CGRectMake(0, frame.size.height + 46, kWidth, 2);
}

+ (CGFloat)getCellHeightDetailModel:(QiuShiDetailModell *)model {
    
    CGFloat cellHeight = [HWTools getTextHeightWithText:model.content];
    return cellHeight + 60;

}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

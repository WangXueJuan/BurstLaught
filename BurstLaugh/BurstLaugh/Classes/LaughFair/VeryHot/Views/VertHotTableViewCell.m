//
//  VertHotTableViewCell.m
//  BurstLaugh
//
//  Created by scjy on 16/3/4.
//  Copyright © 2016年 王雪娟. All rights reserved.
//

#import "VertHotTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>


@interface VertHotTableViewCell ()
@property(nonatomic, retain) UIImageView *imageIcon;
@property(nonatomic, retain) UIImageView *imagePctiu;
@property(nonatomic, retain) UILabel *nameLabel;
@property(nonatomic, retain) UILabel *txtLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@end

@implementation VertHotTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configView];
    }
    return self;
}

- (void)configView{
    //创建相关控件
    //图标
    self.imageIcon = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5,kWidth / 6, kWidth / 6)];
    self.imageIcon.layer.cornerRadius = kWidth / 6 / 2.0;
    self.imageIcon.clipsToBounds = YES;
    
    [self.contentView addSubview:self.imageIcon];
    //name
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(kWidth / 6 + 20, 5, kWidth / 2 - 20, 30)];
    self.nameLabel.font = [UIFont boldSystemFontOfSize:16.0];
    [self.contentView addSubview:self.nameLabel];
    //time
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(kWidth / 1.60, 5, kWidth - kWidth / 1.8, 30)];
    self.timeLabel.font = [UIFont systemFontOfSize:13.0];
    self.timeLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:self.timeLabel];
    //text
    self.txtLabel = [[UILabel alloc] initWithFrame:CGRectMake(kWidth / 6 + 20, 35, kWidth * 0.65, 60)];
    self.txtLabel.numberOfLines = 0;
    [self.contentView addSubview:self.txtLabel];
    //picture
    self.imagePctiu = [[UIImageView alloc] initWithFrame:CGRectMake(kWidth / 5, 80,kWidth - (kWidth / 3), kWidth / 2.5)];
    [self.contentView addSubview:self.imagePctiu];
    
    
}

//重写model的set方法
- (void)setVerModel:(verHotModel *)verModel {
    //获取图片
    [self.imagePctiu sd_setImageWithURL:[NSURL URLWithString:verModel.textImage] placeholderImage:nil];
    [self.imageIcon sd_setImageWithURL:[NSURL URLWithString:verModel.icon] placeholderImage:nil];
    //重新给cellLabel赋值
    CGFloat height = [[self class] getTextHeightWithText:verModel.text];
    CGRect frame = self.txtLabel.frame;
    frame.size.height = height;
    self.txtLabel.frame = frame;
    self.txtLabel.text = [NSString stringWithFormat:@"%@",verModel.text];
     self.txtLabel.numberOfLines = 0;
    
    self.nameLabel.text = [NSString stringWithFormat:@"%@",verModel.name];
    self.timeLabel.text = [NSString stringWithFormat:@"%@",verModel.passtime];
    //重新给图片的frame赋值
    self.imagePctiu.frame = CGRectMake(10, frame.size.height + (kWidth / 6) - 10, kWidth - 20, verModel.height / 3);


}

#pragma mark ------------------ 自定义高度
+ (CGFloat)getTextHeightWithText:(NSString *)txtlabel{
    //计算方法
    CGRect textRect = [txtlabel boundingRectWithSize:CGSizeMake(kWidth * 0.65, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18.0]} context:nil];
    return textRect.size.height;
    
}

+ (CGFloat)getCellHeightMode:(verHotModel *)hotModel {
    CGFloat textHeight = [[self class] getTextHeightWithText:hotModel.text];
    if (hotModel.textImage == nil) {
        return textHeight + 20;
    } else
        
        return textHeight + hotModel.height / 3 + 60;
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

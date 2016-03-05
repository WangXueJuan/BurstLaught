//
//  GifView.h
//  BurstLaugh
//
//  Created by scjy on 16/3/5.
//  Copyright © 2016年 王雪娟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ImageIO/ImageIO.h>
#import <MobileCoreServices/MobileCoreServices.h>
@interface GifView : UIView
{
    CGImageSourceRef gif; //保存gif动画
    NSDictionary *gifProperties;   //保存gif动画属性
    size_t index;  //gif动画播放开始的帧序号
    size_t count;   //gif的总帧数
    NSTimer *timer;   //开始时间
    
}

- (id)initWithFrame:(CGRect)frame filePath:(NSString *)filePath;
- (void)stopGif;


@end

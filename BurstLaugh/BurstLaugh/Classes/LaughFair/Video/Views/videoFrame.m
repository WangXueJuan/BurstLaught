//
//  videoFrame.m
//  BurstLaugh
//
//  Created by scjy on 16/3/6.
//  Copyright © 2016年 王雪娟. All rights reserved.
//

#import "videoFrame.h"

@implementation videoFrame


- (void)cellHeight{
   
    
    //图片
    CGFloat coverX = 0;
    CGFloat coverY = CGRectGetMaxY(_titleF) + 10;
    CGFloat coverW = kWidth;
    CGFloat coverH = coverW * 0.56;
    _coverF = CGRectMake(coverX, coverY, coverW, coverH);
    
    CGFloat playW = 60;
    CGFloat playH = 60;
    CGFloat playX = coverW/2 - 30;
    CGFloat playY = coverH/2;
    _playF = CGRectMake(playX, playY, playW, playH);
    
    
    //时长
  
    CGFloat lengImagY = CGRectGetMaxY(_coverF) + 10;
    CGFloat lengImagW = 20;
    CGFloat lengImagH = 20;
    _lengtImageF = CGRectMake(0, lengImagY, lengImagW, lengImagH);
    
    CGFloat lengthX = CGRectGetMaxX(_lengtImageF);
    CGFloat lengthY = CGRectGetMaxY(_coverF) + 10;
    CGFloat lengthW = 40;
    CGFloat lengthH = 20;
    _lengthF = CGRectMake(lengthX, lengthY, lengthW, lengthH);
    
    
    //播放数
    CGFloat playImageX = CGRectGetMaxX(_lengthF) + 10;
    CGFloat playImageY = lengImagY;
    CGFloat playImageW = 20;
    CGFloat playImageH = 20;
    _playImageF = CGRectMake(playImageX, playImageY, playImageW, playImageH);
    
    CGFloat playcountX = CGRectGetMaxX(_playImageF);
    CGFloat playcountY = lengthY;
    CGFloat playcountW = 40;
    CGFloat playcountH = 20;
    _playCountF = CGRectMake(playcountX, playcountY, playcountW, playcountH);
    
    //时间
    CGFloat ptimeW = 45;
    CGFloat ptimeH = 20;
    CGFloat ptimeX = kWidth - ptimeW;
    CGFloat ptimeY = lengthY;
    _ptimeF = CGRectMake(ptimeX, ptimeY, ptimeW, ptimeH);
    
    //灰块
    CGFloat lineW = kWidth;
    CGFloat lineH = 10;
    CGFloat lineX = 0;
    CGFloat lineY = CGRectGetMaxY(_ptimeF)+10;
    _lineVF = CGRectMake(lineX, lineY, lineW, lineH);
    
    _cellH = CGRectGetMaxY(_lineVF);
    
 
    
    
}

@end

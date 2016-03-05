//
//  GifView.m
//  BurstLaugh
//
//  Created by scjy on 16/3/5.
//  Copyright © 2016年 王雪娟. All rights reserved.
//

#import "GifView.h"
#import <QuartzCore/QuartzCore.h>
@implementation GifView

-(id)initWithFrame:(CGRect)frame filePath:(NSString *)filePath {
    self = [super initWithFrame:frame];
    if (self) {
        NSDictionary *gifLoopCount = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:0] forKey:(NSString *)kCGImagePropertyGIFLoopCount];
        gifProperties = [NSDictionary dictionaryWithObject:gifLoopCount forKey:(NSString *)kCGImagePropertyGIFDictionary];
        NSString *path;
        gif = CGImageSourceCreateWithURL((CFURLRef)[NSURL fileURLWithPath:path], (CFDictionaryRef)gifProperties);
        count = CGImageSourceGetCount(gif);
        timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(play) userInfo:nil repeats:YES];
        [timer fire];
        
    }
    return self;
}

- (void)play {
    index++;
    index = index % count;
    CGImageRef ref = CGImageSourceCreateImageAtIndex(gif, index, (CFDictionaryRef)gifProperties);
    self.layer.contents = (__bridge id)ref;
}

- (void)stopGif {
    [timer invalidate];
    timer = nil;
}


@end

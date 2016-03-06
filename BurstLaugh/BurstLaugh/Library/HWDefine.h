//
//  HWDefine.h
//  BurstLaugh
//   接口
//  Created by scjy on 16/3/3.
//  Copyright © 2016年 王雪娟. All rights reserved.
//

#ifndef HWDefine_h
#define HWDefine_h
#import <Foundation/Foundation.h>

/*    笑神接口   */
//最热接口
#define kVerHotList @"http://s.budejie.com/topic/list/zuixin/10/budejie-android-6.3.2/0-20.json?market=tencentyingyongbao&appname=baisibudejie&os=4.2.2&client=android&visiting=&mac=90%3A4e%3A2b%3A17%3A8d%3A8b&ver=6.3.2"

//视频接口
#define kVideoList @"http://s.budejie.com/topic/list/zuixin/41/budejie-android-6.3.2/0-20.json?market=tencentyingyongbao&appname=baisibudejie&os=4.2.2&visiting=&mac=90%3A4e%3A2b%3A17%3A8d%3A8b&ver=6.3.2"

//糗事接口
#define kQiushiList @"http://m2.qiushibaike.com/article/list/text?count=30&rqcnt=2"

/*     段子接口   */

//纯文段子
#define kTextJokes @"http://api.mahua.com/app/jokes/text?oauth_signature_method=HMAC-SHA1&oauth_consumer_key=e65fc27d8892e4a50dcd1d8e1bd4bf81&app_channel=channel_yingyongbao&platform=android&oauth_version=1.0&oauth_timestamp=1456977825208&oauth_nonce=ec95a85a367573dc993e2c56a35c7230&device_id=60155e3e2dfe9c0f&api_version=3.0&client_version=3.1.1-relase&oauth_token=&oauth_signature=9Lo7J61Bo7bXVEJbDEYx3KkJWew%3D"

//最新段子
#define kJokesList @"http://jianstory.com/rest/images/new?page=1&type=2&like_count=10"





#endif /* HWDefine_h */

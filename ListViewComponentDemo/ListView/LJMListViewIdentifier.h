//
//  LJMListViewIdentifier.h
//  ListView
//
//  Created by chenxiao on 2017/5/12.
//  Copyright © 2017年 zhangxiaolong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LJMListViewIdentifier : NSObject<NSCopying>

///先通过sectionIdentifier去锁定在哪个section
@property (nonatomic, assign, readonly) NSUInteger sectionIdentifier;
///再通过viewIdentifier去锁定在哪个view（item, header, footer）
@property (nonatomic, assign, readonly) NSUInteger viewIdentifier;

@end

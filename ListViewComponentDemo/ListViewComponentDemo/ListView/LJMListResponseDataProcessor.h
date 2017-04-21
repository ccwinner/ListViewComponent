//
//  LJMListResponseDataProcessor.h
//  ListViewComponentDemo
//
//  Created by chenxiao on 2017/4/21.
//  Copyright © 2017年 com.lianjia. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^completion)(NSArray *);

@protocol LJMListResponseDataProcessor <NSObject>

- (void)processData:(id)data completion:(completion)completion;

@end

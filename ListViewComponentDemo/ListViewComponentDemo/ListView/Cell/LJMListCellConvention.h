//
//  LJMListCellConvention.h
//  ListViewComponentDemo
//
//  Created by chenxiao on 2017/4/20.
//  Copyright © 2017年 com.lianjia. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LJMListCellConvention <NSObject>

- (void)configModel:(id)model;
//- (CGSize)sizeThatFits:(CGSize)expectedSize;
//+ (NSString *)reuseIdentifer;
@end

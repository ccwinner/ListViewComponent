//
//  LJMListSectionConfig.h
//  ListViewComponentDemo
//
//  Created by chenxiao on 2017/4/20.
//  Copyright © 2017年 com.lianjia. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LJMListSectionProtocol <NSObject>

NS_ASSUME_NONNULL_BEGIN

- (NSInteger)numberOfItems;
- (__kindof UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index;
///可能某个cell采用自动布局来规定尺寸
- (CGSize)sizeForItemAtIndex:(NSInteger)index;
///某个responseObject被更新了
- (void)didUpdateResponseObject:(id)object;
///某个index处的item被点击了
- (void)didSelectItemAtIndex:(NSInteger)index;
@end

NS_ASSUME_NONNULL_END

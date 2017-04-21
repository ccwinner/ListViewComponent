//
//  LJMListSectionConfiguration.h
//  ListViewComponentDemo
//
//  Created by chenxiao on 2017/4/20.
//  Copyright © 2017年 com.lianjia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LJMListSectionProtocol.h"

@interface LJMListSectionConfiguration : NSObject<LJMListSectionProtocol>

@property (nonatomic, assign) NSInteger section;
@property (nonatomic, weak) UICollectionView *collectionView;
//@property (nonatomic, weak) LJMListAdapter *adapter;

- (void)setupData:(id)data;
@end

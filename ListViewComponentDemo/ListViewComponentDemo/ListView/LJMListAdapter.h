//
//  LJMListView.h
//  ListViewComponentDemo
//
//  Created by chenxiao on 2017/4/20.
//  Copyright © 2017年 com.lianjia. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LJMListResponseDataProcessor.h"

@class LJMListAdapter;
@class LJMListSectionConfiguration;

@protocol LJMListAdaperDataSource <NSObject>

///提供请求返回的数据
- (NSArray *)responseObjectsForAdapter:(LJMListAdapter *)listAdapter;
@optional
///SectionConfiguration集合
- (NSArray<LJMListSectionConfiguration *> *)listAdapter:(LJMListAdapter *)listAdapter
                                            sectionConfigurationsForData:(id)sectionData;
///SectionConfiguration
- (LJMListSectionConfiguration *)listAdapter:(LJMListAdapter *)listAdapter
                 sectionConfigurationForData:(id)sectionData;
@end

@interface LJMListAdapter : NSObject

@property (nonatomic,weak) UICollectionView *collectionView;
@property (nonatomic, weak) id<LJMListAdaperDataSource> dataSource;

///接口待完善 用来更新用的
- (void)update;
///返回服务端响应数据
- (NSArray *)responseObjects;
///拿到对应响应数据对应的模型
- (LJMListSectionConfiguration *)sectionConfigurationForResponseObject:(id)responseObject;
//- (void)insertSections:(NSArray *)sections;
//- (void)removeSections:(NSArray *)sections;
@end

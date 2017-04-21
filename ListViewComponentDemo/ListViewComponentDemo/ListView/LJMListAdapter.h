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

@optional
- (NSArray<LJMListSectionConfiguration *> *)listAdapter:(LJMListAdapter *)listAdapter
                                            sectionConfigurationsForData:(id)sectionData;
- (LJMListSectionConfiguration *)listAdapter:(LJMListAdapter *)listAdapter
                 sectionConfigurationForData:(id)sectionData;
@end

@interface LJMListAdapter : NSObject

@property (nonatomic,weak) UICollectionView *collectionView;
@property (nonatomic, strong) id responseData;
@property (nonatomic, weak) id<LJMListAdaperDataSource> dataSource;

//- (void)insertSections:(NSArray *)sections;
//- (void)removeSections:(NSArray *)sections;
@end

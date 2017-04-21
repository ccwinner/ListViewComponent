//
//  LJMListView.m
//  ListViewComponentDemo
//
//  Created by chenxiao on 2017/4/20.
//  Copyright © 2017年 com.lianjia. All rights reserved.
//

#import "LJMListAdapter.h"
#import "LJMListSectionConfiguration.h"

@interface LJMListAdapter ()<
UICollectionViewDelegateFlowLayout,
UICollectionViewDataSource,
UICollectionViewDelegate>

@property (nonatomic, strong) NSArray<LJMListSectionConfiguration *> *sectionConfigurations;
@property (nonatomic, strong) NSArray *sectionModels;
@end


@implementation LJMListAdapter

#pragma mark - Public

- (void)setResponseData:(id)responseData {
//    if ([processor respondsToSelector:@selector(processData:completion:)]) {
//        [processor processData:data completion:^(NSArray *models) {
//            self.sectionModels = models;
//        }];
//    } else if ([data isKindOfClass:[NSArray class]]) {
//        self.sectionModels = data;
//    } else {
//        NSAssert(nil != self.sectionModels, @"Section models cannot be non-array");
//    }
    _responseData = responseData;
    NSAssert([self.responseData isKindOfClass:[NSArray class]], @"response data must be array");
    NSArray *models = self.responseData;
    if ([self.dataSource respondsToSelector:@selector(listAdapter:sectionConfigurationsForData:)]) {
        self.sectionConfigurations = [self.dataSource listAdapter:self sectionConfigurationsForData:self.responseData];
    } else if ([self.dataSource respondsToSelector:@selector(listAdapter:sectionConfigurationForData:)]) {
        NSMutableArray *sectionMs = [NSMutableArray arrayWithCapacity:models.count];
        NSInteger sectionIndex = 0;
        for (id model in models) {
            LJMListSectionConfiguration *sectionConfiguration = [self.dataSource listAdapter:self sectionConfigurationForData:model];
            sectionConfiguration.section = sectionIndex;
            sectionConfiguration.collectionView = self.collectionView;
            [sectionMs addObject:sectionConfiguration];
            ++sectionIndex;
        }
        self.sectionConfigurations = sectionMs.copy;
    }
}



#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.sectionConfigurations.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    return self.sectionConfigurations[section].numberOfItems;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [self.sectionConfigurations[indexPath.section] cellForItemAtIndex:indexPath.item];
}

@end

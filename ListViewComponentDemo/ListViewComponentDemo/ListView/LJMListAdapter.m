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

@property (nonatomic, strong) NSDictionary<id, LJMListSectionConfiguration *> *sectionConfigurationMap;
///等把map完善以后，这个属性就被废弃了
@property (nonatomic, strong) NSArray<LJMListSectionConfiguration *> *sectionConfigurations;

@property (nonatomic,strong) NSMutableSet *cellClasses;
@property (nonatomic, strong) NSArray *responseObjects;
@end


@implementation LJMListAdapter

#pragma mark - Public

- (void)update {
    self.responseObjects = [self.dataSource responseObjectsForAdapter:self];
//    if ([processor respondsToSelector:@selector(processData:completion:)]) {
//        [processor processData:data completion:^(NSArray *models) {
//            self.sectionModels = models;
//        }];
//    } else if ([data isKindOfClass:[NSArray class]]) {
//        self.sectionModels = data;
//    } else {
//        NSAssert(nil != self.sectionModels, @"Section models cannot be non-array");
//    }

    NSAssert([self.responseObjects isKindOfClass:[NSArray class]], @"response data must be array");
    NSArray *models = self.responseObjects;
    if ([self.dataSource respondsToSelector:@selector(listAdapter:sectionConfigurationsForData:)]) {
        self.sectionConfigurations = [self.dataSource listAdapter:self sectionConfigurationsForData:self.responseObjects];
    } else if ([self.dataSource respondsToSelector:@selector(listAdapter:sectionConfigurationForData:)]) {
        NSMutableArray *sectionMs = [NSMutableArray arrayWithCapacity:models.count];
        NSInteger sectionIndex = 0;
        for (id model in models) {
            LJMListSectionConfiguration *sectionConfiguration = [self.dataSource listAdapter:self sectionConfigurationForData:model];
//            sectionConfiguration.section = sectionIndex;
//            sectionConfiguration.collectionView = self.collectionView;
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

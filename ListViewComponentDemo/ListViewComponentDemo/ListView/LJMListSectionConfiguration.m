//
//  LJMListSectionConfiguration.m
//  ListViewComponentDemo
//
//  Created by chenxiao on 2017/4/20.
//  Copyright © 2017年 com.lianjia. All rights reserved.
//

#import "LJMListSectionConfiguration.h"
#import "LJMListCellConvention.h"

@interface LJMListSectionConfiguration ()

@property (nonatomic, strong) NSArray *models;

@end

@implementation LJMListSectionConfiguration

- (void)setupData:(id)data {
    //process data
    self.models = [NSArray new];
}

- (NSInteger)numberOfItems {
    return self.models.count;
}

- (__kindof UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index {
    //感觉这里的reuseIdentifier就让子类去实现吧 convention里面的reuseIdentifier都可以不提供
    UICollectionViewCell<LJMListCellConvention> *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class]) forIndexPath:[NSIndexPath indexPathForItem:index inSection:self.section]];
    [cell configModel:self.models[index]];
    return cell;
}

- (CGSize)sizeForItemAtIndex:(NSInteger)index {
    return CGSizeMake(50, 50);
}

@end

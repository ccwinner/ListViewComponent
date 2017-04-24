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
//@property (nonatomic, strong) NSArray<Class> *itemClasses;
@end

@implementation LJMListSectionConfiguration

- (void)setupData:(id)data {
#warning - process data 这只是例子，实际基类没有个方法和models属性。
    self.models = [NSArray new];
}

- (NSInteger)numberOfItems {
    return self.models.count;
}

- (__kindof UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index {
    //感觉这里的reuseIdentifier就让子类去实现吧 convention里面的reuseIdentifier都可以不提供
    //rowData obj id class
    return nil;
}

- (CGSize)sizeForItemAtIndex:(NSInteger)index {
    return CGSizeMake(50, 50);
}

- (void)registerClasses {
    /**
     注册cell header，footer
     各自的Identifier自己维护

     */
}

//- (NSString *)reuseIdentifierWidthIndexObjec:(id)object{
//
//}

@end

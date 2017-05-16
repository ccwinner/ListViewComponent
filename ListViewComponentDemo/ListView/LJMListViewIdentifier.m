//
//  LJMListViewIdentifier.m
//  ListView
//
//  Created by chenxiao on 2017/5/12.
//  Copyright © 2017年 zhangxiaolong. All rights reserved.
//

#import "LJMListViewIdentifier.h"

@interface LJMListViewIdentifier ()

///先通过sectionIdentifier去锁定在哪个section
@property (nonatomic, assign) NSUInteger sectionIdentifier;
///再通过viewIdentifier去锁定在哪个view（item, header, footer）
@property (nonatomic, assign) NSUInteger viewIdentifier;

@end

@implementation LJMListViewIdentifier

- (NSUInteger)hash {
    return _sectionIdentifier ^ _viewIdentifier;
}

- (BOOL)isEqual:(LJMListViewIdentifier *)object {
    if (self == object) return YES;
    if (![object isMemberOfClass:[self class]]) return NO;
    if (self.sectionIdentifier == object.sectionIdentifier && self.viewIdentifier == object.viewIdentifier) return YES;
    return [super isEqual:object];
}

#pragma mark - override

- (id)copyWithZone:(NSZone *)zone {
    //TODO:可能会实现
    return self;
}

@end

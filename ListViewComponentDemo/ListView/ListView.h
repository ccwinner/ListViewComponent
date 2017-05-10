//
//  ListView.h
//  ListView
//
//  Created by zhangxiaolong on 2017/4/27.
//  Copyright © 2017年 zhangxiaolong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ViewDataProtocol <NSObject>
+ (CGSize)sizeWithData:(id)data;
@property (nonatomic,strong) id viewData;

@optional
- (CGFloat)heightWithData:(id)data;
@end

typedef void (^LJMListViewUpdateCompletion)(BOOL finished);

@interface LJMListView : UIView

//将cell header footer注册进ListView中, 方便复用. (reusableId取的视图的class)
/*
 把注册信息放入下面的添加数据源的操作中, 牺牲性能, 使用更方便
 */
//- (void)registerItemClasses:(NSArray<Class> *)itemClasses __attribute__((deprecated));
//- (void)registerHeaderClasses:(NSArray<Class> *)headerClasses;
//- (void)registerFooterClasses:(NSArray<Class> *)footerClasses;


//数据的配置 返回值是当前单元的id
- (NSNumber *)addHeaderWithViewClass:(Class<ViewDataProtocol>)viewClass
                                data:(id)data;
- (NSNumber *)addFooterWithViewClass:(Class<ViewDataProtocol>)viewClass
                                data:(id)data;
- (NSNumber *)addItemWithViewClass:(Class<ViewDataProtocol>)viewClass
                              data:(id)data;
- (NSArray<NSNumber *> *)addItemsWithViewClasses:(NSArray<Class<ViewDataProtocol>> *)viewClasses
                                          data:(NSArray<id> *)data;

///删除操作, 结束后相应的id作废。
- (void)removeItemWithViewClass:(Class<ViewDataProtocol>)viewClass
                           data:(id)data
                     completion:(dispatch_block_t)completion;
- (void)removeItemsWithViewClasses:(NSArray<Class<ViewDataProtocol>> *)viewClasses
                              data:(NSArray<id> *)data
                        completion:(dispatch_block_t)completion;
- (void)clearData;


///设置完数据以后 统一执行更新动画
- (void)performUpdatesAnimated:(BOOL)animated
                    completion:(LJMListViewUpdateCompletion)completion;
///设置完数据以后 直接执行视图的reload操作
- (void)reloadDataWithCompletion:(LJMListViewUpdateCompletion)completion;

//- (void)addHeaderWidthViewClass:(Class<ViewDataProtocol>)viewClass data:(id)data;
//- (void)addFooterWidthViewClass:(Class<ViewDataProtocol>)viewClass data:(id)data;
//- (void)addRowWidthViewClass:(Class<ViewDataProtocol>)viewClass data:(id)data;
//- (void)addRowsWidthViewClasses:(NSArray<Class<ViewDataProtocol>> *)viewClasses datas:(NSArray<id> *)datas;
//- (void)reloadData;
@end

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
                         itemId:(NSNumber *)itemId;
- (void)removeItemsWithViewClasses:(NSArray<Class<ViewDataProtocol>> *)viewClasses
                           itemIds:(NSArray<NSNumber *> *)itemIds;
- (void)clearData;


/**
 通过id检索对应cell
 cell必须在当前屏幕可见区域内。
 @param itemId id
 @return cell
 */
- (UIView<ViewDataProtocol> *)viewByItemId:(NSNumber *)itemId;

/**
 通过id检索对应的data

 @param itemId id
 @return data
 */
- (id)dataByItemId:(NSNumber *)itemId;


#pragma mark - 执行UI更新

/**
 在数据被增减以后，调用performUpdates或者reloadData方法来执行UI的刷新。

 @param animated 是否动画
 @param completion 完成的回调
 */
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

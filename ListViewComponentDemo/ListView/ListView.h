//
//  ListView.h
//  ListView
//
//  Created by zhangxiaolong on 2017/4/27.
//  Copyright © 2017年 zhangxiaolong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LJMListViewIdentifier;

@protocol LJMListViewDataProtocol <NSObject>

@property (nonatomic,strong) id viewData;

@optional
///卡片视图
+ (CGSize)sizeWithData:(id)data;
///列表视图 接口后面考虑去除, 用sizeWithData:代替
+ (CGFloat)heightWithData:(id)data;

@end


typedef void (^LJMListViewUpdateCompletion)(BOOL finished);

typedef NS_ENUM(NSInteger, LJMListViewDataUpdateType) {

    ///紧接着上一次插入的数据继续。这是默认值
    LJMListViewDataUpdateTypeDefault    =   1,

    ///从下个section开始
    LJMListViewDataUpdateTypeNext       =   20,

    ///从数据集合的头部开始插入
    LJMListViewDataUpdateTypeFront      =   30,
    ///从数据集合的尾部开始插入
    LJMListViewDataUpdateTypeEnd,
};


@interface LJMListView : UIView

/**
 *  数据流走向：先添加删除更新数据源，然后外界调用performUpdates、reloadData方法来更新UI
 */


//数据的添加操作 返回值是当前单元的id
- (LJMListViewIdentifier *)addHeaderWithViewClass:(Class<LJMListViewDataProtocol>)viewClass
                                             data:(id)data
                                       updateType:(LJMListViewDataUpdateType)updateType;
/**
 如果已经有header，这个footer理解为同一个section的footer；如果指定了插入
 类型是LJMListViewDataupdateTypeNext 则是下一个section。之后插入的item,
 header也被理解为下一个section

 @param viewClass 视图类
 @param data 数据
 @param updateType 数据更新的顺序
 @return id
 */
- (LJMListViewIdentifier *)addFooterWithViewClass:(Class<LJMListViewDataProtocol>)viewClass
                                             data:(id)data
                                       updateType:(LJMListViewDataUpdateType)updateType;
- (LJMListViewIdentifier *)addItemWithViewClass:(Class<LJMListViewDataProtocol>)viewClass
                                           data:(id)data
                                     updateType:(LJMListViewDataUpdateType)updateType;
- (NSArray<LJMListViewIdentifier *> *)addItemsWithViewClasses:(NSArray<Class<LJMListViewDataProtocol>> *)viewClasses
                                                         data:(NSArray<id> *)dataArray
                                                   updateType:(LJMListViewDataUpdateType)updateType;

///删除操作, 结束后相应的id作废。
- (void)removeItemWithViewClass:(Class<LJMListViewDataProtocol>)viewClass
                         itemId:(LJMListViewIdentifier *)itemId;
- (void)removeItemsWithViewClasses:(NSArray<Class<LJMListViewDataProtocol>> *)viewClasses
                           itemIds:(NSArray<LJMListViewIdentifier *> *)itemIds;
- (void)removeHeaderWithViewClass:(Class<LJMListViewDataProtocol>)viewClass
                         headerId:(LJMListViewIdentifier *)headerId;
- (void)removeFooterWithViewClass:(Class<LJMListViewDataProtocol>)viewClass
                         footerId:(LJMListViewIdentifier *)footerId;


//数据的更新操作，接口类似，懒得写了
//- (void)update...

///清理全部数据
- (void)cleanData;

/**
 通过id检索对应cell
 cell必须在当前屏幕可见区域内。
 @param itemId id
 @return cell
 */
- (UIView<LJMListViewDataProtocol> *)viewByItemId:(LJMListViewIdentifier *)itemId;

/**
 通过id检索对应的data

 @param itemId id
 @return data
 */
- (id)dataByItemId:(LJMListViewIdentifier *)itemId;


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

//- (void)addHeaderWidthViewClass:(Class<LJMListViewDataProtocol>)viewClass data:(id)data;
//- (void)addFooterWidthViewClass:(Class<LJMListViewDataProtocol>)viewClass data:(id)data;
//- (void)addRowWidthViewClass:(Class<LJMListViewDataProtocol>)viewClass data:(id)data;
//- (void)addRowsWidthViewClasses:(NSArray<Class<LJMListViewDataProtocol>> *)viewClasses datas:(NSArray<id> *)datas;
//- (void)reloadData;
@end

//
//  ListView.m
//  ListView
//
//  Created by zhangxiaolong on 2017/4/27.
//  Copyright © 2017年 zhangxiaolong. All rights reserved.
//

#import "ListView.h"

@interface ListViewRowConfig : NSObject
@property (nonatomic,strong) Class viewClass;
@property (nonatomic,strong) id rowData;
@property (nonatomic, assign) CGSize viewSize;
//@property (nonatomic,assign) CGFloat viewHeight;
@end

@implementation ListViewRowConfig



@end

@interface ListViewSectionConfig : NSObject
@property (nonatomic,strong) Class headerViewClass;
@property (nonatomic,strong) id headerData;
@property (nonatomic,strong) NSMutableArray<ListViewRowConfig *> *rowConfigs;
@property (nonatomic,strong) Class footerViewClass;
@property (nonatomic,strong) id footerData;
@end

@implementation ListViewSectionConfig

- (NSMutableArray<ListViewRowConfig *> *)rowConfigs{
    if (nil == _rowConfigs) {
        _rowConfigs = [NSMutableArray array];
    }
    return _rowConfigs;
}

@end


@interface LJMListView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableSet<Class> *registeredItemClasses;
@property (nonatomic, strong) NSMutableSet<Class> *registeredHeaderClasses;
@property (nonatomic, strong) NSMutableSet<Class> *registeredFooterClasses;

@end


@implementation LJMListView {
    ListViewSectionConfig *_currentSectionConfig;
    NSMutableArray<ListViewSectionConfig *> *_dataConfigs;
    NSCache *_cacheViewsForCalculate;
    NSMapTable *_viewConfigMap;
}

#pragma mark - Register

//- (void)registerItemClasses:(NSArray<Class> *)itemClasses {
//    for (Class itemClass in itemClasses) {
//        [self.collectionView registerClass:itemClass
//                forCellWithReuseIdentifier:NSStringFromClass(itemClass)];
//    }
//}
//
//- (void)registerHeaderClasses:(NSArray<Class> *)headerClasses {
//    for (Class headerClass in headerClasses) {
//        [self.collectionView registerClass:headerClass
//                forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
//                       withReuseIdentifier:NSStringFromClass(headerClass)];
//    }
//}
//
//- (void)registerFooterClasses:(NSArray<Class> *)footerClasses {
//    for (Class footerClass in footerClasses) {
//        [self.collectionView registerClass:footerClass
//                forSupplementaryViewOfKind:UICollectionElementKindSectionFooter
//                       withReuseIdentifier:NSStringFromClass(footerClass)];
//    }
//}

#pragma mark - Init

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _dataConfigs = [NSMutableArray array];
        _cacheViewsForCalculate = [[NSCache alloc]init];
        _viewConfigMap = [[NSMapTable alloc]initWithKeyOptions:NSPointerFunctionsWeakMemory valueOptions:NSPointerFunctionsWeakMemory capacity:0];
        [self addSubview:self.tableView];
    }
    return self;
}

#pragma mark - Data Source Update

- (NSNumber *)addItemWithViewClass:(Class<ViewDataProtocol>)viewClass
                              data:(id)data {
    if (!viewClass || !data) {
        return nil;
    }
    return [self addItemsWithViewClasses:@[viewClass] data:@[data]].firstObject;
}

- (NSNumber *)addHeaderWithViewClass:(Class<ViewDataProtocol>)viewClass
                                data:(id)data {
    return nil;
}

- (NSNumber *)addFooterWithViewClass:(Class<ViewDataProtocol>)viewClass data:(id)data {
    return nil;
}

- (NSArray<NSNumber *> *)addItemsWithViewClasses:(NSArray<Class<ViewDataProtocol>> *)viewClasses data:(NSArray<id> *)data {
    return nil;
}

- (void)removeItemWithViewClass:(Class<ViewDataProtocol>)viewClass data:(id)data completion:(dispatch_block_t)completion {
    if (!viewClass || !data) {
        return;
    }
    [self removeItemsWithViewClasses:@[viewClass] data:@[data] completion:completion];
}

- (void)removeItemsWithViewClasses:(NSArray<Class<ViewDataProtocol>> *)viewClasses data:(NSArray<id> *)data completion:(dispatch_block_t)completion {

}

- (void)reloadData{
    [self.tableView reloadData];
}

- (void)addHeaderWidthViewClass:(Class<ViewDataProtocol>)viewClass data:(id)data{
    ListViewSectionConfig *sectionConfig = [[ListViewSectionConfig alloc]init];
    sectionConfig.headerViewClass = viewClass;
    sectionConfig.headerData = data;
    [_dataConfigs addObject:sectionConfig];
    _currentSectionConfig = sectionConfig;
}

- (void)addRowWidthViewClass:(Class<ViewDataProtocol>)viewClass data:(id)data{
    if (nil == _currentSectionConfig) {
        _currentSectionConfig = [[ListViewSectionConfig alloc]init];
        [_dataConfigs addObject:_currentSectionConfig];
    }
    ListViewRowConfig *rowConfig = [[ListViewRowConfig alloc]init];
    rowConfig.viewClass = viewClass;
    rowConfig.rowData = data;
    [_currentSectionConfig.rowConfigs addObject:rowConfig];
}

- (void)addFooterWidthViewClass:(Class<ViewDataProtocol>)viewClass data:(id)data{
    if (nil == _currentSectionConfig) {
        _currentSectionConfig = [[ListViewSectionConfig alloc]init];
        [_dataConfigs addObject:_currentSectionConfig];
    }
    _currentSectionConfig.footerViewClass = viewClass;
    _currentSectionConfig.footerData = data;
    [_dataConfigs addObject:_currentSectionConfig];
    _currentSectionConfig = nil;
}

- (void)addRowsWidthViewClasses:(NSArray<Class<ViewDataProtocol>> *)viewClasses datas:(NSArray<id> *)datas{
    if (nil == _currentSectionConfig) {
        _currentSectionConfig = [[ListViewSectionConfig alloc]init];
        [_dataConfigs addObject:_currentSectionConfig];
    }
    [datas enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self addRowWidthViewClass:viewClasses[idx] data:obj];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataConfigs.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    ListViewSectionConfig *sectionConfig = _dataConfigs[section];
    return sectionConfig.rowConfigs.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    ListViewSectionConfig *sectionConfig = _dataConfigs[section];
//    NSString *key = NSStringFromClass(sectionConfig.headerViewClass);
//    UIView<ViewDataProtocol> *cacheView = [_cacheViewsForCalculate objectForKey:key];
//    if (nil == cacheView) {
//        cacheView = [[sectionConfig.headerViewClass alloc]init];
//        [_cacheViewsForCalculate setObject:cacheView forKey:key];
//    }
//    cacheView.bounds = tableView.bounds;
//    return [cacheView heightWidthData:sectionConfig.headerData];
    return [self heigthForViewClass:sectionConfig.headerViewClass data:sectionConfig.headerData width:tableView.bounds.size.width];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    ListViewSectionConfig *sectionConfig = _dataConfigs[section];
    return [self heigthForViewClass:sectionConfig.footerViewClass data:sectionConfig.footerData width:tableView.bounds.size.width];
}

- (CGFloat)heigthForViewClass:(Class)viewClass data:(id)data width:(CGFloat)width{
    NSString *key = NSStringFromClass(viewClass);
    UIView<ViewDataProtocol> *cacheView = [_cacheViewsForCalculate objectForKey:key];
    if (nil == cacheView) {
        cacheView = [[viewClass alloc]init];
        [_cacheViewsForCalculate setObject:cacheView forKey:key];
    }
    CGFloat fittingHeight = 0;
    if (!cacheView.translatesAutoresizingMaskIntoConstraints) {//是否使用自动布局
        NSLayoutConstraint *widthFenceConstraint = [NSLayoutConstraint constraintWithItem:cacheView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
        [cacheView addConstraint:widthFenceConstraint];
        fittingHeight = [cacheView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
        [cacheView removeConstraint:widthFenceConstraint];
    }else{
        cacheView.bounds = CGRectMake(0, 0, width, 0);
        fittingHeight = [cacheView heightWidthData:data];
    }
    return fittingHeight;
}

#pragma mark - UICollectionViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ListViewSectionConfig *sectionConfig = _dataConfigs[indexPath.section];
    ListViewRowConfig *rowConfig = sectionConfig.rowConfigs[indexPath.row];
    return [self heigthForViewClass:rowConfig.viewClass data:rowConfig.rowData width:tableView.bounds.size.width];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    ListViewSectionConfig *sectionConfig = _dataConfigs[section];
    NSString *identifier = NSStringFromClass(sectionConfig.headerViewClass);
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
    if (nil == headerView) {
        [tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:identifier];
        headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
    }

    UIView<ViewDataProtocol> *contentView = [_viewConfigMap objectForKey:sectionConfig.headerData];
    if (nil == contentView) {
        contentView = [[sectionConfig.headerViewClass alloc]init];
        [headerView.contentView addSubview:contentView];
        [_viewConfigMap setObject:contentView forKey:sectionConfig.headerData];
    }
    contentView.frame = CGRectMake(0, 0, headerView.frame.size.width, headerView.frame.size.height);
    contentView.viewData = sectionConfig.headerData;
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    ListViewSectionConfig *sectionConfig = _dataConfigs[section];
    NSString *identifier = NSStringFromClass(sectionConfig.footerViewClass);
    UITableViewHeaderFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
    if (nil == footerView) {
        [tableView registerClass:[UITableViewHeaderFooterView class]  forHeaderFooterViewReuseIdentifier:identifier];
        footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
    }
    UIView<ViewDataProtocol> *contentView = [_viewConfigMap objectForKey:sectionConfig.headerData];
    if (nil == contentView) {
        contentView = [[sectionConfig.footerViewClass alloc]init];
        [footerView.contentView addSubview:contentView];
        [_viewConfigMap setObject:contentView forKey:sectionConfig.footerData];
    }
    contentView.frame = CGRectMake(0, 0, footerView.frame.size.width, footerView.frame.size.height);
    contentView.viewData = sectionConfig.headerData;
    return footerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ListViewSectionConfig *sectionConfig = _dataConfigs[indexPath.section];
    ListViewRowConfig *rowConfig = sectionConfig.rowConfigs[indexPath.row];
    NSString *identifier = NSStringFromClass(rowConfig.viewClass);
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier];
        cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    }
    UIView<ViewDataProtocol> *contentView = [_viewConfigMap objectForKey:rowConfig.rowData];
    if (nil == contentView) {
        contentView = [[rowConfig.viewClass alloc]init];
        [cell.contentView addSubview:contentView];
        [_viewConfigMap setObject:contentView forKey:rowConfig.rowData];
    }
    contentView.frame = CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height);
    contentView.viewData = rowConfig.rowData;
    NSLog(@"p%p",rowConfig.rowData);
    return cell;
}

- (UITableView *)tableView{
    if (nil == _tableView) {
        _tableView = [[UITableView alloc]init];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.tableView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [self.tableView reloadData];
}

@end

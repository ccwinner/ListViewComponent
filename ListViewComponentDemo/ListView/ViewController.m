//
//  ViewController.m
//  ListView
//
//  Created by zhangxiaolong on 2017/4/27.
//  Copyright © 2017年 zhangxiaolong. All rights reserved.
//

#import "ViewController.h"
#import "ListView.h"

@interface ListHeaderView : UIView<ViewDataProtocol>
@property (nonatomic,strong) id viewData;
@end

@implementation ListHeaderView

- (CGFloat)heightWidthData:(id)data{
    return 10;
}

@end

@interface ListRowView : UIView<ViewDataProtocol>
@property (nonatomic,strong) id viewData;
@end

@implementation ListRowView


- (CGFloat)heightWidthData:(id)data{
    return 100;
}

@end

@interface ViewController ()
@property (nonatomic,strong) ListView *listView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    _listView = [[ListView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:_listView];
    [_listView addHeaderWidthViewClass:[ListHeaderView class] data:@(1)];
    [_listView addRowWidthViewClass:[ListRowView class] data:@(11)];
    [_listView addHeaderWidthViewClass:[ListHeaderView class] data:@(2)];
    [_listView addRowWidthViewClass:[ListRowView class] data:@(21)];
    [_listView addRowWidthViewClass:[ListRowView class] data:@(22)];
    [_listView addHeaderWidthViewClass:[ListHeaderView class] data:@(3)];
    [_listView addFooterWidthViewClass:[ListHeaderView class]  data:@(4)];
    [_listView addRowWidthViewClass:[ListRowView class] data:@(41)];
    [_listView addRowWidthViewClass:[ListRowView class] data:@(42)];
    [_listView addRowWidthViewClass:[ListRowView class] data:@(42)];
}

- (void)viewDidLayoutSubviews{
    _listView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    [_listView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

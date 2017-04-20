//
//  ViewController.m
//  ListViewComponentDemo
//
//  Created by chenxiao on 2017/4/20.
//  Copyright © 2017年 com.lianjia. All rights reserved.
//

#import "ViewController.h"

@interface SectionAdapter : NSObject
@property (nonatomic,strong) NSArray *datas;
@end

@implementation SectionAdapter

- (NSInteger)numberOfItems{
    return self.datas.count;
}

- (CGSize)sizeForItemAtIndex:(NSInteger)index{
    CGSize size = self.datas[index];
    return  size;
}

- (UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index{
    return [UICollectionViewCell new];
}

- (void)didSelectItemAtIndex:(NSInteger)index{

}

@end

@interface ListView : UIView<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

- (void)addSectionAdapter:(SectionAdapter *)sectionAdapter;
@property (nonatomic,strong) UICollectionView *collectionView;
@end

@implementation ListView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        [self addSubview:self.collectionView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame layout:(UICollectionViewLayout *)layout
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

@end





























@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

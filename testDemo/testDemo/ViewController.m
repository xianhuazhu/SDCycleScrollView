//
//  ViewController.m
//  testDemo
//
//  Created by qingyun on 16/1/5.
//  Copyright © 2016年 hnqingyun. All rights reserved.
//

#import "ViewController.h"

#import "NetworkSingleton.h"
#import "SDCycleScrollView.h"

#import "NSString+GetUrl.h"

#import "HOMETopData.h"

#define BASE_URL @"http://www.ecook.cn/public/getHomeData.shtml"

@interface ViewController ()<SDCycleScrollViewDelegate,UITabBarDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;

@property (nonatomic, strong) NSMutableArray *imageUrlArr;

@property (nonatomic, strong) NSMutableArray *TopDadaArr;

@property (nonatomic, strong) NSMutableArray *imgUrlArr;

@end

@implementation ViewController

- (NSMutableArray *)imageUrlArr
{
    if (_imageUrlArr == nil) {
        _imageUrlArr = [NSMutableArray array];
    }
    return _imageUrlArr;
}

- (NSMutableArray *)TopDadaArr
{
    if (_TopDadaArr == nil) {
        _TopDadaArr = [NSMutableArray array];
    }
    return _TopDadaArr;
}

- (NSMutableArray *)imgUrlArr
{
    if (_imgUrlArr == nil) {
        _imgUrlArr = [NSMutableArray array];
    }
    return _imgUrlArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self testNetWorking];
    [self loadDataFromNet];
    [self initCycleScrollView];
    [self initTableView];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)initTableView
{
    self.tableView.tableHeaderView = _cycleScrollView;
}

- (void)initCycleScrollView
{
    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, 375, 200) imageURLStringsGroup:self.imageUrlArr];
    _cycleScrollView.placeholderImage = [UIImage imageNamed:@"Img_default"];
    _cycleScrollView.delegate = self;
    _cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
    _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
}

- (void)loadDataFromNet
{
    [[NetworkSingleton sharedManager] postResultWithParameter:nil url:BASE_URL successBlock:^(id responseBody) {
        
        NSArray *array = responseBody[@"bannerList"];
        for (NSDictionary *dict in array) {
            HOMETopData *TopData = [HOMETopData dataWithDictionary:dict];
            [self.TopDadaArr addObject:TopData];
            [self.imageUrlArr addObject:[NSString getImageUrlStr:TopData.imageid]];
        }
        _cycleScrollView.imageURLStringsGroup = self.imageUrlArr;
    } failureBlock:^(NSString *error) {
        
    }];
}

- (void)testNetWorking
{
    NSDictionary *parameter = @{@"c_md5" : @"e5c4151d2b537199c8dbbe522e84a4c8",
                                @"lon" : @"113.561945",
                                @"format" : @"json",
                                @"source" : @"android",
                                @"lat" : @"34.819336"
                                };
    [[NetworkSingleton sharedManager] postResultWithParameter:parameter url:@"http://api.meishi.cc/v5/index2.php?format=json" successBlock:^(id responseBody) {
        NSArray *dataArr = responseBody[@"obj"][@"san_can"];
        for (NSDictionary *dict in dataArr) {
            [self.imgUrlArr addObject:dict[@"titlepic"]];
        }
        NSLog(@"%@",self.imgUrlArr);
    } failureBlock:^(NSString *error) {
        
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    return cell;
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    HOMETopData *topData = self.TopDadaArr[index];
    NSLog(@"%@",topData.url);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

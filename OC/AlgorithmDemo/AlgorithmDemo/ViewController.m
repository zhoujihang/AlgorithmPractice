//
//  ViewController.m
//  AlgorithmDemo
//
//  Created by 周际航 on 16/7/29.
//  Copyright © 2016年 zjh. All rights reserved.
//

#import "ViewController.h"
#import "ChessBoardModel.h"
#import "AlgorithmTool.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong, nullable) UITableView *tableView;
@property (nonatomic, strong, nullable) AlgorithmTool *tool;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

- (void)setup {
    [self setupView];
    [self setupFrame];
    [self setupData];
}

- (void)setupView {
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.alwaysBounceVertical = YES;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [self.view addSubview:self.tableView];
}

- (void)setupFrame {
    self.tableView.frame = self.view.bounds;
}

- (void)setupData {
    self.tool = [AlgorithmTool shared];
}

#pragma mark - UITableView 代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSString *text = [[NSString alloc] initWithFormat:@"%ld - %ld", indexPath.section, indexPath.row];
    if (indexPath.row == 0) {
        text = @"冒泡排序";
    } else if (indexPath.row == 1) {
        text = @"快速排序";
    } else if (indexPath.row == 2) {
        text = @"直接插入排序";
    } else if (indexPath.row == 3) {
        text = @"二分插入排序";
    } else if (indexPath.row == 4) {
        text = @"AlphaBeta剪枝搜索";
    }
    cell.textLabel.text = text;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SEL sel = NSSelectorFromString([NSString stringWithFormat:@"func%ld", indexPath.row]);
    if ([self respondsToSelector:sel]) {
        [self performSelector:sel withObject:self];
    }
}

- (void)func0 {
    [self.tool maopao];
}
- (void)func1 {
    [self.tool kuaipai];
}
- (void)func2 {
    [self.tool chapai_direct];
}
- (void)func3 {
    [self.tool chapai_binary];
}
- (void)func4 {
    [self.tool search_AlphaBeta];
}

@end



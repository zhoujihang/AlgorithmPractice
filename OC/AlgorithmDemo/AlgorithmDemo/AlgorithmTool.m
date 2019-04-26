//
//  AlgorithmTool.m
//  AlgorithmDemo
//
//  Created by 周际航 on 2019/4/24.
//  Copyright © 2019年 zjh. All rights reserved.
//

#import "AlgorithmTool.h"
#import "ChessBoardModel.h"

@interface AlgorithmTool ()

@property (nonatomic, strong, nullable) NSMutableArray<NSNumber *> *list;

@end

@implementation AlgorithmTool

+ (instancetype)shared {
    static AlgorithmTool *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[AlgorithmTool alloc] init];
    });
    return _instance;
}

- (instancetype)init {
    if (self = [super init]) {
        [self resetData];
    }
    return self;
}
- (void)resetData {
    self.list = [@[@4,@11,@9,@3,@14,@22,@2,@3,@100,@19,@1,@21] mutableCopy];
}

- (void)maopao {
    [self resetData];
    NSString *str = [self.list componentsJoinedByString:@", "];
    NSLog(@"maopao  before:%@", str);
    for (int i=0; i<self.list.count; i++) {
        for (int j=i+1; j<self.list.count; j++) {
            if ([self.list[i] integerValue] > [self.list[j] integerValue]) {
                NSNumber *t = self.list[j];
                self.list[j] = self.list[i];
                self.list[i] = t;
            }
        }
    }
    str = [self.list componentsJoinedByString:@", "];
    NSLog(@"maopao  after:%@", str);
}

- (void)kuaipai {
    [self resetData];
    NSString *str = [self.list componentsJoinedByString:@", "];
    NSLog(@"kuaipai  before:%@", str);
    [self kuaipai:self.list head:0 tail:self.list.count-1 isIncrease:YES];
    str = [self.list componentsJoinedByString:@", "];
    NSLog(@"kuaipai  after:%@", str);
}
- (void)kuaipai:(NSMutableArray *)list head:(NSInteger)head tail:(NSInteger)tail isIncrease:(BOOL)isIncrease {
    if (list.count <= 1) {return;}
    if (head<0 || tail>list.count-1) {return;}
    if (head>=tail) {return;}
    NSInteger low = head;
    NSInteger hight = tail;
    BOOL kRight = NO;       // 基数是否已交换到右边
    while (1) {
        if (low == hight){
            if (low-head>0) {
                // 左边递归
                NSLog(@"左边递归:%@", [[self.list subarrayWithRange:NSMakeRange(head, low-head)] componentsJoinedByString:@", "]);
                [self kuaipai:list head:head tail:low-1 isIncrease:isIncrease];
            }
            if (tail-hight>0) {
                // 右边递归
                NSLog(@"右边递归:%@", [[self.list subarrayWithRange:NSMakeRange(hight+1, tail-hight)] componentsJoinedByString:@", "]);
                [self kuaipai:list head:hight+1 tail:tail isIncrease:isIncrease];
            }
            break;
        }
        // 交换
        BOOL needChange = isIncrease ? [list[low] integerValue] > [list[hight] integerValue] : [list[low] integerValue] < [list[hight] integerValue];
        if (needChange) {
            id t = list[hight];
            list[hight] = list[low];
            list[low] = t;
            kRight = !kRight;
            NSLog(@"交换:%@", [self.list componentsJoinedByString:@", "]);
        }
        kRight ? low++ : hight--;
    }
}

- (void)chapai_direct {
    [self resetData];
    if (self.list.count <= 1) {return;}
    NSString *str = [self.list componentsJoinedByString:@", "];
    NSLog(@"chapai_direct  before:%@", str);
    for (int i=1; i<self.list.count; i++) {
        if ([self.list[i-1] integerValue] <= [self.list[i] integerValue]) {continue;}
        id inset = self.list[i];
        // 开始插入交换
        for (int j=i; j>0; j--) {
            if ([self.list[j-1] integerValue] <= [self.list[j] integerValue]) {break;}
            self.list[j] = self.list[j-1];
            self.list[j-1] = inset;
        }
    }
    str = [self.list componentsJoinedByString:@", "];
    NSLog(@"chapai_direct  after:%@", str);
}

- (void)chapai_binary {
    [self resetData];
    if (self.list.count <= 1) {return;}
    NSString *str = [self.list componentsJoinedByString:@", "];
    NSLog(@"chapai_direct  before:%@", str);
    for (int i=1; i<self.list.count; i++) {
        if ([self.list[i] integerValue] >= [self.list[i-1] integerValue]) {continue;}
        id inset = self.list[i];
        // 开始二分查找排序
        NSLog(@"开始二分查找排序 obj:%@ array:%@", inset, [[self.list subarrayWithRange:NSMakeRange(0, i-1)] componentsJoinedByString:@", "]);
        NSInteger insetIndex = [self insetIndexOfObject:inset inArray:self.list head:0 tail:i-1];
        if (insetIndex == NSNotFound) {break;}
        for (int j=i; j>insetIndex; j--) {
            self.list[j] = self.list[j-1];
        }
        self.list[insetIndex] = inset;
        NSLog(@"替换后的数组：%@", [[self.list subarrayWithRange:NSMakeRange(0, self.list.count-1)] componentsJoinedByString:@", "]);
    }
    str = [self.list componentsJoinedByString:@", "];
    NSLog(@"chapai_direct  after:%@", str);
}
// 二分查找法
- (NSInteger)insetIndexOfObject:(id)obj inArray:(NSArray *)arr head:(NSInteger)head tail:(NSInteger)tail{
    if (!obj) {return NSNotFound;}
    if (head < 0 || tail > arr.count-1) {return NSNotFound;}
    if (head > tail) {return NSNotFound;}
    NSInteger insetIndex = NSNotFound;
    NSInteger centerIndex = head + (tail - head)/2;
    if ([arr[centerIndex] integerValue] == [obj integerValue]) {
        insetIndex = centerIndex+1;
        NSLog(@"--中心值相等center:%ld insetIndex:%ld", centerIndex, insetIndex);
    }else if ([arr[centerIndex] integerValue] > [obj integerValue]) {
        if (centerIndex <= head){
            // 最小
            insetIndex = head;
            NSLog(@"--比最左还小 insetIndex:%ld", insetIndex);
        }else{
            NSLog(@"--head:%ld tail:%ld center:%ld 左边二分查找obj:%@ arr:%@", head, tail, centerIndex, obj , [[arr subarrayWithRange:NSMakeRange(head, centerIndex-head)] componentsJoinedByString:@", "]);
            insetIndex = [self insetIndexOfObject:obj inArray:arr head:head tail:centerIndex];
        }
    }else {
        if (centerIndex >= tail) {
            // 最大
            insetIndex = tail+1;
            NSLog(@"--比最右还大 insetIndex:%ld", insetIndex);
        }else{
            NSLog(@"--head:%ld tail:%ld center:%ld 右边二分查找obj:%@ arr:%@", head, tail, centerIndex, obj , [[arr subarrayWithRange:NSMakeRange(centerIndex+1, tail-(centerIndex+1))] componentsJoinedByString:@", "]);
            insetIndex = [self insetIndexOfObject:obj inArray:arr head:centerIndex+1 tail:tail];
        }
    }
    return insetIndex;
}

#pragma mark - alpha_beta 剪枝搜索
static long long nodeNumber = 0;
static long long cutCount = 0;
- (void)search_AlphaBeta{
    NSInteger alpha = -2000000;
    NSInteger beta = 2000000;

    NSInteger bestValue = [self alpha_betaSearchBoard:[ChessBoardModel new] alpha:alpha beta:beta deep:2];
    NSLog(@"最优解为:%ld", bestValue);
    NSLog(@"遍历节点数：%lld  剪枝次数:%lld", nodeNumber, cutCount);
}

// beta剪枝
- (NSInteger)alpha_betaSearchBoard:(ChessBoardModel *)board alpha:(NSInteger)alpha beta:(NSInteger)beta deep:(NSInteger)deep{
    if (deep == 0) {return [board evaluate];}
    NSLog(@"===============alpha:%ld  beta:%ld  deep:%ld", alpha, beta, deep);
    NSArray<ChessBoardModel *> *steps = [self nextStepArrayForBoard:board];
    nodeNumber += steps.count;
    for (int i=0; i<steps.count; i++) {
        ChessBoardModel *nextBoard = steps[i];

        // 取负数替代找最大和找最小的切换，算法就能统一为找最大
        NSInteger nextValue = -[self alpha_betaSearchBoard:nextBoard alpha:-beta beta:-alpha deep:deep-1];
        NSLog(@"得到deep:%ld层节点的值 value:%ld", deep, nextValue);

        // 找到更大的最小值，更新alpha
        if (nextValue > alpha) {
            alpha = nextValue;
            NSLog(@"更新alpha后： alpha:%ld beta:%ld deep:%ld", alpha, beta, deep);
        }

        // 剪枝
        if (nextValue >= beta) {
            NSLog(@"执行最大剪枝 nextEvaluate:%ld alpha:%ld beta:%ld deep:%ld", nextValue, alpha, beta, deep);
            cutCount++;
            break;
        }
    }
    NSLog(@"返回deep:%ld层的结果 alpha:%ld", deep, alpha);
    return alpha;
}
// 列出下一步可走棋局
- (NSArray<ChessBoardModel *> *)nextStepArrayForBoard:(ChessBoardModel *)board{
    NSInteger step = arc4random_uniform(40);
    NSMutableArray *marr = [@[] mutableCopy];
    while (step>0) {
        [marr addObject:[ChessBoardModel new]];
        step--;
    }
    return [marr copy];
}
// 评价函数，返回board当前棋盘评分,总以黑棋视角评分
- (NSInteger)evaluateBoard:(ChessBoardModel *)board{
    return board.evaluate;
}


@end

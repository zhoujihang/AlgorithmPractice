//
//  AlgorithmTool.h
//  AlgorithmDemo
//
//  Created by 周际航 on 2019/4/24.
//  Copyright © 2019年 zjh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AlgorithmTool : NSObject

+ (instancetype)shared;

/// 冒泡
- (void)maopao;
/// 快排
- (void)kuaipai;

#pragma mark - 插入排序
/// 直接插入排序
- (void)chapai_direct;
/// 二分插入排序
- (void)chapai_binary;

/// ∂ß 剪枝搜索
- (void)search_AlphaBeta;

@end

NS_ASSUME_NONNULL_END

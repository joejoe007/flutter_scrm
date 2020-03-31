//
//  EXOCRLPRInfo.h
//  ExLPRSDK
//
//  Created by kubo on 16/9/2.
//  Copyright © 2015年 kubo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *	@brief 车牌识别回调状态码
 *
 *	@discussion 识别回调中获取状态码
 */
#define LPR_CODE_SUCCESS           (0)
#define LPR_CODE_CANCEL            (1)
#define LPR_CODE_FAIL              (-1)
#define LPR_CODE_FAIL_TIMEOUT      (-2)

/**
 *	@brief 车牌数据模型类
 */
@interface EXOCRLPRInfo : NSObject

@property (nonatomic, strong) NSString *lprType;   //车牌类型
@property (nonatomic, strong) NSString *lprNum;    //车牌号

@property (nonatomic, strong) UIImage *fullImg;    //全图
@property (nonatomic, strong) UIImage *lprNumImg;  //车牌截图

-(NSString *)toString;

@end

//
//  ChannelTool.m
//  Runner
//
//  Created by 张智慧 on 2019/11/15.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

#import "ChannelTool.h"
#import <ExLPRSDK/ExLPRSDK.h> /// 扫描车牌SDK


typedef void(^MethodChannelBlock)(FlutterMethodCall *methodCall, FlutterResult methodResult);


typedef void(^GetCarNumBlock)(NSString *carNumStr);

@interface ChannelTool ()
<FlutterStreamHandler>
/// 已获取车牌号
@property (nonatomic, copy) NSString *carNo;
@end

@implementation ChannelTool

+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    static ChannelTool *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (void)scanToGetcarNum {
    @WeakSelf(self);
    [self initMethodChannelWithName:@"com.chuangzhihui.scrm/plugin" blockWith:^(FlutterMethodCall *methodCall, FlutterResult methodResult) {
        if([methodCall.method isEqualToString:@"usrScan"]) {
            [weakSelf jumpToScanVCWith:^(NSString *carNumStr) {
                methodResult(carNumStr);
            }];
        }
    }];
}

- (void)jumpToScanVCWith:(GetCarNumBlock)getCarNoBlock {
    EXOCRLPRRecoManager * manger = [EXOCRLPRRecoManager sharedManager:(FlutterViewController*)[UIViewController currentViewController]];
    [manger setDisplayLogo:NO];
    [manger setScanTips:@"请在框内扫描车牌号"];
    dispatch_async(dispatch_get_main_queue(), ^{
        [manger recoLPRFromStreamOnCompleted:^(int statusCode, EXOCRLPRInfo *lprInfo) {
            if(getCarNoBlock) {
                getCarNoBlock(lprInfo.lprNum);
            }
        } OnCanceled:^(int statusCode) {
            
        } OnFailed:^(int statusCode, UIImage *recoImg) {
            
        }];
    });
}


#pragma mark -- flutter 调用原生
- (void)initMethodChannelWithName:(NSString *)channelName blockWith:(MethodChannelBlock)channelBlock {
    FlutterMethodChannel *channel = [FlutterMethodChannel methodChannelWithName:channelName binaryMessenger:(FlutterViewController *)[UIViewController currentViewController]];
    [channel setMethodCallHandler:^(FlutterMethodCall * _Nonnull call, FlutterResult  _Nonnull result) {
        if(channelBlock) {
            channelBlock(call,result);
        }
    }];

}

#pragma mark -- 需要再扩展。原生主动向flutter发送消息
- (void)initEventChannelWithName:(NSString *)channelName {
    FlutterEventChannel *evenChannal = [FlutterEventChannel eventChannelWithName:channelName binaryMessenger:(FlutterViewController *)[UIViewController currentViewController]];
    [evenChannal setStreamHandler:self];
}

- (FlutterError *)onListenWithArguments:(id)arguments eventSink:(FlutterEventSink)events {
   
    return nil;
}

- (FlutterError *)onCancelWithArguments:(id)arguments {
  
    return nil;
}

@end

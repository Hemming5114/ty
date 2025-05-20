//
//  STParamUtil.m
//
//  Created by HaifengMay on 16/11/5.
//  Copyright © 2016年 SenseTime. All rights reserved.
//

#import "STParamUtil.h"

#import <UIKit/UIKit.h>
#import <mach/mach.h>
#import <CommonCrypto/CommonDigest.h>

 

void setBeautifyParam(st_handle_t beautifyHandle, st_beautify_type type, float value) {
        
    if (beautifyHandle) {
        st_result_t iRet = st_mobile_beautify_setparam(beautifyHandle, type, value);
        if (iRet != ST_OK) {
            NSLog(@"st mobile beautify set beautiy type %d failed: %d", type, iRet);
        }
        
    } else {
        NSLog(@"handle not exist.");
    }
}

  
@implementation STParamUtil


@end


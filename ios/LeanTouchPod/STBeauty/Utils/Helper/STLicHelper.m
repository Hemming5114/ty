//
//  STLicHelper.m

//  Copyright © 2020 STBeauty All rights reserved.
//

#import "STLicHelper.h"
#import "st_mobile_license.h"
#import "st_mobile_common.h"
#import <CommonCrypto/CommonDigest.h>

@implementation STLicHelper


+ (BOOL)checkLicense {
    if ([self checkLicenseFromLocal]) {
        return YES;
    }
    return [self checkDownloadedLicense];
}

// 校验ipa包里面的license
+ (BOOL)checkLicenseFromLocal {
    
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"STBeauty" ofType:@"bundle"];
    NSBundle *Bundle = [NSBundle bundleWithPath:bundlePath];
    NSString *licPath = [Bundle pathForResource:@"SENSEME" ofType:@"lic"];
    
    NSData *licenseData = [NSData dataWithContentsOfFile:licPath];
    if (licenseData) {
        return [self checkActiveCodeWithData:licenseData];
        
    } else {
        return NO;
    }
    
}
// 校验网络下载缓存的license
+ (BOOL)checkDownloadedLicense {
    
    NSString *path = self.licDiskPath;
    if ([NSFileManager.defaultManager fileExistsAtPath:path]) {
        NSData *licData = [NSData dataWithContentsOfFile:path];
        return  [self checkActiveCodeWithData:licData];;
    }
    return NO;
}

// 商汤SDK，校验license
+ (BOOL)checkActiveCodeWithData:(NSData *)dataLicense {
    
    NSString *strKeyActiveCode = @"ACTIVE_CODE_ONLINE";
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *strActiveCode = [userDefaults objectForKey:strKeyActiveCode];
    st_result_t iRet = ST_E_FAIL;
    
    iRet = st_mobile_check_activecode_from_buffer(
                                                  [dataLicense bytes],
                                                  (int)[dataLicense length],
                                                  strActiveCode.UTF8String,
                                                  (int)[strActiveCode length]
                                                  );
    
    if (ST_OK == iRet) {
        return YES;
    }
    
    char active_code[1024];
    int active_code_len = 1024;
    
    iRet = st_mobile_generate_activecode_from_buffer(
                                                     [dataLicense bytes],
                                                     (int)[dataLicense length],
                                                     active_code,
                                                     &active_code_len
                                                     );
    
    strActiveCode = [[NSString alloc] initWithUTF8String:active_code];
    
    if (iRet == ST_OK && strActiveCode.length) {
        [userDefaults setObject:strActiveCode forKey:strKeyActiveCode];
        [userDefaults synchronize];
        return YES;
    }
    
#if DEBUG
    
    //sdk版本号
    const char *toDb = st_mobile_get_version();
    NSString *version = [[NSString alloc]initWithUTF8String:toDb];
    NSLog(@"senseTime version = %@",version);
    
    NSLog(@"商汤SDK美颜license校验失败！！！错误码：%@",@(iRet));
    
#endif
    
    return NO;
}

// md5校验
+ (BOOL)checkLicFileMd5With:(NSString *)md5 {
    
    if (md5.length <= 0) {
        return NO;
    }
    
    NSString *filePath = [self licDiskPath];
    NSString *fileMd5  = [self fileMD5:filePath];
    
    return [fileMd5 isEqualToString:md5];
}



//
+ (void)downloadLicsenWith:(NSString *)licUrl completion:(void (^)(BOOL))completion {
    
    BOOL urlOk = YES;
    NSURL *url = nil;
    
    
    if (licUrl.length == 0) {
        urlOk = NO;
    } else {
        url = [NSURL URLWithString:licUrl];
        if (url == nil) {
            urlOk = NO;
        }
    }
    
    if (urlOk == NO) {
        if (completion) {
            completion(NO);
        }
        return;
    }
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:licUrl]];
    request.HTTPMethod      = @"GET";
    request.timeoutInterval = 15.0f;
    [[NSURLSession.sharedSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            BOOL licValid = NO;
            if (data) {
                [self saveLicenseData:data];
                licValid = [self checkDownloadedLicense];
            }
            if (completion) {
                completion(licValid);
            }
        });
    }] resume];
    
}


// 保存下载的license
+ (void)saveLicenseData:(NSData *)licData {
    
    if (licData == nil) {
        return;
    }
    
    NSString *path = self.licDiskPath;
    NSFileManager *fm = NSFileManager.defaultManager;
    
    if ([fm fileExistsAtPath:path]) {
        [fm removeItemAtPath:path error:nil];
    }
    
    [licData writeToFile:path atomically:YES];
    
}


+ (NSString *)licDiskDirectory {
    
    NSString *docDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *stDirectory = [docDirectory stringByAppendingPathComponent:@"App/ST/"];
    NSFileManager *fm = NSFileManager.defaultManager;
    //
    if ([fm fileExistsAtPath:stDirectory] == NO) {
        [fm createDirectoryAtPath:stDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    return stDirectory;
    
}

+ (NSString *)licDiskPath {
    
    NSString *stDirectory = [self licDiskDirectory];
    return [stDirectory stringByAppendingPathComponent:@"SENSEMELIC"];
    
}

+ (NSString *)fileMD5:(NSString *)filePath {
    
    NSFileHandle *handle = [NSFileHandle fileHandleForReadingAtPath:filePath];
    if(!handle)
    {
        return nil;
    }
    
    CC_MD5_CTX md5;
    CC_MD5_Init(&md5);
    BOOL done = NO;
    while (!done)
    {
        NSData *fileData = [handle readDataOfLength:256];
        CC_MD5_Update(&md5, [fileData bytes], (CC_LONG)[fileData length]);
        if([fileData length] == 0)
            done = YES;
    }
    
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5_Final(digest, &md5);
    
    NSString *result = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                        digest[0], digest[1],
                        digest[2], digest[3],
                        digest[4], digest[5],
                        digest[6], digest[7],
                        digest[8], digest[9],
                        digest[10], digest[11],
                        digest[12], digest[13],
                        digest[14], digest[15]];
    return result;
}

@end


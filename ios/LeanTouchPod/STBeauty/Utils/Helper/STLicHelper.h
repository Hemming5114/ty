//
//  STLicHelper.h

//  Copyright © 2020 STBeauty All rights reserved.
//


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/*!
 * 商汤美颜license助手；下载、存储、认证
 */
@interface STLicHelper : NSObject

+ (BOOL)checkLicense;

+ (BOOL)checkLicFileMd5With:(NSString *)md5;


+ (void)downloadLicsenWith:(NSString *)licUrl completion:(void (^)(BOOL))completion;


@end

NS_ASSUME_NONNULL_END

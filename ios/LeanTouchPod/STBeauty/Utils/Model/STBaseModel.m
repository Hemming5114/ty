//
//  STBaseModel.m
//  STBeauty
//
//  Created by Hemming on 2024/6/27.
//

#import "STBaseModel.h"

@implementation STBaseModel

+ (instancetype)modelWithDic:(NSDictionary *)dic {
    
    return [[[self class] alloc] initWithDictionary:dic error:nil];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
                             error:(NSError *__autoreleasing *)err {
    
    if ([dict isKindOfClass:[NSDictionary class]] == NO) {
        return nil;
    }
    
    return [super initWithDictionary:dict error:err];
}
+(BOOL)propertyIsOptional:(NSString *)propertyName{
    return YES;
}

@end

//
//  KFCDataService.h
//  DataService
//
//  Created by mR yang on 16/8/3.
//  Copyright © 2016年 mR yang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ComplectionBlock)(id data);
@interface KFCDataService : NSObject

// GET

+ (void)GET:(NSString *)url
          parameters:(NSMutableDictionary *)params
        headerFields:(NSMutableDictionary *)header
    complectionBlock:(ComplectionBlock)block;
// POST
/**
 *  POST请求
 *
 *  @param url      url
 *  @param params   参数 需要创建成一个字典
 *  @param header   请求头
 *  @param formData 上传的文件Data
 *  @param block    回调的block
 */
+ (void)POST:(NSString *)url
          parameters:(NSMutableDictionary *)params
        headerFields:(NSMutableDictionary *)header
            formData:(NSData *)formData
    complectionBlock:(ComplectionBlock)block;

// POST+GET
+ (void)requestWithURL:(NSString *)url
            httpMethod:(NSString *)method
            parameters:(NSMutableDictionary *)params
          headerFields:(NSMutableDictionary *)header
              formData:(NSData *)formData
      complectionBlock:(ComplectionBlock)block;
@end

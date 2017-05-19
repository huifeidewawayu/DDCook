//
//  KFCDataService.m
//  DataService
//
//  Created by mR yang on 16/8/3.
//  Copyright © 2016年 mR yang. All rights reserved.
//

#import "KFCDataService.h"
#define Boundary @"--aGHJF653ds---"
@implementation KFCDataService

// GET

+ (void)GET:(NSString *)url
          parameters:(NSMutableDictionary *)params
        headerFields:(NSMutableDictionary *)header
    complectionBlock:(ComplectionBlock)block {
  
  //  容错 ，如果外部传入一个nil则会cash
  if (params==nil) {
    params=[NSMutableDictionary dictionary];
  }
  
  NSMutableString *fullStr=[NSMutableString string];
  
  for (NSString *key in params) {
    
    id value=[params objectForKey:key];
    
    NSString *keyValueStr=[NSString stringWithFormat:@"%@=%@",key,value];
    
    [fullStr appendFormat:@"%@&",keyValueStr];
    
  }
  
  //  处理最后一个&
  
  if (fullStr.length!=0) {
    [fullStr deleteCharactersInRange:NSMakeRange(fullStr.length-1, 1)];
  }

//  拼接GET请求的URL   PS：?不要丢了
  NSString *lastString=[NSString stringWithFormat:@"%@?%@",url,fullStr];
  
  
  //  1.URL
  NSURL *fullUrl=[NSURL URLWithString:lastString];
  
  //  2.创建request
  NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:fullUrl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:120];
  
  //  (1)设置请求方式
  [request setHTTPMethod:@"GET"];
  
  //  (2)设置请求头
  //  request addValue:<#(nonnull NSString *)#> forHTTPHeaderField:<#(nonnull NSString *)#>
  //  容错
  if (header) {
    [request setAllHTTPHeaderFields:header];
  }
  
    
  
  //  3.创建session
  NSURLSession *session=[NSURLSession sharedSession];
  
  //  4.创建网络请求
  NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    
    //    如果请求失败
    if (error) {
      
      NSLog(@"error = %@",error);
      
      return ;
    }
    
    NSHTTPURLResponse *httpResponse=(NSHTTPURLResponse *)response;
    
    //    成功
    if (httpResponse.statusCode==200) {
      
      NSError *jsonError=nil;
      //      解析数据
      id jsonData=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonError];
      
      if (jsonError) {
        NSLog(@"解析错误 原因为%@",jsonError);
      }
      
      
      //      返回数据要放到主线程
      dispatch_sync(dispatch_get_main_queue(), ^{
        
        block(jsonData);
      });
      
    }
    
  }];
  
  //  5.发送请求
  [task resume];
}


//POST
+ (void)POST:(NSString *)url
          parameters:(NSMutableDictionary *)params
        headerFields:(NSMutableDictionary *)header
            formData:(NSData *)formData
    complectionBlock:(ComplectionBlock)block {
  
//  1.URL
  NSURL *fullUrl=[NSURL URLWithString:url];
  
//  2.创建request
  NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:fullUrl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:120];
  
//  (1)设置请求方式
  [request setHTTPMethod:@"POST"];
  
//  (2)设置请求头
//  request addValue:<#(nonnull NSString *)#> forHTTPHeaderField:<#(nonnull NSString *)#>
//  容错
  if (header) {
     [request setAllHTTPHeaderFields:header];
  }
  
//  (3)设置请求体
//  params {key1:value1,key2:value2...}
//  key1=value&key2=value2  -->NSData   -->HTTPBody
  
//  容错 ，如果外部传入一个nil则会cash
  if (params==nil) {
    params=[NSMutableDictionary dictionary];
  }
  
  if (!formData) {  //------------------不需要上传文件，只做简单的post请求-----------------------
  
  NSMutableString *fullStr=[NSMutableString string];
  
  for (NSString *key in params) {
    
    id value=[params objectForKey:key];
    
    NSString *keyValueStr=[NSString stringWithFormat:@"%@=%@",key,value];
    
    [fullStr appendFormat:@"%@&",keyValueStr];
    
  }
  
//  处理最后一个&
  
  if (fullStr.length!=0) {
    [fullStr deleteCharactersInRange:NSMakeRange(fullStr.length-1, 1)];
  }
  
  
//  设置请求体
  [request setHTTPBody:[fullStr dataUsingEncoding:NSUTF8StringEncoding]];
  
  }else{//------------------需要向服务器上传文件-----------------------
    
    NSString *headerField=[NSString stringWithFormat:@"multipart/form-data; charset=utf-8;boundary=%@",Boundary];
    
//    需要设置请求头
    [request addValue:headerField forHTTPHeaderField:@"Content-Type"];
    
//    获取请求体
    NSData *fileData = [self buildHttpBodyWithParams:params withFormData:formData];
    
    [request setHTTPBody:fileData];
    
  }
  
//  3.创建session
  NSURLSession *session=[NSURLSession sharedSession];
  
//  4.创建网络请求
  NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    
//    如果请求失败
    if (error) {
      
      NSLog(@"error = %@",error);
      
      return ;
    }
    
    NSHTTPURLResponse *httpResponse=(NSHTTPURLResponse *)response;
    
//    成功
    if (httpResponse.statusCode==200) {
      
      NSError *jsonError=nil;
//      解析数据
      id jsonData=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonError];
      
      if (jsonError) {
        NSLog(@"解析错误 原因为%@",jsonError);
      }
      
      
//      返回数据要放到主线程
      dispatch_sync(dispatch_get_main_queue(), ^{
        
        block(jsonData);
      });
      
    }
    
  }];
  
//  5.发送请求
  [task resume];
  
}


//拼接请求体
+(NSData *)buildHttpBodyWithParams:(NSMutableDictionary *)params withFormData:(NSData *)formData{
  //按照请求体的格式，拼接请求体
  //开头的bodyStr + 图片数据 + 结束str
  NSMutableData *bodyData = [NSMutableData data];
  
  //(1)bodyStr
  NSMutableString *bodyStr = [NSMutableString string];
  for (NSString *key in params) {
    id value = [params objectForKey:key];
    
    [bodyStr appendFormat:@"--%@\r\n", Boundary]; // \n 换行，\r 切换到行首
    [bodyStr appendFormat:@"Content-Disposition: form-data; name=\"%@\"", key];
    [bodyStr appendFormat:@"\r\n\r\n"];
    [bodyStr appendFormat:@"%@\r\n", value];
  }
  
  //.pic ---- 图片
  [bodyStr appendFormat:@"--%@\r\n", Boundary]; // \n 换行，\r 切换到行首
  [bodyStr
   appendFormat:
   @"Content-Disposition: form-data; name=\"pic\"; filename=\"file\""];
  [bodyStr appendFormat:@"\r\n"];
  [bodyStr appendFormat:@"Content-Type: application/octet-stream"];
  [bodyStr appendFormat:@"\r\n\r\n"];
  
  NSData *startData = [bodyStr dataUsingEncoding:NSUTF8StringEncoding];
  [bodyData appendData:startData];
  
  //(2)pic
  //图片数据添加
  [bodyData appendData:formData];
  
  //(3)--str--
  NSString *endStr = [NSString stringWithFormat:@"\r\n--%@--\r\n", Boundary];
  NSData *endData = [endStr dataUsingEncoding:NSUTF8StringEncoding];
  [bodyData appendData:endData];
  
  return bodyData;
  
}



// POST+GET
+ (void)requestWithURL:(NSString *)url
            httpMethod:(NSString *)method
            parameters:(NSMutableDictionary *)params
          headerFields:(NSMutableDictionary *)header
              formData:(NSData *)formData
      complectionBlock:(ComplectionBlock)block {
}
@end

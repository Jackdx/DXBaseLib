//
//  DXCommonApiStudy.m
//  DXBaseLib
//
//  Created by 邓翔 on 2020/3/31.
//

#import "DXCommonApiStudy.h"

@implementation DXCommonApiStudy

- (void)studyApi
{
#if 0
    // 字符串NSString 的分割与拼接
    NSString *str = nil;
    NSArray *arr = @[@1,@2];
    [str componentsSeparatedByString:@"-"]; // 字符串根据特殊字符分割。
    NSString *joinedString = [arr componentsJoinedByString:@"+"];
    NSLog(@"joinedString=%@",joinedString);
#endif
    
#if 0
    // 文件操作NSFileManager、NSFileHandle的使用
    NSFileManager *file = [NSFileManager defaultManager];
    NSString *path = @"/Users/dx/test/aa";
    // 文件、目录创建
    BOOL bval = [file fileExistsAtPath:path]; // 文件是否存在
    bval = [file createFileAtPath:path contents:nil attributes:nil];
    bval = [file createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    // 浅度、深度遍历
    NSArray *arr = [file contentsOfDirectoryAtPath:path error:nil];
    arr = [file subpathsOfDirectoryAtPath:path error:nil];
    // 拷贝、移动、删除 文件属性
    bval = [file copyItemAtPath:path toPath:@"" error:nil];
    bval = [file moveItemAtPath:path toPath:@"" error:nil];
    bval = [file removeItemAtPath:path error:nil];
    NSDictionary *dic = [file attributesOfItemAtPath:path error:nil];
    NSLog(@"%@",dic);
    NSLog(@"filesize=%lld",[dic fileSize]);
#endif
    
#if 0
    // NSFileHandle 的常用方法
    NSString *path = @"/Users/dx/test/aa";
    NSFileHandle *handle = [NSFileHandle fileHandleForUpdatingAtPath:path];
    NSData *data;
    data = [handle readDataOfLength:6];
    data = [handle readDataToEndOfFile];
    [handle seekToFileOffset:0];//偏移到起始位置
    [handle seekToEndOfFile];//偏移到文件末尾
    [handle writeData:data];
#endif
    
#if 0
    // 字符串和NSData的相互转换
    NSData *data = [@"abc" dataUsingEncoding:NSUTF8StringEncoding]; // 字符串转换为NSData
    NSLog(@"data=%@",data); // @"a"转化为NSData为0x61(十进制是97) NSData是字符对应的ascii码
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"str=%@",str);
#endif
   
}

@end

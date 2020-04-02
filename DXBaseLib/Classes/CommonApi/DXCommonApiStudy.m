//
//  DXCommonApiStudy.m
//  DXBaseLib
//
//  Created by 邓翔 on 2020/3/31.
//

#import "DXCommonApiStudy.h"

//NSString *const XXXNotification = @"XXXNotification";

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
    
#if 0
    // 代码计算字符串高度
   NSString *info = @"但是公司的高度是广东省公司的广东省高速度来开个大帅哥多撒谎个爱好就跟他说噶三公司噶是的刚好是我哥如果黑暗如果坏都干撒降低公司及嘎斯进欧冠赛欧结果就赛欧国际韶关；可垃圾费；阿尔加两块；三个身高萨嘎干撒的公司的高度上收到公司的公司都给ID搜狗破is打个屁偶是东莞IP手动皮革是滴哦苹果是滴哦苹果度搜皮为欧公司的漂漂是第三个是干撒噶是的噶虽然刚撒旦个撒公司的公司的高度";
    CGFloat strWidth = 200;
    CGSize infoSize = CGSizeMake(strWidth, MAXFLOAT);
    NSDictionary *dic = @{NSFontAttributeName : [UIFont systemFontOfSize:17.f ]};
      //默认的
    CGRect infoRect =   [info boundingRectWithSize:infoSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
      // 参数1: 自适应尺寸,提供一个宽度,去自适应高度
      // 参数2:自适应设置 (以行为矩形区域自适应,以字体字形自适应)
      // 参数3:文字属性,通常这里面需要知道是字体大小
      // 参数4:绘制文本上下文,做底层排版时使用,填nil即可
    ceil(infoRect.size.height);
#endif
   
}

@end

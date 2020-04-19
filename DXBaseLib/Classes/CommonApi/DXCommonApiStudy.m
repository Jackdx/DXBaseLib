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
#if 0
    // 沙盒路径
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSLog(@"%@",path);
    // 第2种方法  得到沙盒路径
    NSString *path1 = NSHomeDirectory();
    path1 = [path1 stringByAppendingPathComponent:@"Documents"];
    NSLog(@"%@",path1);
    
#endif
#if 0
//  UIViewController的 automaticallyAdjustsScrollViewInsets属性。iOS11废弃了
//    现在用UIScrollView的contentInsetAdjustmentBehavior代替
    /**
     automaticallyAdjustsScrollViewInsets的设置只对滚动视图有效，对普通的view无效；对普通view而言，UINavigationBar与UITabBar半透明(translucent)：会被遮挡；不透明，不会被遮挡。如果两个都是默认情况下，则滚动视图的内容不会被遮挡，普通的view会被遮挡，这是最常见的情况。
     */
#endif
#if 0
    // afn上传图片的方法使用
    [manager POST:urlPath parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
      [formData appendPartWithFileData:imageData
            name:name
        fileName:name
        mimeType:@"image/jpeg"];
    } progress:nil success:nil failure:nil];
#endif
#if 0
    // 网络判断检测代码
    //开启检测
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if(status == AFNetworkReachabilityStatusReachableViaWWAN || status == AFNetworkReachabilityStatusReachableViaWiFi)
        {
            NSLog(@"有网");
        }
        else if(status == AFNetworkReachabilityStatusNotReachable)
        {
            NSLog(@"无网");
        }
    }];
    // 网络状态变更的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkStatusChange:) name:AFNetworkingReachabilityDidChangeNotification object:nil];
    BOOL isReachable = [AFNetworkReachabilityManager sharedManager].isReachable;
    
    
#endif
    
#if 0
    // 键盘处理
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
#endif
#if 0
    // transform
    UIView *view;
    view.transform = CGAffineTransformMakeTranslation(100, 100);
    view.transform = CGAffineTransformMakeScale(0.5, 0.5);
    view.transform = CGAffineTransformMakeRotation(M_PI_2);
    CGAffineTransform transform = CGAffineTransformMakeTranslation(100, 100);
    CGAffineTransform scaleTransform = CGAffineTransformScale(transform, 0.5, 0.5);
    CGAffineTransformIdentity;
#endif
}

#if 0
- (void)layoutSubviews
{
    [super layoutSubviews];
    // 图片在上，文字在下的按钮效果
    CGFloat buttonW = self.frame.size.width;
    CGFloat buttonH = self.frame.size.height;
    
    CGFloat imageH = buttonW - 10;
    self.imageView.frame = CGRectMake(0, 0, buttonW, imageH);
    self.titleLabel.frame = CGRectMake(0, imageH, buttonW, buttonH - imageH);
}
#endif

#if 1
- (void)keyboardWillChangeFrame:(NSNotification *)note
{
    // 取出键盘最终的frame
    CGRect rect = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    // 取出键盘弹出需要花费的时间
    double duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    // 偏移值
    double offset_y = [UIScreen mainScreen].bounds.size.height - rect.size.height;
    [UIView animateWithDuration:duration animations:^{
        UIView *view;
        view.transform = CGAffineTransformMakeTranslation(0, -offset_y);
    }];
    
    UIView *theView;
    UIView *selfView;
     CGFloat theView_maxY = CGRectGetMaxY(theView.frame);
    if (theView_maxY > rect.origin.y) // 判断控件是否被键盘遮挡
    {
        selfView.transform = CGAffineTransformMakeTranslation(0, -(theView_maxY-rect.origin.y));
    }
}
#endif

@end

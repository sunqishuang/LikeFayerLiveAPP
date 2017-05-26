//
//  SUNTools.m
//  category
//
//  Created by zxy on 2017/5/24.
//  Copyright © 2017年 SunQishuang. All rights reserved.
//

#import "SUNTools.h"
#import <objc/runtime.h>

#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

@implementation SUNTools


#pragma mark ---------------------------------------------- 关于做非空判断和操作

/** 判断集合对象是不是空 */
+ (BOOL)SetValueIsNotNull:(id)value{
    if (value == nil) {
        return NO;
    }
    
    NSString *str = [NSString stringWithFormat:@"%@",value];
    if ([str isEqualToString:@"(null)"] || [str isEqualToString:@"<null>"]) {
        return NO;
    }
    
    return YES;
}

/** 字符串,空值返回空字符串,非空返回本身 */
+ (NSString *)ValueIsNotNull:(id)value{
    if (value == nil) {
        return @"";
    }
    NSString *str = [NSString stringWithFormat:@"%@",value];
    if ([str isEqualToString:@"(null)"] || [str isEqualToString:@"<null>"]) {
        return @"";
    }
    
    return str;
    
}

/** 如果字符串为空,返回0 */
+ (NSString *)ValueNullISZero:(id)value{
    if (value == nil) {
        return @"0";
    }
    NSString *str = [NSString stringWithFormat:@"%@",value];
    if ([str isEqualToString:@"(null)"] || [str isEqualToString:@"<null>"] || [str isEqualToString:@""]) {
        return @"0";
    }
    
    return str;
}





#pragma mark ---------------------------------------------- 关于时间戳,date和字符串的转化


/** 传入一个时间,获得时间戳 */
+ (NSString *)getDate:(NSDate *)date
{
    
    NSTimeInterval time = [date timeIntervalSince1970];
    
    NSString *timeStr = [NSString stringWithFormat:@"%lld",(long long)time];
    
    
    return timeStr;
}

/** 传入一个时间字符串,获得时间戳 */
+ (NSString *)getTimeIntervalWithDateString:(NSString *)dateStr AndDateFormatter:(NSString *)formatter{
    NSDateFormatter *dateFormtter = [[NSDateFormatter alloc] init];
    [dateFormtter setDateFormat:formatter];
    NSDate *date = [dateFormtter dateFromString:dateStr];
    NSTimeInterval time = [date timeIntervalSince1970];
    NSString *timeStr = [NSString stringWithFormat:@"%lld",(long long)time];
    return timeStr;
    
}



/** 传入date和格式,获得字符串时间 */
+(NSString *)getDateStringWithDate:(NSDate *)date formatString:(NSString *)strFormat{
    NSDateFormatter *dateF = [[NSDateFormatter alloc]init];
    [dateF setDateFormat:strFormat];
    NSString *dateStr = [dateF stringFromDate:date];
    return dateStr;
}


/** 传入一个时间戳,获取时间字符串*/
+ (NSString *)getDateStringWithTimeInterval:(NSString *)timeInterval AndDateFormtter:(NSString *)formtter{
    NSDate *date = [self GetDateWithTimeIntavel:timeInterval.longLongValue];
    
    return [self getDateStringWithDate:date formatString:formtter];
}

/** 传入字符串时间和时间格式获取  Date */
+ (NSDate *)getDateWithDateString:(NSString *)strDate formatString:(NSString*)strFormat{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    
    formatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:8 * 3600];
    
    [formatter setDateFormat : strFormat];
    
    NSDate *dateTime = [formatter dateFromString:strDate];
    
    //获取本地时区(中国时区)
    NSTimeZone* localTimeZone = [NSTimeZone localTimeZone];
    
    //计算世界时间与本地时区的时间偏差值
    NSInteger offset = [localTimeZone secondsFromGMTForDate:dateTime];
    
    //世界时间＋偏差值 得出中国区时间
    NSDate *localDate = [dateTime dateByAddingTimeInterval:offset];
    
    return localDate;
    
    //    return dateTime;
}

//传入一个时间戳,获取时间
+ (NSDate *)GetDateWithTimeIntavel:(NSTimeInterval)time{
    NSDate *date =  [NSDate dateWithTimeIntervalSince1970:time];
    
    return date;
}





//读取所有联系人
+(NSMutableDictionary*)ReadAllPeoples
{
    //取得本地通信录名柄
    ABAddressBookRef tmpAddressBook = nil;
    if ([[UIDevice currentDevice].systemVersion floatValue]>=6.0) {
        tmpAddressBook=ABAddressBookCreateWithOptions(NULL, NULL);
        dispatch_semaphore_t sema=dispatch_semaphore_create(0);
        ABAddressBookRequestAccessWithCompletion(tmpAddressBook, ^(bool greanted, CFErrorRef error){
            dispatch_semaphore_signal(sema);
        });
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    }
    else
    {
        tmpAddressBook =ABAddressBookCreateWithOptions;
    }
    if (tmpAddressBook==nil) {
        return nil ;
    };
    NSArray* tmpPeoples = (__bridge NSArray*)ABAddressBookCopyArrayOfAllPeople(tmpAddressBook);
    NSString *phone=@"";
    for(id tmpPerson in tmpPeoples)
    {
        if (phone.length>0) {
            phone=[phone stringByAppendingString:@"|"];
        }
        NSString* tmpFirstName = (__bridge NSString*)ABRecordCopyValue((__bridge ABRecordRef)(tmpPerson), kABPersonFirstNameProperty);
        //获取的联系人单一属性:Last name
        NSString* tmpLastName = (__bridge NSString*)ABRecordCopyValue((__bridge ABRecordRef)(tmpPerson), kABPersonLastNameProperty);
        if (tmpFirstName==nil) {
            tmpFirstName=@"";
        }if (tmpLastName==nil) {
            tmpLastName=@"";
        }
        NSString *userName=[tmpLastName stringByAppendingString:tmpFirstName];
        //获取的联系人单一属性:Generic phone number
        ABMultiValueRef tmpPhones = ABRecordCopyValue((__bridge ABRecordRef)(tmpPerson), kABPersonPhoneProperty);
        NSString* tmpPhoneIndex=@"";
        for(int j = 0; j < ABMultiValueGetCount(tmpPhones); j++)
        {
            if (j>0) {
                tmpPhoneIndex=[tmpPhoneIndex stringByAppendingString:@"#"];
            }
            NSString *tmpPhoneMid = (__bridge NSString*)ABMultiValueCopyValueAtIndex(tmpPhones, j);
            //            NSLog(@"tmpPhoneIndex%d:%@", j, tmpPhoneIndex);
            tmpPhoneMid = [tmpPhoneMid stringByReplacingOccurrencesOfString:@"-" withString:@""];
            tmpPhoneIndex=[tmpPhoneIndex stringByAppendingString:[NSString stringWithFormat:@"%@",tmpPhoneMid]];
        }
        phone=[phone stringByAppendingString:[NSString stringWithFormat:@"%@::%@",tmpPhoneIndex,userName]];
        CFRelease(tmpPhones);
    }
    CFRelease(tmpAddressBook);
    //    NSLog(@"%@",phone);
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    [param setObject:@"" forKey:@"group"];
    [param setObject:phone forKey:@"phone"];
    return param;
}



+ (void)PhoneCallTaskPhone:(NSString *)phone{
    
    
    if (phone == nil || [phone isEqualToString:@""]) {
        return;
    }
    
    NSString *phoneStr = [NSString stringWithFormat:@"%@",phone];
    if ([phoneStr isEqualToString:@"(null)"] || [phoneStr isEqualToString:@"<null>"] ) {
        return;
    }
    
    
    if ([[[UIDevice currentDevice] systemVersion] compare:@"10.2" options:NSNumericSearch] != NSOrderedAscending) {
        //大于等于10.2
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:nil message:phoneStr preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:
                                 UIAlertActionStyleCancel handler:nil];
        
        UIAlertAction *hujiao = [UIAlertAction actionWithTitle:@"呼叫" style:
                                 UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                                     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phoneStr]]];
                                 }];
        
        [alertC addAction:cancel];
        [alertC addAction:hujiao];
        UIWindow *window = [UIApplication sharedApplication].delegate.window;
        [window.rootViewController presentViewController:alertC animated:YES completion:nil];
        
    }else{
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",phone];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }
    
    
    
}



+ (void)BDLabel:(UILabel *)label AndtextChangeColor:(UIColor *)BDcolor ChangeFont:(UIFont *)BDfont StartPosition:(NSInteger )startIndex Length:(NSInteger)length{
    
    UIFont *font = BDfont != nil ? BDfont : label.font;
    UIColor *color = BDcolor != nil ? BDcolor : label.textColor;
    
    
    NSMutableAttributedString *changeColorStr = [[NSMutableAttributedString alloc]initWithString:label.text];
    /**
     *  改变某段字体的颜色
     *Index
     *  @param 0 看是下标
     *  @param 5 结束下标
     *
     *  @return
     */
    [changeColorStr addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(startIndex, length)];
    
    [changeColorStr addAttribute:NSFontAttributeName value:font range:NSMakeRange(startIndex, length)];
    label.attributedText = changeColorStr;
    
    [label sizeToFit];
    //     label.textAlignment = 2;
}



/**
 修改字符串中的字体和颜色,返回一个富文本
 
 @param string <#string description#>
 @param changedArray 需要修改的rang和颜色或者字体
 */
+ (NSMutableAttributedString *)BDString:(NSString *)string AndChangedColorOrFont:(NSMutableArray *)changedArray{
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:string];
    
    
    
    for (NSDictionary *dic in changedArray) {
        NSString *key =  dic.allKeys.lastObject;
        id object = [dic valueForKey:key];
        
        //使用,将key中的rang分割出来
        NSArray *keyArray = [key componentsSeparatedByString:@","];
        
        NSInteger position,length;
        
        if (keyArray.count != 2) {
            continue;
        }else{
            position = [keyArray[0] integerValue];
            length = [keyArray[1] integerValue];
            if (length <= 0) {
                continue;
            }else if (position + length > string.length) {
                //ranger越界,直接结束进行下一个循环,这个循环结束
                continue;
            }
        }
        
        
        if ([object isKindOfClass:[UIColor class]]) {
            //修改颜色
            
            [attr addAttribute:NSForegroundColorAttributeName value:(UIColor *)object range:NSMakeRange(position, length)];
            
        }else if ([object isKindOfClass:[UIFont class]]){
            //修改字体
            [attr addAttribute:NSFontAttributeName value:(UIFont *)object range:NSMakeRange(position, length)];
            
        }else{
            continue;
        }
        
    }
    
    
    return attr;
}



+ (void)tableViewEndrRefresh:(UITableView *)tableView{
    [tableView.mj_header endRefreshing];
    [tableView.mj_footer endRefreshing];
}
//
//+ (void)BD_NoMoreDataTableView:(nonnull UITableView *)tableView  DataSource:(nonnull NSArray *)dataSource pageNum:(NSInteger )pageNum{
//    
//    [self tableViewEndrRefresh:tableView];
//    if (dataSource.count && pageNum) {
//        
//        if (dataSource.count < pageNum * 10 ) {
//            
//            MJRefreshAutoFooter *gifFooter = (MJRefreshAutoFooter *)tableView.mj_footer;
//            gifFooter.state = MJRefreshStateNoMoreData;
//            
//        }
//        else{
//            [tableView.mj_footer resetNoMoreData];
//        }
//    }
//    
//    
//}


///遍历一个model的数组,取出model的某个属性,组成新的数组
+ (NSMutableArray *)getArrayForSuperModel:(NSMutableArray *)superModel WithPropertyName:(NSString *)propertyName{
    NSMutableArray *arr = [NSMutableArray array];
    for (id   objc in superModel) {
        [arr addObject:[objc valueForKey:propertyName]];
    }
    
    return arr;
}


@end

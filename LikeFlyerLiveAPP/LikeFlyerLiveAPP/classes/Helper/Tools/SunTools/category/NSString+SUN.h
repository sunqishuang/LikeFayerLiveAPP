//
//  NSString+SUN.h
//  category
//
//  Created by zxy on 2017/5/24.
//  Copyright © 2017年 SunQishuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (SUN)




#pragma mark ----------------------------------------------- NSString

/** 获取随机字符串 */
+ (instancetype)initWithRandomStringWithLength:(int) length;

/** 获取字符长度  */
- (int)getCharacterLength;

/** 去掉空格 */
-(NSString*)removeSpaceString;

/** 是否包含表情符 */
- (BOOL)stringContainsEmoji:(NSString *)string;

/** 是否是正确银行卡号 */
- (BOOL)isbankCardNo;

/** 是否是真实姓名 */
-(BOOL)isNameValid;

/** 身份证是否合法 */
-(BOOL) chk18PaperId;

/** 邮箱是否合法 */
- (BOOL)isValidateEmail;




/** 判断集合对象是不是空 */
+ (BOOL)SetValueIsNotNull:(id)value;

/** 字符串,空值返回空字符串,非空返回本身 */
+ (NSString *)ValueIsNotNull:(id)value;

/** 如果字符串为空,返回0 */
+ (NSString *)ValueNullISZero:(id)value;



#pragma mark ----------------------------------------------- NSDate

/** 传入字符串时间和时间格式获取  Date */
+ (NSDate *)getDateWithDateString:(NSString *)strDate formatString:(NSString*)strFormat;

/** 传入一个时间戳,获取时间 */
+ (NSDate *)GetDateWithTimeIntavel:(NSTimeInterval)time;





@end

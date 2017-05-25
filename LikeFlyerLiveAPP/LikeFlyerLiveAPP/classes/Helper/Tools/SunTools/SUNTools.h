//
//  SUNTools.h
//  category
//
//  Created by zxy on 2017/5/24.
//  Copyright © 2017年 SunQishuang. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@interface SUNTools : NSObject

#pragma mark ---------------------------------------------- 关于做非空判断和操作
/** 判断集合对象是不是空 */
+ (BOOL)SetValueIsNotNull:(id)value;

/** 字符串,空值返回空字符串,非空返回本身 */
+ (NSString *)ValueIsNotNull:(id)value;

/** 如果字符串为空,返回0 */
+ (NSString *)ValueNullISZero:(id)value;


#pragma mark ---------------------------------------------- 关于时间戳,date和字符串的转化


/** 传入一个时间,获得时间戳 */
+ (NSString *)getDate:(NSDate *)date;

/** 传入一个时间字符串,获得时间戳 */
+ (NSString *)getTimeIntervalWithDateString:(NSString *)dateStr AndDateFormatter:(NSString *)formatter;

/** 传入date和格式,获得字符串时间 */
+(NSString *)getDateStringWithDate:(NSDate *)date formatString:(NSString *)strFormat;

/** 传入一个时间戳,获取时间字符串*/
+ (NSString *)getDateStringWithTimeInterval:(NSString *)timeInterval AndDateFormtter:(NSString *)formtter;


/** 传入字符串时间和时间格式获取  Date */
+ (NSDate *)getDateWithDateString:(NSString *)strDate formatString:(NSString*)strFormat;

/** 传入一个时间戳,获取时间 */
+ (NSDate *)GetDateWithTimeIntavel:(NSTimeInterval)time;


/** 读取所有联系人 */
+(NSMutableDictionary*)ReadAllPeoples;

/** 拨打电话 */
+ (void)PhoneCallTaskPhone:( NSString*)phone;



/** 改变label字体或者颜色 */
+ (void)BDLabel:(UILabel *)label AndtextChangeColor:(UIColor *)BDcolor ChangeFont:(UIFont *)BDfont StartPosition:(NSInteger )startIndex Length:(NSInteger)length;

/** 修改字符串的字体和颜色 传入数组格式 @[@{@"1,5":[UIColor redColor]},@{@"6,3":[UIFont systemFontSize:16]}] */
+ (NSMutableAttributedString *)BDString:(NSString *)string AndChangedColorOrFont:(NSMutableArray *)changedArray;


/** 是否登录 */
+ (BOOL)isLogin;

/** 获取登录注册导航控制器 */
+ (UINavigationController *)getLoginNav;

/** 模态弹出登录注册 */
+ (void)presentLoginNav;

/** 结束刷新 */
+ (void)tableViewEndrRefresh:(UITableView *)tableView;

/** 判断分页数据是否加载完毕 */
+ (void)BD_NoMoreDataTableView:(nonnull UITableView *)tableView  DataSource:(nonnull NSArray *)dataSource pageNum:(NSInteger )pageNum;



#pragma mark ---------------------------------------------- 账户有关操作
/** 更新用户数据 */
+ (void)uploadUserInfoWithParmers:(NSDictionary *)dict;

/** 用户退出登录后,清空用户数据 */
+ (void)removeUserInfoAfterLogOut;


///遍历一个model的数组,取出model的某个属性,组成新的数组
+ (NSMutableArray *)getArrayForSuperModel:(NSMutableArray *)superModel WithPropertyName:(NSString *)propertyName;

@end

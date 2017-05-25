//
//  BDSegmentView.h
//  BDSegment
//
//  Created by apple on 16/3/21.
//  Copyright © 2016年 hongbao. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 选中栏样式
 */

typedef enum {
    /**  线条样式*/
    BDSegmentLineStyle = 0,
    /**  矩形样式*/
    BDSegmentRectangleStyle,
    /**  文字样式*/
    BDSegmentTextStyle
    
} BDSegmentStyle;


/**
 *  segment类
 */

@interface BDSegmentView : UIScrollView



/**  所有分类  */
@property (nonatomic, strong) NSMutableArray *allItemTitleS;
/**     标题字体            */
@property (nonatomic, strong) UIFont *titleFont;

/**     当前选中索引           */
@property (nonatomic, assign) NSInteger selectedIndex;

/**      选中样式的颜色       */
@property (nonatomic, strong) UIColor *BDitemSelectedStylrColor;

/**      选中样式的宽度   */
@property (nonatomic, assign) CGFloat BDStylWidth;

/*      选中样式的宽度 */
@property (nonatomic, assign) CGFloat StyleViewHeight;
/**         选中字体的颜色   */
@property (nonatomic, strong) UIColor *BDitemSelectedTextColor;
/**       字体默认为黑色    */
@property (nonatomic, strong) UIColor *BDitemColor;

/**      文字格式  每个item  中间的闲 的线的颜色      */
@property (nonatomic, strong) UIColor *BDLineColor;

/**       */
@property (nonatomic, assign) BOOL StyleViewMasksToBounds;
/**   矩形样式的圆角弧度    */
@property (nonatomic, assign) CGFloat BDStyleViewCornerRadius;

/**   底部线条是否与文本长度相同    */
@property (nonatomic, assign) BOOL isEqualToTextLength;
/**   需要显示红点的按钮索引集合(里面数NSString)    */
@property (nonatomic, strong) NSArray <NSString *>*redDotArray;

/** 店长需要显示红点的按钮索引集合*/
 @property (nonatomic, strong) NSArray <NSString *>*storeMsgRedDotArray;
/**
 *  每项点击事件
 itemName 点击项目的名字
 itemName 索引下标
 */
@property (nonatomic, copy) void (^BDItemClickBlock)(NSString *itemName, NSInteger itemIndex);




+ (BDSegmentView *)BDsegmentWithFrame:(CGRect)frame style:(BDSegmentStyle)style;

/**
 *  根据索引出发点击事件
 *
 *  @param index 索引下标
 */
- (void)BDitemClickByIndex:(NSInteger)index;








@end


@interface BDSegmentButt : UIButton

@property (nonatomic, assign) BOOL hasRedDot;

@end

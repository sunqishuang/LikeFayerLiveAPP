//
//  BDSegmentView.m
//  BDSegment
//
//  Created by apple on 16/3/21.
//  Copyright © 2016年 hongbao. All rights reserved.
//

#import "BDSegmentView.h"

#define BD_ItemFontSize 14.0f

#define BD_ItemMargin 5.0f

#define BD_ItemPadding 8.0f


@interface BDSegmentView ()
/**   分段选择的样式  */
@property (nonatomic, assign) BDSegmentStyle segmentStyle;

@property (nonatomic, strong) NSMutableArray *ItemButtonS;

@property (nonatomic, strong) UIView *StyleView;

/**     选中的button    */
@property (nonatomic, strong) BDSegmentButt *selecteButton;

@property (nonatomic, strong) NSMutableArray *itemArray;

@property (nonatomic, strong) NSMutableArray *BDLineS;

/**   选中button的样式  的尺寸     */
@property (nonatomic, assign) CGFloat StyleViewY;
@property (nonatomic, assign) CGFloat styleViewX;

@property (nonatomic, assign) CGFloat total_with;


@end



@implementation BDSegmentView


#pragma mark *********  初始化

/**
 ************************************************************************************************
 */

-(instancetype)init{
    self = [super init];
    if (self) {
        self.segmentStyle = BDSegmentLineStyle;
        [self initWithBDSegmentView];
        
        
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.segmentStyle = BDSegmentLineStyle;
        [self initWithBDSegmentView];
        
    }
    return self;
}



-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.segmentStyle = BDSegmentLineStyle;
        [self initWithBDSegmentView];
        
    }
    return self;
    
}


- (instancetype)initWithBDSegmentFrame:(CGRect)frame style:(BDSegmentStyle)style Total_With:(CGFloat )Total_With{
    if ([super initWithFrame:frame]) {
        
        _total_with = Total_With;
        
        self.segmentStyle = *(&(style));
        [self initWithBDSegmentView];
        
    }
    return self;
}


+ (BDSegmentView *)BDsegmentWithFrame:(CGRect)frame style:(BDSegmentStyle)style{
    return [[BDSegmentView alloc]initWithBDSegmentFrame:frame style:style Total_With:frame.size.width];
}



/**
 *  初始化View
 */

- (void)initWithBDSegmentView{
    _ItemButtonS = [NSMutableArray array];
    _BDLineS = [NSMutableArray array];
    
    self.BDitemColor = [UIColor blackColor];
    
    self.bounces = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    
    self.styleViewX = 0;
    
    self.StyleView = [[UIView alloc]initWithFrame:CGRectMake(BD_ItemMargin, self.StyleViewY, 0, self.StyleViewHeight)];
    self.StyleView.layer.masksToBounds = self.StyleViewMasksToBounds;
//    self.StyleView.backgroundColor = [UIColor orangeColor];
    self.StyleView.clipsToBounds = YES;
    
    
    [self addSubview:self.StyleView];
      [self StyleViewFromSegmentStyle];
    
}






#pragma 私有的
#pragma mark  *******  样式view 赋值坐标点数值

- (void)StyleViewFromSegmentStyle {
    switch (self.segmentStyle) {
        case BDSegmentLineStyle:
            self.StyleViewY = self.frame.size.height - 2;
            self.StyleViewHeight = 4.0f;
            break;
        case BDSegmentRectangleStyle:
//            self.StyleView.alpha = 0.1;
            self.StyleViewY = 0;
            self.StyleViewHeight = self.frame.size.height;
            self.BDStyleViewCornerRadius = 3.0f;
            self.StyleViewMasksToBounds = YES;
            break;
        case BDSegmentTextStyle:
            self.StyleViewY = 0;
            self.StyleViewHeight = 0.0f;
            break;
    }
}

/**
 *  传入items的set方法
 */
- (void)setAllItemTitleS:(NSMutableArray *)allItemTitleS{
    
    if (!allItemTitleS || allItemTitleS.count == 0) {
        return;
    }
    
    
    _allItemTitleS = allItemTitleS;
//    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    for (int i = 0; i < self.subviews.count; i++) {
        if (self.subviews[i] != self.StyleView) {
            [self.subviews[i--] removeFromSuperview];
        }
    }
    
    if (_allItemTitleS && _allItemTitleS.count > 0) {
        
        for (int i = 0; i < _allItemTitleS.count; i++) {
            [self createItem:i];
 
        }
        
        self.contentSize = CGSizeMake((self.styleViewX) - BD_ItemMargin, 0);

    }
    
    
}



- (void)createItem:(int )index{
    CGFloat itemWith;
    if (_allItemTitleS.count <= 4) {
        itemWith = (self.frame.size.width / _allItemTitleS.count) - (BD_ItemMargin / _allItemTitleS.count);
    }else{
        itemWith = self.frame.size.width / 4;
    }
    
    
    BDSegmentButt *buttonItem = [BDSegmentButt buttonWithType:UIButtonTypeCustom];
//    buttonItem.backgroundColor = [UIColor redColor];
    
    buttonItem.frame = CGRectMake(self.styleViewX, 0, itemWith, self.frame.size.height - 2);
    buttonItem.titleLabel.font = [UIFont systemFontOfSize:BD_ItemFontSize];
    [buttonItem setTitle:_allItemTitleS[index] forState:UIControlStateNormal];
//    [buttonItem setTitleColor:self.BDitemColor forState:UIControlStateNormal];
    buttonItem.tag = index;
    [buttonItem addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
    [buttonItem setBackgroundImage:[BDSegmentView imageWithColor:[UIColor clearColor] andSize:buttonItem.frame.size] forState:UIControlStateNormal];
    if (index == 0) {
        self.selecteButton = buttonItem;
    }
    
    buttonItem.tag = index;
    [_ItemButtonS addObject:buttonItem];
    [self addSubview:buttonItem];
    self.styleViewX += (itemWith + BD_ItemMargin);
    
    self.StyleView.frame = CGRectMake(0, self.StyleViewY, buttonItem.frame.size.width, self.StyleViewHeight);
    
    if (self.isEqualToTextLength) {
        CGSize titleSize = [buttonItem.titleLabel.text sizeWithAttributes:[NSDictionary dictionaryWithObject:buttonItem.titleLabel.font forKey:NSFontAttributeName]];
        
        float titleWidth = titleSize.width;
        self.StyleView.center = CGPointMake(buttonItem.frame.origin.x+buttonItem.frame.size.width/2.0, self.StyleViewY + self.StyleViewHeight/2.0);
        self.StyleView.bounds = CGRectMake(0, 0, titleWidth, self.StyleViewHeight);
    }

    CGFloat buttonHeith = self.frame.size.height;
    
    
    if ((self.segmentStyle == BDSegmentTextStyle || self.segmentStyle == BDSegmentLineStyle) && index < (_allItemTitleS.count - 1)) {
        
        UIImageView *VerticalLine = [[UIImageView alloc]initWithFrame:CGRectMake(self.styleViewX - 3,buttonHeith / 4 , 1, buttonHeith / 2)];
        VerticalLine.backgroundColor = [UIColor clearColor];
        [self addSubview:VerticalLine];
        [_BDLineS addObject:VerticalLine];
    }
}


- (void)itemClick:(BDSegmentButt *)sender{
    
    self.selectedIndex = sender.tag;
//    if (self.selecteButton != sender) {
    
        [self.selecteButton setTitleColor:self.BDitemColor forState:UIControlStateNormal];
        [sender setTitleColor:self.BDitemSelectedTextColor forState:UIControlStateNormal];
        self.selecteButton = sender;
    
    
        if (self.BDItemClickBlock) {
            self.BDItemClickBlock(sender.titleLabel.text,sender.tag);
        }
        
        
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.StyleView.frame = CGRectMake(sender.frame.origin.x, self.StyleViewY, sender.frame.size.width, self.StyleViewHeight);
            if (self.segmentStyle == BDSegmentRectangleStyle) {
                self.StyleView.center = sender.center;
            }
            
            if (self.isEqualToTextLength) {
                CGSize titleSize = [sender.titleLabel.text sizeWithAttributes:[NSDictionary dictionaryWithObject:sender.titleLabel.font forKey:NSFontAttributeName]];
                float titleWidth = titleSize.width;
                self.StyleView.center = CGPointMake(sender.frame.origin.x + sender.frame.size.width/2.0, self.StyleViewY + self.StyleViewHeight/2.0);
                self.StyleView.bounds = CGRectMake(0, 0, titleWidth, self.StyleViewHeight);
            }
      
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.2 animations:^{
//                CGFloat buttonX = sender.frame.origin.x;
                CGFloat buttonCenterX = sender.center.x;
//                CGFloat buttonWidth = sender.frame.size.width;
                CGFloat scrollerWidth = self.contentSize.width;
                
                if (scrollerWidth > _total_with && buttonCenterX > _total_with / 2.0f && (scrollerWidth - buttonCenterX) > _total_with / 2.0f ) {//移动至中间
                    self.contentOffset = CGPointMake(buttonCenterX - _total_with / 2.0f, 0);
                }else if (buttonCenterX < _total_with / 2.0f){//移动到最前面
                    self.contentOffset = CGPointMake(0, 0);
                }else if ((scrollerWidth - buttonCenterX) < _total_with / 2.0f){//移动到最后面
                    self.contentOffset = CGPointMake(scrollerWidth - _total_with, 0);
                }
            }];
        }];
        
//    }else{
//        NSLog(@"点击的是一选中的item");
//        
//    }
    
}

#pragma mark  ******  根据索引出发单击事件
- (void)BDitemClickByIndex:(NSInteger)index{
    
    if (_ItemButtonS.count == 0 || index < 0 || index >= _ItemButtonS.count) {
        return;
    }
    BDSegmentButt *clickButton = (BDSegmentButt *)_ItemButtonS[index];
    [self itemClick:clickButton];
    
}

- (void)setBDitemColor:(UIColor *)BDitemColor{
    _BDitemColor = BDitemColor;
    for (int i = 0; i < _ItemButtonS.count; i++) {
        if (i == 0) {
//            return;
        }else {
            BDSegmentButt *button = (BDSegmentButt *)_ItemButtonS[i];
            [button setTitleColor:_BDitemColor forState:UIControlStateNormal];
        }
    }
    
}

/**
 *  选中样式的颜色 
 */
- (void)setBDitemSelectedStylrColor:(UIColor *)BDitemSelectedStylrColor{
    _BDitemSelectedStylrColor = BDitemSelectedStylrColor;
    self.StyleView.backgroundColor = _BDitemSelectedStylrColor;
}

/**
 *  选中字体的颜色
 */
- (void)setBDitemSelectedTextColor:(UIColor *)BDitemSelectedTextColor{
    _BDitemSelectedTextColor = BDitemSelectedTextColor;

    [self.selecteButton setTitleColor:_BDitemSelectedTextColor forState:UIControlStateNormal];
    
    
}

/**
 *  圆角弧度
 */
- (void)setBDStyleViewCornerRadius:(CGFloat)BDStyleViewCornerRadius{
    _BDStyleViewCornerRadius = BDStyleViewCornerRadius;
    self.StyleView.layer.cornerRadius = _BDStyleViewCornerRadius;
}

- (void)setTitleFont:(UIFont *)titleFont{
    for (int i = 0; i < self.ItemButtonS.count; i++) {
        BDSegmentButt *button = (BDSegmentButt *)self.ItemButtonS[i];
        button.titleLabel.font = titleFont;
    }
}

- (void)setBDLineColor:(UIColor *)BDLineColor{
    _BDLineColor = BDLineColor;
    for (UIImageView *lineImg in _BDLineS) {
        lineImg.backgroundColor = _BDLineColor;
    }
}

- (void)setBDStylWidth:(CGFloat)BDStylWidth{
    CGRect frame = self.StyleView.frame;
    frame.size.width = BDStylWidth;
    self.StyleView.frame = frame;
}



- (void)setStyleViewHeight:(CGFloat)StyleViewHeight{
    _StyleViewHeight = StyleViewHeight;
    CGRect frame = self.StyleView.frame;
    frame.size.height = StyleViewHeight;
    self.StyleView.frame = frame;
    
    self.StyleView.center = CGPointMake(self.StyleView.center.x, self.center.y);
    
}




- (void)setRedDotArray:(NSArray<NSString *> *)redDotArray{
    _redDotArray = redDotArray;
    for (int i = 0; i < 4; i ++) {
        BDSegmentButt *butt = _ItemButtonS[i];
        NSString * ishave = redDotArray[i];
        if ([ishave isEqualToString:@"1"]) {
            butt.hasRedDot = YES;
        }else{
            butt.hasRedDot = NO;
        }
    }
}

- (void)setStoreMsgRedDotArray:(NSArray<NSString *> *)storeMsgRedDotArray
{
    _storeMsgRedDotArray = storeMsgRedDotArray;

    for (int i = 0; i < 2; i ++) {
        BDSegmentButt *butt = _ItemButtonS[i];
        NSString * ishave = storeMsgRedDotArray[i];
        if ([ishave isEqualToString:@"1"]) {
            butt.hasRedDot = YES;
        }else{
            butt.hasRedDot = NO;
        }
    }
}
/**
 *  根据颜色返回有一张图片
 *
 *  @param color 颜色
 *  @param size  图片尺寸
 *
 *  @return 返回图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size
{
    UIImage *img = nil;
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,
                                   color.CGColor);
    CGContextFillRect(context, rect);
    
    img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    
    return img;
}

- (void)setIsEqualToTextLength:(BOOL)isEqualToTextLength{
    _isEqualToTextLength = isEqualToTextLength;
    if (self.isEqualToTextLength) {
        NSString *title = _allItemTitleS[0];
        CGSize titleSize = [title sizeWithAttributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:17] forKey:NSFontAttributeName]];
       
        float titleWidth = titleSize.width;
        self.StyleView.bounds = CGRectMake(0, 0, titleWidth, self.StyleViewHeight);
    }
    
}

@end


@interface BDSegmentButt (){
    UILabel *_redDotLabel;
}

@end

@implementation BDSegmentButt

- (void)setHasRedDot:(BOOL)hasRedDot{
    _hasRedDot = hasRedDot;
    if (hasRedDot) {
        if (!_redDotLabel) {
            _redDotLabel = [[UILabel alloc] init];
            CGSize size = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font}];
            _redDotLabel.center = CGPointMake(self.bounds.size.width/2.0 + size.width/2.0 + 2, 7);
            _redDotLabel.bounds = CGRectMake(0, 0, 6, 6);
            _redDotLabel.backgroundColor = [UIColor redColor];
            _redDotLabel.layer.cornerRadius = _redDotLabel.bounds.size.width/2.0;
            _redDotLabel.clipsToBounds = YES;
            [self addSubview:_redDotLabel];
        }
    }else{
        if (_redDotLabel) {
            [_redDotLabel removeFromSuperview];
        }
    }
}

@end

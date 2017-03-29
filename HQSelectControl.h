//
//  HQSelectControl.h
//
//  Created by babyrabbit on 2017/3/28.
//  Copyright © 2017年 胡忠立. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HQSelectControl;

#define TEXT_COLOR_NORMAL               [UIColor lightGrayColor]
#define DEFUALT_COLOR                   [UIColor whiteColor]
#define SELECTED_COLOR                  [UIColor redColor]
#define DEFUALT_FONT                    [UIFont systemFontOfSize:13]
#define SELECTED_FONT                   [UIFont systemFontOfSize:14]

//回调Block
typedef void(^tapCompeletBlock)(HQSelectControl* control, NSInteger inde);

@interface HQSelectControl : UIScrollView

@property (nonatomic,assign,readonly)CGFloat width;/**格子宽度*/
@property (nonatomic,assign,readonly)CGFloat height;/**格子高宽，为self的高度减2像素高度*/
@property (nonatomic,assign)NSInteger currentIndex;/**当前选中下标*/
@property (nonatomic,strong)NSMutableArray* ary_dataSource;/**数据源*/

@property (nonatomic,strong)UIColor* color_textColor_selected;/**选中格子字体颜色*/
@property (nonatomic,strong)UIColor* color_textColor_normal;/**默认格子字体颜色*/
@property (nonatomic,strong)UIColor* color_backGorudColor_selected;/**选中格子背景颜色*/
@property (nonatomic,strong)UIColor* color_backGorudColor_normal;/**默认格子背景颜色*/
@property (nonatomic,strong)UIColor* color_slipColor;/**下划线颜色*/
@property (nonatomic,strong)UIFont* font_textFont_selected;/**选中格子字体大小*/
@property (nonatomic,strong)UIFont* font_textFont_normal;/**默认格子字体大小*/

@property (nonatomic,strong)tapCompeletBlock compeletBlock;/**回调Block*/
/**
 初始化方法

 @param frame 坐标
 @param width 格子宽度
 @param datas 数据源
 @return self
 */
- (instancetype)initWithFrame:(CGRect)frame width:(CGFloat)width datas:(NSArray*)datas;

/**
 初始化方法

 @param frame 坐标
 @param datas 数据源
 @return self
 */
- (instancetype)initWithFrame:(CGRect)frame datas:(NSArray*)datas;

/**
 注：
 1.使用系统初始化方法创建，必须设置 _ary_dataSource 数据源。
 2.使用系统初始化方法创建，格子宽度为自适应宽度。
 */
@end

#pragma mark -- Button分类
@interface UIButton (HZLButton)

+ (UIButton*)hzl_initWithFrame:(CGRect)frame title:(NSString*)title titleColor:(UIColor*)titleColor clickBlock:(void(^)(id sender))finish;

@end

#pragma mark -- Button点击响应Block分类
//Button点击事件响应Block
typedef void(^hzl_touchFinishBlock)(id sender);

@interface UIButton (HZLButtonBlock)

//Button点击事件响应方法
- (void)hzl_addButtonClickBlock:(hzl_touchFinishBlock)finish;
@end

#pragma mark --Frame category
@interface UIView (HZLFrame)
@property (nonatomic,readwrite)CGFloat hzl_left;/**左边*/
@property (nonatomic,readwrite)CGFloat hzl_height;/**高度*/
@property (nonatomic,readwrite)CGFloat hzl_width;/**宽度*/
@end

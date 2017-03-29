//
//  HQSelectControl.m
//  
//
//  Created by babyrabbit on 2017/3/28.
//  Copyright © 2017年 胡忠立. All rights reserved.
//

#import "HQSelectControl.h"
#import <objc/runtime.h>

#define HZL_WS(weakSelf)          __weak __typeof(&*self)weakSelf = self;
#define HZL_BUTTON_TAG            2000

@interface HQSelectControl()
{
    UIView* _slipView;
    UIButton* _btn_current;
}
@property (nonatomic,assign,readwrite)CGFloat width;

@end

@implementation HQSelectControl
@synthesize ary_dataSource = _ary_dataSource;

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = DEFUALT_COLOR;
        self.showsHorizontalScrollIndicator = NO;
        
        _height = frame.size.height - 2;
        _currentIndex = 0;
        _color_textColor_normal = TEXT_COLOR_NORMAL;
        _color_textColor_selected = SELECTED_COLOR;
        _color_slipColor = SELECTED_COLOR;
        _color_backGorudColor_normal = DEFUALT_COLOR;
        _color_backGorudColor_selected = DEFUALT_COLOR;
        _font_textFont_normal = DEFUALT_FONT;
        _font_textFont_selected = SELECTED_FONT;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame width:(CGFloat)width datas:(NSArray *)datas
{
    if (self = [self initWithFrame:frame]) {
        _width = width;
        self.ary_dataSource = datas.mutableCopy;
        [self makeSlipView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame datas:(NSArray *)datas
{
    if (self = [self initWithFrame:frame]) {
        self.ary_dataSource = datas.mutableCopy;
        [self makeSlipView];
    }
    return self;
}

#pragma mark --画下面选中线
- (void)makeSlipView
{
    _slipView = [[UIView alloc]initWithFrame:CGRectMake(0, _height, _width, 2)];
    _slipView.backgroundColor = _color_slipColor;
    [self addSubview:_slipView];
    [self addSubview:[self creatLineFromHorizontalOriginX:0 originY:self.hzl_height - 0.5]];
}

#pragma mark -- Getter Method
- (NSMutableArray*)ary_dataSource
{
    if (!_ary_dataSource) {
        _ary_dataSource = [NSMutableArray array];
    }
    return _ary_dataSource;
}

#pragma mark -- Setter Mehtod
- (void)setAry_dataSource:(NSMutableArray *)ary_dataSource
{
    _ary_dataSource = ary_dataSource;
    [self refreshView];
}

- (void)setColor_textColor_normal:(UIColor *)color_textColor_normal
{
    _color_textColor_normal = color_textColor_normal;
    [_ary_dataSource enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton* b = (UIButton*)[self viewWithTag:idx + HZL_BUTTON_TAG];
        [b setTitleColor:_color_textColor_normal forState:UIControlStateNormal];
    }];
}

- (void)setColor_textColor_selected:(UIColor *)color_textColor_selected
{
    _color_textColor_selected = color_textColor_selected;
}

- (void)setColor_backGorudColor_normal:(UIColor *)color_backGorudColor_normal
{
    _color_backGorudColor_normal = color_backGorudColor_normal;
    [_ary_dataSource enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton* b = (UIButton*)[self viewWithTag:idx + HZL_BUTTON_TAG];
        b.backgroundColor = _color_backGorudColor_normal;
    }];
}

- (void)setColor_backGorudColor_selected:(UIColor *)color_backGorudColor_selected
{
    _color_backGorudColor_selected = color_backGorudColor_selected;
}

- (void)setFont_textFont_normal:(UIFont *)font_textFont_normal
{
    _font_textFont_normal = font_textFont_normal;
    [_ary_dataSource enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton* b = (UIButton*)[self viewWithTag:idx + HZL_BUTTON_TAG];
        b.titleLabel.font = _font_textFont_normal;
    }];
}

- (void)setFont_textFont_selected:(UIFont *)font_textFont_selected
{
    _font_textFont_selected = font_textFont_selected;
    [self setDefualtStatus];
}

- (void)setColor_slipColor:(UIColor *)color_slipColor
{
    _color_slipColor = color_slipColor;
    _slipView.backgroundColor = _color_slipColor;
}

- (void)setCurrentIndex:(NSInteger)currentIndex
{
    _currentIndex = currentIndex;
    [self setDefualtStatus];
}

- (void)setCompeletBlock:(tapCompeletBlock)compeletBlock
{
    _compeletBlock = compeletBlock;
}

- (void)setDefualtStatus
{
    UIButton* b = (UIButton*)[self viewWithTag:HZL_BUTTON_TAG + _currentIndex];
    [self action:b];
}

#pragma mark -- 视图方法
- (void)refreshView
{
    //清除子视图
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (![obj isKindOfClass:[_slipView class]])
            [obj removeFromSuperview];
    }];
    
    [self getWidth];
    
    HZL_WS(weakSelf)
    for (NSInteger i = 0; i < _ary_dataSource.count; i ++) {
        UIButton* button = [UIButton hzl_initWithFrame:CGRectMake(i * _width, 0, _width, _height) title:_ary_dataSource[i] titleColor:_color_textColor_normal clickBlock:^(id sender) {
            [weakSelf action:sender];
        }];
        button.titleLabel.font = _font_textFont_normal;
        [button setTitleColor:_color_textColor_selected forState:UIControlStateSelected];
        button.backgroundColor = _color_backGorudColor_normal;
        [self addSubview:button];
        button.tag = i + HZL_BUTTON_TAG;
    }
}

#pragma mark -- Button Click Method
- (void)action:(UIButton*)b
{
    _btn_current.selected = NO;
    _btn_current.titleLabel.font = _font_textFont_normal;
    _btn_current.backgroundColor = _color_backGorudColor_normal;
    
    //设置选中
    b.selected = YES;
    b.titleLabel.font = _font_textFont_selected;
    b.backgroundColor = _color_backGorudColor_selected;
    
    _btn_current = b;
    _currentIndex = b.tag - HZL_BUTTON_TAG;
    
    //文字滚动
    CGFloat centerX = b.center.x;
    CGFloat offsetX = centerX - self.hzl_width / 2;
    
    //左右限
    if (offsetX < 0)
        offsetX = 0;
    if (offsetX > self.contentSize.width - self.hzl_width)
        offsetX = self.contentSize.width - self.hzl_width;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.contentOffset = CGPointMake(offsetX, 0);
    }];
    
    //线条滚动
    [UIView animateWithDuration:0.2 animations:^{
        _slipView.hzl_left = b.hzl_left;
    }];
    
    if (_compeletBlock) {
        _compeletBlock(self,_currentIndex);
    }
}

#pragma mark -- 获取格子宽度
- (void)getWidth
{
    if (!_width) {
        [_ary_dataSource enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            CGFloat w = [self getCharactersWithString:obj font:_font_textFont_normal];
            if (_width < w)
                _width = w + 20;
        }];
    }
    
    if (_ary_dataSource.count * _width <= self.hzl_width)
        _width = self.hzl_width / _ary_dataSource.count;
    
    self.contentSize = CGSizeMake(_width * _ary_dataSource.count, _height);
    _slipView.hzl_width = _width;
}

#pragma mark -- 获取字符宽度
- (CGFloat)getCharactersWithString:(NSString*)string font:(UIFont *)font
{
    CGSize size = [string boundingRectWithSize:CGSizeMake(self.hzl_width, 20) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:font} context:NULL].size;
    return size.width;
}
#pragma mark -- 画线
- (UIView*)creatLineFromHorizontalOriginX:(CGFloat)x originY:(CGFloat)y
{
    UIView* lineView = [[UIView alloc]initWithFrame:CGRectMake(x, y, self.hzl_width, 0.5)];
    lineView.backgroundColor = [UIColor colorWithDisplayP3Red:222/255.0 green:222/255.0 blue:222/255.0 alpha:1.0];
    return lineView;
}

@end

#pragma mark -- Button分类
@implementation UIButton (HZLButton)

+ (UIButton*)hzl_initWithFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)titleColor clickBlock:(void (^)(id))finish
{
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn hzl_addButtonClickBlock:finish];
    return btn;
}

@end

#pragma mark -- Button点击响应Block分类
static const char hzl_btnKey;

@implementation UIButton (HZLButtonBlock)

- (void)hzl_addButtonClickBlock:(hzl_touchFinishBlock)finish
{
    if (finish)
        objc_setAssociatedObject(self, &hzl_btnKey, finish, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self addTarget:self action:@selector(hzl_actionClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)hzl_actionClick:(id)sender
{
    hzl_touchFinishBlock block = objc_getAssociatedObject(self, &hzl_btnKey);
    if (block)
        block(sender);
}

@end

#pragma mark --Frame category
@implementation UIView (HZLFrame)

#pragma mark --- setter Methods

- (void)setHzl_left:(CGFloat)hzl_left
{
    CGRect frame = self.frame;
    frame.origin.x = hzl_left;
    self.frame = frame;
}

- (void)setHzl_width:(CGFloat)hzl_width
{
    CGRect frame = self.frame;
    frame.size.width = hzl_width;
    self.frame = frame;
}

- (void)setHzl_height:(CGFloat)hzl_height
{
    CGRect frame = self.frame;
    frame.size.height = hzl_height;
    self.frame = frame;
}

#pragma mark --getter Methods

- (CGFloat)hzl_left
{
    return self.frame.origin.x;
}

- (CGFloat)hzl_width
{
    return self.frame.size.width;
}

- (CGFloat)hzl_height
{
    return self.frame.size.height;
}

@end


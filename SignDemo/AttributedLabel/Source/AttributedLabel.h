/***********************************************************************************
 * This software is under the MIT License quoted below:
 ***********************************************************************************
 *
 * Copyright (c) 2010 Olivier Halligon
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 ***********************************************************************************/


#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>
#import "NSAttributedString+Attributes.h"
#import "NSTextCheckingResult+ExtendedURL.h"


/////////////////////////////////////////////////////////////////////////////////////
#pragma mark - OHAttributedLabel Delegate Protocol
/////////////////////////////////////////////////////////////////////////////////////

@class AttributedLabel;
@protocol AttributedLabelDelegate <NSObject>
@optional


/**
 *  选中文字的类型区分
 *
 *  @param linkInfo 内容
 *
 *  @return 类型
 */
//id objectForLinkInfo(NSTextCheckingResult* linkInfo)
//{
// Return the first non-nil property
//	return (id)linkInfo.URL ?: (id)linkInfo.phoneNumber ?: (id)linkInfo.addressComponents ?: (id)linkInfo.date ?: (id)[linkInfo description];
//}

/**
 *  选中文字的操作
 *
 *  @param attributedLabel AttributedLabel
 *  @param linkInfo        内容
 *
 *  @return 是否点击
 */
-(BOOL)attributedLabel:(AttributedLabel*)attributedLabel shouldFollowLink:(NSTextCheckingResult*)linkInfo;
//! @parameter underlineStyle Combination of CTUnderlineStyle and CTUnderlineStyleModifiers
/**
 *
 *
 *  @param attributedLabel attributedLabel
 *  @param linkInfo        内容
 *  @param underlineStyle  underlineStyle  下划线样式
 *
 *  @return 返回当前字体颜色
 */


-(UIColor*)attributedLabel:(AttributedLabel*)attributedLabel colorForLink:(NSTextCheckingResult*)linkInfo underlineStyle:(int32_t*)underlineStyle;
@end


/////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Constants
/////////////////////////////////////////////////////////////////////////////////////

// 居中对齐 匹配
extern const int NSTextAlignmentJustify
#if __IPHONE_OS_VERSION_MAX_ALLOWED < 60000
__attribute__((deprecated("You should use 'setTextAlignment:lineBreakMode:' on your NSAttributedString instead.")));
#else
__attribute__((unavailable("Since iOS6 SDK, you have to use 'setTextAlignment:lineBreakMode:' on your NSAttributedString instead.")));
#endif

/**
 *  枚举
 *
 *  @param _type 类型
 *  @param _name 名字
 *
 *  @return 枚举块
 */
#ifndef NS_OPTIONS
// For older compilers compatibility. But you should really update your Xcode and LLVM.
#define NS_OPTIONS(_type, _name) _type _name; enum _name
#endif

#pragma mark - 字体样式 16 进制
//! This flags are designed to be used with the linkUnderlineStyle property and the -attributedLabel:colorForLink:underlineStyle: delegate method
//! - If you bitwise-OR the linkUnderlineStyle with the kOHBoldStyleTraitSetBold constant, the bold attribute will be added to links in text
//! - If you bitwise-OR the linkUnderlineStyle with the kOHBoldStyleTraitUnSetBold constant, the bold attribute will be removed from links in text
//! - If you don't use these constants, the bold attribute of links will not be altered (so it will be bold if link was already in a bold text portion, non-bold if not)
typedef NS_OPTIONS(int32_t, OHBoldStyleTrait) {
    kOHBoldStyleTraitMask       = 0x030000,
    kOHBoldStyleTraitSetBold    = 0x030000,
    kOHBoldStyleTraitUnSetBold  = 0x020000,
};


@interface AttributedLabel : UILabel<UIAppearance>

@property (retain, nonatomic) NSMutableArray* images;
/**
 *  文本属性
 */
@property(nonatomic, copy) NSAttributedString* attributedText;
/**
 *  重新文本属性
 */
-(void)resetAttributedText;
/**
 *  重新建立链接,防止文本属性发生变化影响链接
 */
-(void)setNeedsRecomputeLinksInText;

/**
 *  链接类型 默认  NSTextCheckingTypeLink, + NSTextCheckingTypePhoneNumber if "tel:" URL scheme is supported.
 */
@property(nonatomic, assign) NSTextCheckingTypes automaticallyAddLinksForType;

/**
 *  得到文本内容中的所有链接
 Accessor to the NSDataDetector used to automatically detect links according to the automaticallyAddLinksForType property value.
 Useful for example to enumerate links outside of the OHAttributedLabel itself (to list the links in an ActionSheet and so on)
 */
@property(nonatomic, readonly) NSDataDetector* linksDataDetector;
/**
 *  链接颜色 默认颜色 [UIColor blueColor]
 */
@property(nonatomic, strong) UIColor* linkColor UI_APPEARANCE_SELECTOR;
/**
 *  链接选中颜色 默认颜色  [UIColor colorWithWhite:0.2 alpha:0.5]
 */
@property(nonatomic, strong) UIColor* highlightedLinkColor UI_APPEARANCE_SELECTOR;
/**
 *  设置下划线样式 CTUnderlineStyle and CTUnderlineStyleModifiers
 */
@property(nonatomic, assign) uint32_t linkUnderlineStyle UI_APPEARANCE_SELECTOR;
/**
 *
 *  设置链接的下划线
 *  @param underlineLinks  Yes CTUnderlineStyleSingle  NO CTUnderlineStyleNone(无样式)
 */
-(void)setUnderlineLinks:(BOOL)underlineLinks;

/**
 *  Add a link to some text in the label(添加链接)
 *
 *  @param linkUrl 链接地址
 *  @param range 匹配索引
 */

-(void)addCustomLink:(NSURL*)linkUrl inRange:(NSRange)range;
/**
 *  移除所有自动的链接
 */
-(void)removeAllCustomLinks;
/**
 *  链接是否能被点击，默认为Yes
 */
@property(nonatomic, assign) BOOL onlyCatchTouchesOnLinks;
/**
 *  代理
 */
@property(nonatomic, assign) id<AttributedLabelDelegate> delegate;

/**
 *  文本内容居中
 */
@property(nonatomic, assign) BOOL centerVertically;
/**
 *  填充其他元素比如（表情）
 */
@property(nonatomic, assign) BOOL extendBottomToFit;
@end

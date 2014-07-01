//
//  TestView.m
//  SignDemo
//
//  Created by ylang on 14-7-1.
//  Copyright (c) 2014年 ylang. All rights reserved.
//

#import "TestView.h"
#import "AttributedLabel.h"
#import "ASBasicHTMLParser.h"
#import "NSData+Base64.h"
#import "NSString+Base64.h"

@interface TestView ()<AttributedLabelDelegate>
{
    BOOL isTouch;
}
@property(strong,nonatomic)AttributedLabel *label;
@end

@implementation TestView
@synthesize highlightedLinkColor = _highlightedLinkColor;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.userInteractionEnabled = YES;
        _highlightedLinkColor = [UIColor colorWithWhite:0.4 alpha:0.3];
         _highlightedLinkColor = [UIColor redColor];
        [self addSubview:self.label];
    }
    return self;
}


- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        self.userInteractionEnabled = YES;
        _highlightedLinkColor = [UIColor colorWithWhite:0.4 alpha:0.3];
         _highlightedLinkColor = [UIColor redColor];
        [self addSubview:self.label];
    }
    
    return self;
}


- (AttributedLabel *)label
{
    if (!_label)
    {
        _label = [[AttributedLabel alloc] initWithFrame:CGRectMake(0, 0,self.frame.size.width, 60)];
        _label.centerVertically = YES;
        _label.automaticallyAddLinksForType = NSTextCheckingAllTypes;
        _label.delegate = self;
        NSMutableAttributedString* mas = [ASBasicHTMLParser attributedStringByProcessingMarkupInString:@"#111# 哈哈哈 <at>haha</at>themed @中国李sdfsdf appearances was 1983's Thriller, a Michael @Jackson short film and music video, #directed# by]John Landis.^^^ "];
        _label.attributedText = mas;
    }
    return _label;
}



-(BOOL)attributedLabel:(AttributedLabel *)attributedLabel shouldFollowLink:(NSTextCheckingResult *)linkInfo
{
    if ([[UIApplication sharedApplication] canOpenURL:linkInfo.extendedURL])
    {
        return YES;
    }
    else
    {
        NSString *s = [[linkInfo.extendedURL absoluteString] base64DecodedString];
//        NSString *s = [linkInfo.extendedURL absoluteString];
        NSLog(@"..........%@",s);
        return NO;
    }
}

-(void)drawActiveLinkHighlightForRect:(CGRect)rect
{
    if (!self.highlightedLinkColor)
    {
        return;
    }
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	CGContextSaveGState(ctx);
	CGContextConcatCTM(ctx, CGAffineTransformMakeTranslation(rect.origin.x, rect.origin.y));
	[self.highlightedLinkColor setFill];
    if (isTouch)
    {
        CGContextFillRect(ctx, rect);
    }
	CGContextRestoreGState(ctx);
}



- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    isTouch = YES;
    NSLog(@"....................................");
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
//    sleep(3);
     isTouch = NO;
    NSLog(@"....................................");
    [self setNeedsDisplay];
}


- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
//    isTouch = NO;
    [self setNeedsDisplay];
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.


- (void)drawRect:(CGRect)rect
{
    if (isTouch)
    {
            [self drawActiveLinkHighlightForRect:rect];
    }else
    {
        [super drawRect:rect];
    }
}

@end

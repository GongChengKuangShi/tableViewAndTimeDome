//
//  BillHeadView.m
//  MangoFinance
//
//  Created by 叶明君 on 16/7/27.
//  Copyright © 2016年 wim. All rights reserved.
//

#import "BillHeadView.h"

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

@interface BillHeadView ()

@property (nonatomic ,assign) BOOL select;



@end


@implementation BillHeadView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = UIColorFromRGB(0xF2F2EA);
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColorFromRGB(0xF2F2EA);
    }
    return self;
}


- (UILabel *)label {
    if (_label == nil) {
        _label = [[UILabel alloc] init];
        _label.font = [UIFont systemFontOfSize:13];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.textColor = UIColorFromRGB(0x666666);
        _label.frame = CGRectMake((SCREEN_WIDTH - 200) /2, 0, 200 , 44);
        [self addSubview:_label];
    }
    return _label;
}

- (UIImageView *)imageView {
    if (_imageView == nil) {
        UIImage *arrowImage = [UIImage imageNamed:@"profile_bill_navgation_down"];
        _imageView = [[UIImageView alloc] init];
        CGFloat imgX = SCREEN_WIDTH - arrowImage.size.width - 20;
        CGFloat imgY = (44 - arrowImage.size.height) / 2;
        CGFloat imgW = arrowImage.size.width;
        CGFloat imgH = arrowImage.size.height;
        _imageView.frame = CGRectMake( imgX , imgY  , imgW , imgH );
        _imageView.image = arrowImage;
        [self addSubview:_imageView];
    }
    return _imageView;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

@end

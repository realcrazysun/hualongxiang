//
//  DiscoverViewCell.m
//  hualongxiang
//
//  Created by polyent on 16/1/10.
//  Copyright © 2016年 crazysun. All rights reserved.
//

#import "DiscoverViewCell.h"
#import "UIView+Util.h"
#import "UIImageView+Util.h"
#import "UIColor+Wonderful.h"
@interface DiscoverViewCell()


@end

@implementation DiscoverViewCell

- (void)awakeFromNib {
    // Initialization code
    //    self.iconImage.layer.cornerRadius = 8;
    //    self.iconImage.clipsToBounds = YES;
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        [self setBorderWidth:0.5 andColor:[UIColor linenColor]];
        _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.frame)/4, CGRectGetWidth(self.frame)/4, CGRectGetWidth(self.frame)/2, CGRectGetWidth(self.frame)/2)];
        [self addSubview:_imgView];
        
        self.text = [[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(self.imgView.frame)+10, CGRectGetWidth(self.frame)-10, 20)];
        self.text.textAlignment = NSTextAlignmentCenter;
        self.text.font = [UIFont systemFontOfSize:13];
        [self addSubview:self.text];
    }
    return self;
}

-(void)setImgUrl:(NSString *)urlString{
    if (urlString) {
        NSURL* url = [NSURL URLWithString:urlString];
        [_imgView loadPortrait:url];
        [_imgView setCornerRadius:CGRectGetWidth(self.frame)/4];
        [_imgView setBorderWidth:0.5 andColor:[UIColor grayColor]];
    }else{
        _imgView.image = nil;
    }
}

@end

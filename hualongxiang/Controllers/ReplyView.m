//
//  ReplyView.m
//  hualongxiang
//
//  Created by polyent on 16/1/29.
//  Copyright © 2016年 crazysun. All rights reserved.
//

#import "ReplyView.h"
#import "UIColor+Wonderful.h"
#import "UIView+Util.h"
@interface ReplyView()
@property(nonatomic,strong)UIButton* likeBtn;
@property(nonatomic,strong)UILabel* replyNumLabel;

@end
@implementation ReplyView
-(instancetype)initWithFrame:(CGRect)frame liked:(BOOL)liked replyNums:(NSUInteger)replyNum{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteSmoke];
        _likeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _likeBtn.frame = CGRectMake(5, 10, 30, 30);
        if (liked) {
            [_likeBtn setImage:[UIImage imageNamed:@"icon_pai_already_zan"] forState:UIControlStateNormal];
        }else{
            [_likeBtn setImage:[UIImage imageNamed:@"icon_pai_zan_normal"] forState:UIControlStateNormal];
        }
        
        [_likeBtn addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_likeBtn];
        CGFloat containerX = CGRectGetMaxX(_likeBtn.frame)+5;
        UIView* container = [[UIView alloc] initWithFrame:CGRectMake(containerX, 8, frame.size.width - containerX - 5, 35)];
        container.backgroundColor = [UIColor whiteColor];
        [container setCornerRadius:4];
        [container setBorderWidth:1 andColor:[UIColor lightGrayColor]];
        [self addSubview:container];
        
        UILabel* label1 = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 60, container.frame.size.height)];
        label1.text = @"回复楼主";
        label1.textColor = [UIColor darkTextColor];
        label1.font = [UIFont systemFontOfSize:14];
        label1.alpha = 0.5;
        [container addSubview:label1];
        
        _replyNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(container.frame.size.width - 105,0,100,container.frame.size.height)];
        _replyNumLabel.text = [NSString stringWithFormat:@"已有%d条回复",replyNum];
        _replyNumLabel.textColor = [UIColor darkTextColor];
        _replyNumLabel.font = [UIFont systemFontOfSize:14];
        _replyNumLabel.textAlignment = NSTextAlignmentRight;
        _replyNumLabel.alpha = 0.5;
        [container addSubview:_replyNumLabel];
        
        UITapGestureRecognizer* recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickContainerView)];
        container.userInteractionEnabled = YES;
        [container addGestureRecognizer:recognizer];
        
    }
    return self;
}

-(void)setLiked:(BOOL)liked{
    if (liked) {
        [_likeBtn setImage:[UIImage imageNamed:@"icon_pai_already_zan"] forState:UIControlStateNormal];
    }else{
        [_likeBtn setImage:[UIImage imageNamed:@"icon_pai_zan_normal"] forState:UIControlStateNormal];
    }

}

-(void)clickBtn{
    
}

-(void)clickContainerView{
    self.hidden = YES;
    if (self.clickContainer) {
        self.clickContainer();
    }
}
@end

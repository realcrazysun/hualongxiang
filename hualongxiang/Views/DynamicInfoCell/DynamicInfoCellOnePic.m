//
//  DynamicInfoCellOnePic.m
//  hualongxiang
//
//  Created by polyent on 16/1/12.
//  Copyright © 2016年 crazysun. All rights reserved.
//

#import "DynamicInfoCellOnePic.h"
#import "UIImageView+Util.h"
#import "UIView+Util.h"
@implementation DynamicInfoCellOnePic
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        
        [self initSubviews];
        [self setLayout];
    }
    
    return self;
}

-(void)initSubviews{
    _titleLabel= [UILabel new];
    _titleLabel.numberOfLines = 2;
    _titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _titleLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_titleLabel];
    
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.numberOfLines = 1;
    _nameLabel.font = [UIFont systemFontOfSize:12];
    _nameLabel.alpha = 0.5;
    [self.contentView addSubview:_nameLabel];
    
    _readcountLabel = [UILabel new];
    _readcountLabel.numberOfLines = 1;
    _readcountLabel.font = [UIFont systemFontOfSize:12];
    _readcountLabel.alpha = 0.5;
    [self.contentView addSubview:_readcountLabel];
    
    _imgView = [UIImageView new];
    [self.contentView addSubview:_imgView];
}

-(void)setLayout{
    
    for (UIView *view in self.contentView.subviews) {view.translatesAutoresizingMaskIntoConstraints = NO;}
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_nameLabel, _titleLabel,_readcountLabel,_imgView);
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-8-[_titleLabel]-15-[_imgView(100)]-8-|"
                                                                             options:0
                                                                             metrics:nil views:views]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-8-[_nameLabel]-10-[_readcountLabel]|" options:NSLayoutFormatAlignAllTop metrics:nil views:views]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[_titleLabel]-10-[_nameLabel]->=8-|" options:NSLayoutFormatAlignAllLeft metrics:nil views:views]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-15-[_imgView(80)]->=1-|" options:NSLayoutFormatAlignAllLeft metrics:nil views:views]];

    
}

-(void)setImgUrl:(NSString *)urlString{
    if (urlString) {
        NSURL* url = [NSURL URLWithString:urlString];
        [_imgView loadPortrait:url];
//        [_imgView setBorderWidth:1 andColor:[UIColor grayColor]];
    }else{
        _imgView.image = nil;
    }
}

@end

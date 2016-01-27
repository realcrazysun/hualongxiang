//
//  ContactTableViewCell.m
//  hualongxiang
//
//  Created by polyent on 16/1/25.
//  Copyright © 2016年 crazysun. All rights reserved.
//

#import "ContactTableViewCell.h"
#import "Contact.h"
#import "UIView+Util.h"
#import "UIImageView+Util.h"
@interface ContactTableViewCell()
@property(nonatomic,strong)UIImageView* iconView;
@property(nonatomic,strong)UILabel* nameLabel;
@end
@implementation ContactTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _iconView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 50, 50)];
        [_iconView setCornerRadius:25];
        [self.contentView addSubview:_iconView];
        
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_iconView.frame)+5, 20, 200, 20)];
        [self.contentView addSubview:_nameLabel];
    }
    return self;
}
-(void)setData:(NSObject *)data{
    _data = data;
    if ([data isKindOfClass:[DyContact class]]) {
        [_iconView loadPortraitWithNSString:((DyContact *) data).avatar ];
        _nameLabel.text = ((DyContact *) data).nickname;
    }else if ([data isKindOfClass:[FixedContact class]]){
        [_iconView loadPortraitWithNSString:((FixedContact *) data).avatar ];
        _nameLabel.text = ((FixedContact *) data).nickname;
    }
}
@end

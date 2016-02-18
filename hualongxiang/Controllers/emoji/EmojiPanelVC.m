//
//  EmojiPanelVC.m
//  iosapp
//
//  Created by ChanAetern on 12/21/14.
//  Copyright (c) 2014 oschina. All rights reserved.
//

#import "EmojiPanelVC.h"
#import "Utils.h"
#import "UIColor+Wonderful.h"
#import <objc/runtime.h>

@interface EmojiPanelVC () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *emojiCollectionView;

@end

@implementation EmojiPanelVC

- (instancetype)initWithPageIndex:(int)pageIndex
{
    if (self = [super init]) {
        _pageIndex = pageIndex;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor silverColor];
    
    UICollectionViewFlowLayout *flowLayout  = [UICollectionViewFlowLayout new];
    CGFloat screenWidth                     = [UIScreen mainScreen].bounds.size.width;
    flowLayout.minimumInteritemSpacing      = (screenWidth - 40 - 30 * RowEmojiNum) / RowEmojiNum; //列间距
    flowLayout.minimumLineSpacing           = 25;
    flowLayout.sectionInset                 = UIEdgeInsetsMake(15, 0, 5, 0);
    
    _emojiCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    [_emojiCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"EmojiCell"];
    _emojiCollectionView.backgroundColor = [UIColor silverColor];
    _emojiCollectionView.scrollEnabled = NO;
    _emojiCollectionView.dataSource = self;
    _emojiCollectionView.delegate = self;
    _emojiCollectionView.bounces = NO;
    [self.view addSubview:_emojiCollectionView];
    
    _emojiCollectionView.translatesAutoresizingMaskIntoConstraints = NO;
    NSDictionary *views = NSDictionaryOfVariableBindings(_emojiCollectionView);
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-8-[_emojiCollectionView]|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-10-[_emojiCollectionView]-10-|" options:0 metrics:nil views:views]];
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    NSInteger left = 123 - _pageIndex * PageEmojiNum;
    return left >= PageEmojiNum ? 3 : (left + RowEmojiNum) / RowEmojiNum;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSInteger left = 123 - _pageIndex * PageEmojiNum - section * RowEmojiNum;
    return left >= RowEmojiNum? RowEmojiNum : left + 1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(30, 30);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"EmojiCell" forIndexPath:indexPath];
    NSInteger section = indexPath.section;
    NSInteger row     = indexPath.row;
    
    if (section == [self numberOfSectionsInCollectionView:collectionView] - 1&&
            row == [self collectionView:collectionView numberOfItemsInSection:section] - 1) {
        UIImageView* imageView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"delete"]];
        [imageView setAccessibilityIdentifier:@"delete"];
        [cell setBackgroundView:imageView];
//        [cell setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"delete"]]];
    } else {
        NSInteger emojiNum = _pageIndex * PageEmojiNum + section * RowEmojiNum + row + 1;
        NSString *emojiImageName;
        if (emojiNum >= 106) {
            emojiImageName = [Utils.emojiDict[@(emojiNum).stringValue] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@":"]];
        } else {
            emojiImageName = [NSString stringWithFormat:@"%03ld", (long)emojiNum];
        }
        [cell setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:emojiImageName]]];
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    NSInteger row     = indexPath.row;
    
    UICollectionViewCell* cell = [collectionView cellForItemAtIndexPath:indexPath];
    if([cell.backgroundView.accessibilityIdentifier isEqualToString:@"delete"]){
        //这里有点小问题
        _deleteEmoji();
    } else {
        NSInteger emojiNum = _pageIndex * PageEmojiNum + section * RowEmojiNum + row + 1;
        NSString *emojiImageName, *emojiStr;
        if (emojiNum >= 106) {
            emojiStr = Utils.emojiDict[@(emojiNum).stringValue];
            emojiImageName = [emojiStr stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@":"]];
        } else {
            emojiStr = [NSString stringWithFormat:@"[%d]", emojiNum - 1];
            emojiImageName = [NSString stringWithFormat:@"%03ld", emojiNum];
        }
        
        NSTextAttachment *textAttachment = [NSTextAttachment new];
        textAttachment.image = [UIImage imageNamed:emojiImageName];
        [textAttachment adjustY:-3];
        
        objc_setAssociatedObject(textAttachment, @"emoji", emojiStr, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        _didSelectEmoji(textAttachment);
    }
}



@end

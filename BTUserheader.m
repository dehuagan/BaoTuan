//
//  BTUserheader.m
//  BaoTuan
//
//  Created by 甘徳华 on 2016/11/17.
//  Copyright © 2016年 GDH. All rights reserved.
//

#import "BTUserheader.h"

@implementation BTUserheader



+(instancetype)cell{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]firstObject];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
- (IBAction)showStatus1:(UIButton *)sender {
    
    if ([_delegate respondsToSelector:@selector(chooseBtn:)]) {
        sender.tag = 6;
        [_delegate chooseBtn:sender];
    }

}
- (IBAction)showStatus2:(UIButton *)sender {
    if ([_delegate respondsToSelector:@selector(chooseBtn:)]) {
        sender.tag = 7;
        [_delegate chooseBtn:sender];
    }

}
- (IBAction)showStatus3:(UIButton *)sender {
    if ([_delegate respondsToSelector:@selector(chooseBtn:)]) {
        sender.tag = 8;
        [_delegate chooseBtn:sender];
    }

}
- (IBAction)showStatus4:(UIButton *)sender {
    if ([_delegate respondsToSelector:@selector(chooseBtn:)]) {
        sender.tag = 9;
        [_delegate chooseBtn:sender];
    }

}

- (IBAction)checkAction:(UIButton *)sender {
    if ([_delegate respondsToSelector:@selector(chooseBtn:)]) {
        sender.tag = 5;
        [_delegate chooseBtn:sender];
    }
}
//-(void)setFrame:(CGRect)frame{
//    frame.size.height -= 1;
////    frame.origin.y+=10;
//    [super setFrame:frame];
//}
@end

//
//  BTUserheader.h
//  BaoTuan
//
//  Created by 甘徳华 on 2016/11/17.
//  Copyright © 2016年 GDH. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol BTUserheaderDelegate <NSObject>
- (void)chooseBtn:(UIButton *)button;
@end
@interface BTUserheader : UITableViewCell
@property (assign, nonatomic) BOOL  isChecked;
@property (assign, nonatomic) id<BTUserheaderDelegate> delegate;
+(instancetype)cell;
@property (weak, nonatomic) IBOutlet UIButton *applybtn;
@property (weak, nonatomic) IBOutlet UIButton *addbtn;
@property (weak, nonatomic) IBOutlet UIButton *invitingbtn;
@property (weak, nonatomic) IBOutlet UIButton *setbtn;

@end

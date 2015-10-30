//
//  AreaPickerView.h
//  AreaDemo
//
//  Created by 孙云 on 15/10/29.
//  Copyright © 2015年 haidai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AreaModel.h"
@interface AreaPickerView : UIView<UIPickerViewDelegate, UIPickerViewDataSource>
//取消按钮事件
- (IBAction)clickCancelBtn:(UIBarButtonItem *)sender;
//确定按钮事件
- (IBAction)clickOkBtn:(UIBarButtonItem *)sender;
//时举器
@property (weak, nonatomic) IBOutlet UIPickerView *areaPicker;

@property (strong, nonatomic) AreaModel *locate;
//选中块
@property(nonatomic,copy)void(^chooseBlock)(AreaPickerView *area);
//取消块
@property(nonatomic,copy)void(^cancelBlock)();
//确定块
@property(nonatomic,copy)void(^okBlock)();
- (id)initWithArea;
- (void)showInView:(UIView *)view;
- (void)cancelPicker;
@end

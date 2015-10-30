//
//  ViewController.m
//  AreaDemo
//
//  Created by 孙云 on 15/10/29.
//  Copyright © 2015年 haidai. All rights reserved.
//

#import "ViewController.h"
#import "AreaPickerView.h"
@interface ViewController ()
- (IBAction)clickBtn:(UIButton *)sender;
//地址按钮
@property (weak, nonatomic) IBOutlet UIButton *areaBtn;
@property (strong, nonatomic) NSString *areaValue;
@property (strong, nonatomic) AreaPickerView *locatePicker;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self cancelLocatePicker];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
/**
 *  点击按钮事件
 *
 *  @param sender <#sender description#>
 */
- (IBAction)clickBtn:(UIButton *)sender {
    self.locatePicker = [[AreaPickerView alloc]
                         initWithArea];
    //块的相关操作
    __weak typeof(self)weakSelf = self;
    self.locatePicker.chooseBlock= ^(AreaPickerView *area)
    {
        weakSelf.areaValue = [NSString stringWithFormat:@"%@ %@ %@", area.locate.state, area.locate.city, area.locate.district];

    };
    self.locatePicker.cancelBlock = ^()
    {
        [weakSelf cancelLocatePicker];
    };
    self.locatePicker.okBlock = ^()
    {
        if( (weakSelf.areaValue == nil) || [weakSelf.areaValue isEqualToString:@"北京 北京 通州"])
        {
            weakSelf.areaValue = @"北京 北京 通州";
        }
        [weakSelf.areaBtn
                        setTitle:weakSelf.areaValue
                        forState:UIControlStateNormal];
        [weakSelf cancelLocatePicker];
    };
    [self.locatePicker showInView:self.view];
}
#pragma mark - HZAreaPicker delegate
-(void)pickerDidChaneStatus:(AreaPickerView *)picker
{
    self.areaValue = [NSString stringWithFormat:@"%@ %@ %@", picker.locate.state, picker.locate.city, picker.locate.district];
    NSLog(@"%@",self.areaValue);
}
/**
 *  取消时举器
 */
-(void)cancelLocatePicker
{
    [self.locatePicker cancelPicker];
    self.locatePicker = nil;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    if( (self.areaValue == nil) || [self.areaValue isEqualToString:@"北京 北京 通州"])
    {
        self.areaValue = @"北京 北京 通州";
    }
    [self.areaBtn
                setTitle:self.areaValue
                forState:UIControlStateNormal];
    [self cancelLocatePicker];
}

@end

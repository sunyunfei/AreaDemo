//
//  AreaPickerView.m
//  AreaDemo
//
//  Created by 孙云 on 15/10/29.
//  Copyright © 2015年 haidai. All rights reserved.
//

#import "AreaPickerView.h"
@interface AreaPickerView()
{
     NSArray *provinces, *cities, *areas;
}
@end
@implementation AreaPickerView
/**
 *  构造
 *
 *  @return <#return value description#>
 */
- (id)initWithArea
{
    self = [[[NSBundle mainBundle] loadNibNamed:@"AreaPickerView" owner:self options:nil] objectAtIndex:0];
    if (self) {
        self.areaPicker.dataSource = self;
        self.areaPicker.delegate = self;
        
        //加载数据
            provinces = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"area.plist" ofType:nil]];
            cities = [[provinces objectAtIndex:0] objectForKey:@"cities"];
            
            self.locate.state = [[provinces objectAtIndex:0] objectForKey:@"state"];
            self.locate.city = [[cities objectAtIndex:0] objectForKey:@"city"];
            
            areas = [[cities objectAtIndex:0] objectForKey:@"areas"];
            if (areas.count > 0) {
                self.locate.district = [areas objectAtIndex:0];
            } else{
                self.locate.district = @"";
            }
    }
    
    return self;
 
}
-(AreaModel *)locate
{
    if (_locate == nil) {
        _locate = [[AreaModel alloc] init];
    }
    
    return _locate;
}
/**
 *  时举器代理
 *
 *  @param view <#view description#>
 */
#pragma mark - PickerView lifecycle

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            return [provinces count];
            break;
        case 1:
            return [cities count];
            break;
        case 2:
                return [areas count];
                break;
        default:
            return 0;
            break;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
        switch (component) {
            case 0:
                return [[provinces objectAtIndex:row] objectForKey:@"state"];
                break;
            case 1:
                return [[cities objectAtIndex:row] objectForKey:@"city"];
                break;
            case 2:
                if ([areas count] > 0) {
                    return [areas objectAtIndex:row];
                    break;
                }
            default:
                return  @"";
                break;
        }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
        switch (component) {
            case 0:
                cities = [[provinces objectAtIndex:row] objectForKey:@"cities"];
                [self.areaPicker selectRow:0 inComponent:1 animated:YES];
                [self.areaPicker reloadComponent:1];
                
                areas = [[cities objectAtIndex:0] objectForKey:@"areas"];
                [self.areaPicker selectRow:0 inComponent:2 animated:YES];
                [self.areaPicker reloadComponent:2];
                
                self.locate.state = [[provinces objectAtIndex:row] objectForKey:@"state"];
                self.locate.city = [[cities objectAtIndex:0] objectForKey:@"city"];
                if ([areas count] > 0) {
                    self.locate.district = [areas objectAtIndex:0];
                } else{
                    self.locate.district = @"";
                }
                break;
            case 1:
                areas = [[cities objectAtIndex:row] objectForKey:@"areas"];
                [self.areaPicker selectRow:0 inComponent:2 animated:YES];
                [self.areaPicker reloadComponent:2];
                
                self.locate.city = [[cities objectAtIndex:row] objectForKey:@"city"];
                if ([areas count] > 0) {
                    self.locate.district = [areas objectAtIndex:0];
                } else{
                    self.locate.district = @"";
                }
                break;
            case 2:
                if ([areas count] > 0) {
                    self.locate.district = [areas objectAtIndex:row];
                } else{
                    self.locate.district = @"";
                }
                break;
            default:
                break;
        }
    //选中块
    self.chooseBlock(self);
}
/**
 *  动作事件
 *
 *  @param view <#view description#>
 */
- (void)showInView:(UIView *)view
{
    CGFloat width = [UIScreen mainScreen].applicationFrame.size.width;
    CGFloat height = [UIScreen mainScreen].applicationFrame.size.height;
    self.frame = CGRectMake(0, height, width, self.frame.size.height);
    [view addSubview:self];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(0, height - self.frame.size.height, width, self.frame.size.height);
    }];
}
- (void)cancelPicker
{
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.frame = CGRectMake(0, self.frame.origin.y+self.frame.size.height, self.frame.size.width, self.frame.size.height);
                     }
                     completion:^(BOOL finished){
                         [self removeFromSuperview];
                         
                     }];

}
/**
 *  取消按钮事件
 *
 *  @param sender <#sender description#>
 */
- (IBAction)clickCancelBtn:(UIBarButtonItem *)sender {
    self.cancelBlock();
}
/**
 *  确定按钮事件
 *
 *  @param sender <#sender description#>
 */
- (IBAction)clickOkBtn:(UIBarButtonItem *)sender {
    self.okBlock();
}
@end

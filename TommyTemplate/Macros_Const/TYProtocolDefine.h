//
//  TYProtocolDefine.h
//  TommyTemplate
//
//  Created by Tommy on 2017/5/3.
//  Copyright © 2017年 Tommy. All rights reserved.
//

#ifndef TYProtocolDefine_h
#define TYProtocolDefine_h


#pragma mark - Touch UITextField Delegate
@protocol TYTextFieldDelegate <NSObject>

@optional
// tag 作为取值的 key
- (void)ty_textFieldValueChanged:(UITextField *)sender;
// titleName 作为取值的key
- (void)ty_textFieldValueChanged:(UITextField *)sender byTitleName:(NSString *)titleName;
- (BOOL)ty_textFieldShouldBeginEditing:(UITextField *)textField;
- (void)ty_textFieldDidBeginEditing:(UITextField *)textField;
- (BOOL)ty_textFieldShouldEndEditing:(UITextField *)textField;
- (void)ty_textFieldDidEndEditing:(UITextField *)textField;
- (void)ty_textFieldDidEndEditing:(UITextField *)textField byTitleName:(NSString *)titleName;
- (BOOL)ty_textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
- (BOOL)ty_textFieldShouldClear:(UITextField *)textField;
- (BOOL)ty_textFieldShouldReturn:(UITextField *)textField;

@end


#pragma mark - Click Button Delegate
@protocol TYButtonDelegate <NSObject>

@optional
- (void)ty_buttonControlEventTouchUpInside:(UIButton *)button;

@end


#endif /* TYProtocolDefine_h */

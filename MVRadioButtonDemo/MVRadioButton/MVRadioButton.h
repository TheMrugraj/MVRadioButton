//
//  MVRadioButton.h
//  DYRCT
//
//  Created by  on 16/03/15.
//  Copyright (c) 2015 DYRCT. All rights reserved.
//

#import <UIKit/UIKit.h>
IB_DESIGNABLE
@interface MVRadioButton : UIControl{

    CALayer *knob;
}
@property(nonatomic,strong)UIView *radioIcon;
@property(nonatomic) IBInspectable BOOL isOn;
@property(nonatomic) IBInspectable UIColor *ringColor;
@property(nonatomic) IBInspectable UIColor *knobColor;
@property(nonatomic) IBInspectable NSString *title;
@property(nonatomic) IBInspectable NSString *titleForSelected;

@property(nonatomic,strong)UILabel *lblTitle;
@end

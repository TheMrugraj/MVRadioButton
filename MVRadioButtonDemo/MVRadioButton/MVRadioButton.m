//
//  MVRadioButton.m
//  DYRCT
//
//  Created by  on 16/03/15.
//  Copyright (c) 2015 DYRCT. All rights reserved.
//

#import "MVRadioButton.h"

@implementation MVRadioButton
@synthesize radioIcon;
-(id)initWithCoder:(NSCoder *)aDecoder{
        self =[super initWithCoder:aDecoder];
    if(self){
        [self addTitle:_title andSelectedTitle:_titleForSelected];
    }
    return self;
}
- (void)drawRect:(CGRect)rect {
        [self addTitle:_title andSelectedTitle:_titleForSelected];
}


#pragma mark - Setters

-(void)setValue:(id)value forKeyPath:(NSString *)keyPath{
    if([keyPath isEqualToString:@"ringColor"]){
        self.ringColor = value;
    }else if([keyPath isEqualToString:@"knobColor"]){
        self.knobColor =  value;
    }else if ([keyPath isEqualToString:@"title"]){
        self.title = value;
        [self addTitle:_title andSelectedTitle:self.titleForSelected];
    }else if ([keyPath isEqualToString:@"titleForSelected"]){
        self.titleForSelected = value;
        [self addTitle:_title andSelectedTitle:self.titleForSelected];
    }
}

-(void)setKnobColor:(UIColor *)knobColor{

    _knobColor = knobColor;
    if(knob){
        knob.backgroundColor =  knobColor.CGColor;
    }
    if(_lblTitle){
        _lblTitle.textColor =  _knobColor;
    }
}
-(void)setRingColor:(UIColor *)ringColor{
    _ringColor = ringColor;
    if(radioIcon){
        radioIcon.layer.borderColor =_ringColor.CGColor;
    }
}


#pragma mark - Title Update
-(void)addTitle:(NSString*)title andSelectedTitle:(NSString*)strSelectedtitle{
    if(!_lblTitle){
        _lblTitle = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.height, 0, self.frame.size.width-36.0, self.frame.size.height)];


        [self addSubview:_lblTitle];
        
        radioIcon = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.height-4, self.frame.size.height-4)];
        radioIcon.userInteractionEnabled = NO;
        radioIcon.layer.cornerRadius = (self.frame.size.height-4)/2.0;
        radioIcon.layer.borderColor =_ringColor.CGColor;
        radioIcon.layer.borderWidth = 1.0;
        radioIcon.layer.masksToBounds = YES;
        radioIcon.center = CGPointMake((self.frame.size.height-4)/2.0, self.frame.size.height/2.0);
        [self addSubview:radioIcon];

    }
    
    if(_isOn){
        [self addKnob];
        _lblTitle.text = strSelectedtitle;
    }else{
        [self removeKnob];
        _lblTitle.text = title;
    }
}

#pragma mark - Knob Related Methods


-(void)setIsOn:(BOOL)isOn{
    _isOn=isOn;
    if(_isOn){
        [self addKnob];
    }else{
        [self removeKnob];
    }
}
-(void)addKnob{
    if(knob){
        [knob removeFromSuperlayer];
        knob = nil;
    }
    knob = [CALayer layer];
    knob.frame = CGRectMake(0, 0, radioIcon.frame.size.height*0.4, radioIcon.frame.size.height*0.4);
    knob.backgroundColor =_knobColor.CGColor;
    knob.cornerRadius = knob.frame.size.height*0.5;
    knob.masksToBounds = YES;
    knob.position = CGPointMake(radioIcon.frame.size.height*0.5, radioIcon.frame.size.height*0.5);
    knob.opacity = 0.0;
    [radioIcon.layer addSublayer:knob];
    
    
    [CATransaction begin];
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    basicAnimation.fromValue = [NSNumber numberWithInt:0.0];
    basicAnimation.toValue = [NSNumber numberWithInt:1.0];
    basicAnimation.duration = 0.2;
    basicAnimation.fillMode = kCAFillModeForwards;
    basicAnimation.removedOnCompletion = NO;
    
    CABasicAnimation *basicTranform = [CABasicAnimation animationWithKeyPath:@"transform"];
    basicTranform.fromValue = [NSValue valueWithCATransform3D:CATransform3DScale(knob.transform, 0.0, 0.0, 0.0)];
    basicTranform.toValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    basicTranform.duration = 0.2;
    basicTranform.removedOnCompletion = NO;
    basicTranform.fillMode = kCAFillModeForwards;
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithControlPoints:0.25 :0.9 :0.49 :1.55]];
    [CATransaction setCompletionBlock:^{
        knob.opacity = 1.0;
        [knob removeAllAnimations];
    }];
    [knob addAnimation:basicTranform forKey:@"transform"];
    [knob addAnimation:basicAnimation forKey:@"fadeIn"];
    [CATransaction commit];
    
    
}
-(void)removeKnob{
    if(knob){
        
        
        [CATransaction begin];
        CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        basicAnimation.fromValue = [NSNumber numberWithInt:1.0];
        basicAnimation.toValue = [NSNumber numberWithInt:0.0];
        basicAnimation.duration = 0.2;
        basicAnimation.fillMode = kCAFillModeForwards;
        basicAnimation.removedOnCompletion = NO;
        
        CABasicAnimation *basicTranform = [CABasicAnimation animationWithKeyPath:@"transform"];
        basicTranform.toValue = [NSValue valueWithCATransform3D:CATransform3DScale(knob.transform, 0.01, 0.01, 0.01)];
        basicTranform.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
        basicTranform.duration = 0.2;
        basicTranform.removedOnCompletion = NO;
        basicTranform.fillMode = kCAFillModeForwards;
        [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithControlPoints:0.54 :-0.39 :0.89 :0.54]];
        [CATransaction setCompletionBlock:^{
            [knob removeAllAnimations];
            [knob removeFromSuperlayer];
            knob = nil;
        }];
        [knob addAnimation:basicTranform forKey:@"transform"];
        [knob addAnimation:basicAnimation forKey:@"fadeIn"];
        [CATransaction commit];

    }
}

-(BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    return YES;
}
-(void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    if(CGRectContainsPoint(self.bounds, [touch locationInView:self])){
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
}

@end

//
//  DTButton.swift
//  FacebookPopAnimation
//
//  Created by Liu Jingkai on 15/9/15.
//  Copyright (c) 2015年 Liu Jingkai. All rights reserved.
//

import UIKit

class DTButton: UIButton {
    
    
    @IBOutlet weak var topView: UIView!
    
    @IBOutlet weak var middleView: UIView!
    
    @IBOutlet weak var bottomView: UIView!
    

    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        super.touchesBegan(touches, withEvent: event)
        
        //缩Button
        var buttonScale = self.pop_animationForKey("buttonScale") as? POPSpringAnimation
        
        if buttonScale != nil{
            buttonScale?.toValue = NSValue(CGPoint: CGPointMake(0.9, 0.9))
        }else{
            buttonScale = POPSpringAnimation(propertyNamed: kPOPViewScaleXY)
            buttonScale?.toValue = NSValue(CGPoint: CGPointMake(0.9, 0.9))
            buttonScale?.springBounciness = 20
            buttonScale?.springSpeed = 15
            self.pop_addAnimation(buttonScale, forKey: "buttonScale")
        }
        
        //旋转Button 45度
        var buttonSpin = self.pop_animationForKey("buttonSpin") as? POPSpringAnimation
        
        if buttonSpin != nil{
            buttonSpin?.toValue = M_PI_4
        }else{
            buttonSpin = POPSpringAnimation(propertyNamed: kPOPLayerRotation)
            buttonSpin?.toValue = M_PI_4
            buttonSpin?.springBounciness = 15
            buttonSpin?.springSpeed = 15
            self.layer.pop_addAnimation(buttonSpin, forKey: "buttonSpin")
        }
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        super.touchesEnded(touches, withEvent: event)
        
        //放Button
        var buttonScale = self.pop_animationForKey("buttonScale") as? POPSpringAnimation
        
        if buttonScale != nil{
            buttonScale?.toValue = NSValue(CGPoint: CGPointMake(1, 1))
        }else{
            buttonScale = POPSpringAnimation(propertyNamed: kPOPViewScaleXY)
            buttonScale?.toValue = NSValue(CGPoint: CGPointMake(1, 1))
            buttonScale?.springBounciness = 15
            buttonScale?.springSpeed = 15
            self.pop_addAnimation(buttonScale, forKey: "buttonScale")
        }
        
        //旋转Button 复原
        var buttonSpin = self.pop_animationForKey("buttonSpin") as? POPSpringAnimation
        
        if buttonSpin != nil{
            buttonSpin?.toValue = 0
        }else{
            buttonSpin = POPSpringAnimation(propertyNamed: kPOPLayerRotation)
            buttonSpin?.toValue = 0
            buttonSpin?.springBounciness = 20
            buttonSpin?.springSpeed = 15
            self.layer.pop_addAnimation(buttonSpin, forKey: "buttonSpin")
        }
        
        
    }
    

}

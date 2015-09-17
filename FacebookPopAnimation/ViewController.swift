//
//  ViewController.swift
//  FacebookPopAnimation
//
//  Created by Liu Jingkai on 15/9/15.
//  Copyright (c) 2015年 Liu Jingkai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var showDateButton: DTButton!
    
    var dateButton: DTButton?
    
    var dateButtonShape: Bool = true
    var showDateButtonStatus: Bool = true // true>由方变圆 false>由圆变方
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //初始化redBall 并添加到View中
        let redBall = UIView(frame: CGRectMake(100, 100, 100, 100))
        redBall.backgroundColor = UIColor.redColor()
        //redBall.layer.cornerRadius = 50
        self.view.addSubview(redBall)
        
        //放大
        let scale = POPSpringAnimation(propertyNamed: kPOPViewScaleXY)
        scale.toValue = NSValue(CGPoint: CGPointMake(1.5, 1.5))
        scale.springBounciness = 20
        scale.springSpeed = 1
        redBall.pop_addAnimation(scale, forKey: "scale")

        //XY位移
        let move = POPSpringAnimation(propertyNamed: kPOPLayerPosition)
        move.toValue = NSValue(CGPoint: CGPointMake(400, 200))
        move.springBounciness = 20
        move.springSpeed = 1
        redBall.layer.pop_addAnimation(move, forKey: "move")
        
        //旋转
        let spin = POPSpringAnimation(propertyNamed: kPOPLayerRotation)
        spin.toValue = M_PI * 8
        spin.springBounciness = 20
        spin.springSpeed = 1
        redBall.layer.pop_addAnimation(spin, forKey: "spin")
        
        //背景色变化
        let color = POPSpringAnimation(propertyNamed: kPOPViewBackgroundColor)
        color.toValue = UIColor.blueColor()
        color.springBounciness = 20
        color.springSpeed = 5
        redBall.pop_addAnimation(color, forKey: "color")
        
        // 初始化DateButton
        // > 继承 DTButton 类  并引用 DTButton.xib
        var views = NSBundle.mainBundle().loadNibNamed("DTButton", owner: nil, options: nil) as NSArray
        self.dateButton = views.lastObject as? DTButton
        
        // > 添加DateButton的响应事件
        self.dateButton!.addTarget(self, action: "tapedDateButton:", forControlEvents: UIControlEvents.TouchUpInside)
        
        // > 设置DateButton屏幕位置
        var dateButtonFrame = dateButton!.frame
        dateButtonFrame.origin.x += 100
        dateButtonFrame.origin.y += 200
        self.dateButton!.frame = dateButtonFrame
        
        // > 设置topView middleView bottomView 的cornRadius
        self.dateButton!.topView.layer.cornerRadius = self.dateButton!.topView.bounds.height/2
        self.dateButton!.middleView.layer.cornerRadius = self.dateButton!.middleView.bounds.height/2
        self.dateButton!.bottomView.layer.cornerRadius = self.dateButton!.bottomView.bounds.height/2
        
        // 添加dateButton到View
        self.view.addSubview(dateButton!)
    }

    @IBAction func didTapButton(sender: UIButton) {

        if showDateButtonStatus{
            let shape = POPSpringAnimation(propertyNamed: kPOPLayerCornerRadius)
            shape.toValue = 15
            shape.springBounciness = 10
            shape.springSpeed = 15
            self.showDateButton.layer.pop_addAnimation(shape, forKey: "shape")
            showDateButtonStatus = false
        }else{
            let shape = POPSpringAnimation(propertyNamed: kPOPLayerCornerRadius)
            shape.toValue = 0
            shape.springBounciness = 10
            shape.springSpeed = 15
            self.showDateButton.layer.pop_addAnimation(shape, forKey: "shape")
            showDateButtonStatus = true
        }
        
    }
    
    func tapedDateButton(sender: DTButton){
        
        // 所以POP对象的复用实例
        // DateButton 方形 圆形 形状转变
        var shape = sender.layer.pop_animationForKey("shap") as? POPSpringAnimation
        // 白色 绿色 颜色转变
        var topColer = sender.topView.pop_animationForKey("topColor") as? POPSpringAnimation
        var bottomColer = sender.bottomView.pop_animationForKey("bottomColor") as? POPSpringAnimation
        // 角度转动
        var topRotate = sender.topView.layer.pop_animationForKey("topRotate") as? POPSpringAnimation
        var bottomRotate = sender.bottomView.layer.pop_animationForKey("bottomRotate") as? POPSpringAnimation
        // 位置变化 XY坐标
        var topPosition = sender.topView.layer.pop_animationForKey("topPosition") as? POPSpringAnimation
        var bottomPosition = sender.bottomView.layer.pop_animationForKey("bottomPosition") as? POPSpringAnimation
        
        // 获取topView bottomView的原始位置
        
        var topViewOrigin = sender.topView.bounds.origin as CGPoint
        var bottomViewOrigin = sender.bottomView.bounds.origin as CGPoint
    
        
        
        
        if self.dateButtonShape{
            self.dateButtonShape = false
            
            // 隐去中间横杆
            UIView.animateWithDuration(0.2, animations: { () -> Void in
                sender.middleView.alpha = 0
                }, completion: nil)
            
            // DateButton 由 方形 变为 圆形
            if shape != nil {
                shape?.toValue = sender.bounds.height/2
            }else{
                shape = POPSpringAnimation(propertyNamed: kPOPLayerCornerRadius)
                shape?.toValue = sender.bounds.height/2
                shape?.springBounciness = 10
                shape?.springSpeed = 15
                sender.layer.pop_addAnimation(shape, forKey: "shape")
            }
            
            // 上横杆变为绿色
            if topColer != nil {
                topColer?.toValue = UIColor.greenColor()
            }else{
                topColer = POPSpringAnimation(propertyNamed: kPOPViewBackgroundColor)
                topColer?.toValue = UIColor.greenColor()
                topColer?.springBounciness = 10
                topColer?.springSpeed = 15
                sender.topView.pop_addAnimation(topColer, forKey: "topColer")
            }
            // 下横杆变为绿色
            if bottomColer != nil {
                bottomColer?.toValue = UIColor.greenColor()
            }else{
                bottomColer = POPSpringAnimation(propertyNamed: kPOPViewBackgroundColor)
                bottomColer?.toValue = UIColor.greenColor()
                bottomColer?.springBounciness = 10
                bottomColer?.springSpeed = 15
                sender.bottomView.pop_addAnimation(bottomColer, forKey: "bottomColer")
            }
            
            // 上横杆逆时针45度
            if topRotate != nil {
                topRotate?.toValue = -M_PI_4
            }else{
                topRotate = POPSpringAnimation(propertyNamed: kPOPLayerRotation)
                topRotate?.toValue = -M_PI_4
                topRotate?.springBounciness = 10
                topRotate?.springSpeed = 15
                sender.topView.layer.pop_addAnimation(topRotate, forKey: "topRotate")
            }
            // 下横杆顺时针45度
            if bottomRotate != nil {
                bottomRotate?.toValue = M_PI_4
            }else{
                bottomRotate = POPSpringAnimation(propertyNamed: kPOPLayerRotation)
                bottomRotate?.toValue = M_PI_4
                bottomRotate?.springBounciness = 10
                bottomRotate?.springSpeed = 15
                sender.bottomView.layer.pop_addAnimation(bottomRotate, forKey: "bottomRotate")
            }
            
            //上横杆下移(origin.x+18, origin.y+16) 需要手工修改偏移值
            if topPosition != nil {
                topPosition?.toValue = NSValue(CGPoint: CGPointMake(topViewOrigin.x+18, topViewOrigin.y+16))
            }else{
                topPosition = POPSpringAnimation(propertyNamed: kPOPLayerPosition)
                topPosition?.toValue = NSValue(CGPoint: CGPointMake(topViewOrigin.x+18, topViewOrigin.y+16))
                topPosition?.springBounciness = 10
                topPosition?.springSpeed = 15
                sender.topView.layer.pop_addAnimation(topPosition, forKey: "topPosition")
            }
            //下横杆上移(origin.x+9, origin.y+19) 需要手工修改偏移值
            if bottomPosition != nil {
                bottomPosition?.toValue = NSValue(CGPoint: CGPointMake(topViewOrigin.x+9, topViewOrigin.y+19))
            }else{
                bottomPosition = POPSpringAnimation(propertyNamed: kPOPLayerPosition)
                bottomPosition?.toValue = NSValue(CGPoint: CGPointMake(topViewOrigin.x+9, topViewOrigin.y+19))
                bottomPosition?.springBounciness = 10
                bottomPosition?.springSpeed = 15
                sender.bottomView.layer.pop_addAnimation(bottomPosition, forKey: "bottomPosition")
            }
            
        }else{
            self.dateButtonShape = true
            
            UIView.animateWithDuration(0.2, animations: { () -> Void in
                sender.middleView.alpha = 1
                }, completion: nil)
            
            
            if shape != nil {
                shape?.toValue = 0
            }else{
                shape = POPSpringAnimation(propertyNamed: kPOPLayerCornerRadius)
                shape?.toValue = 0
                shape?.springBounciness = 10
                shape?.springSpeed = 15
                sender.layer.pop_addAnimation(shape, forKey: "shape")
                
            }
            
            // 上横杆变为白色
            if topColer != nil {
                topColer?.toValue = UIColor.whiteColor()
            }else{
                topColer = POPSpringAnimation(propertyNamed: kPOPViewBackgroundColor)
                topColer?.toValue = UIColor.whiteColor()
                topColer?.springBounciness = 10
                topColer?.springSpeed = 15
                sender.topView.pop_addAnimation(topColer, forKey: "topColer")
            }
            // 下横杆变为白色
            if bottomColer != nil {
                bottomColer?.toValue = UIColor.whiteColor()
            }else{
                bottomColer = POPSpringAnimation(propertyNamed: kPOPViewBackgroundColor)
                bottomColer?.toValue = UIColor.whiteColor()
                bottomColer?.springBounciness = 10
                bottomColer?.springSpeed = 15
                sender.bottomView.pop_addAnimation(bottomColer, forKey: "bottomColer")
            }
            
            // 上横杆顺时针45度
            if topRotate != nil {
                topRotate?.toValue = 0
            }else{
                topRotate = POPSpringAnimation(propertyNamed: kPOPLayerRotation)
                topRotate?.toValue = 0
                topRotate?.springBounciness = 10
                topRotate?.springSpeed = 15
                sender.topView.layer.pop_addAnimation(topRotate, forKey: "topRotate")
            }
            // 下横杆逆时针45度
            if bottomRotate != nil {
                bottomRotate?.toValue = 0
            }else{
                bottomRotate = POPSpringAnimation(propertyNamed: kPOPLayerRotation)
                bottomRotate?.toValue = 0
                bottomRotate?.springBounciness = 10
                bottomRotate?.springSpeed = 15
                sender.bottomView.layer.pop_addAnimation(bottomRotate, forKey: "bottomRotate")
            }
            
            //上横杆位置还原(5, 5)
            if topPosition != nil {
                topPosition?.toValue = NSValue(CGPoint: CGPointMake(15, 7))
            }else{
                topPosition = POPSpringAnimation(propertyNamed: kPOPLayerPosition)
                topPosition?.toValue = NSValue(CGPoint: CGPointMake(15, 7))
                topPosition?.springBounciness = 10
                topPosition?.springSpeed = 15
                sender.topView.layer.pop_addAnimation(topPosition, forKey: "topPosition")
            }
            //下横杆位置还原(0, 0)
            if bottomPosition != nil {
                bottomPosition?.toValue = NSValue(CGPoint: CGPointMake(11, 23))
            }else{
                bottomPosition = POPSpringAnimation(propertyNamed: kPOPLayerPosition)
                bottomPosition?.toValue = NSValue(CGPoint: CGPointMake(11, 23))
                bottomPosition?.springBounciness = 10
                bottomPosition?.springSpeed = 15
                sender.bottomView.layer.pop_addAnimation(bottomPosition, forKey: "bottomPosition")
            }

            
            
        }
        
    }


}


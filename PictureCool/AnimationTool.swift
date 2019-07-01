//
//  AnimationTool.swift
//  PictureCool
//
//  Created by lighayes on 2019/7/1.
//  Copyright © 2019 flyingPigs. All rights reserved.
//

import UIKit
class AnimationTool: NSObject {
    

    class func baseAnimationWithKeyPath(_ path : String , fromValue : Any? , toValue : Any?, duration : CFTimeInterval, repeatCount : Float? , timingFunction : String?,isRemove:Bool) -> CABasicAnimation{
    
    let animate = CABasicAnimation(keyPath: path)
    //起始值
    //animate.fromValue = fromValue;
    
    //变成什么，或者说到哪个值
    animate.toValue = toValue
    
    //所改变属性的起始改变量 比如旋转360°，如果该值设置成为0.5 那么动画就从180°开始
    //        animate.byValue =
    
    //动画结束是否停留在动画结束的位置
    //        animate.isRemovedOnCompletion = false
    
    //动画时长
    animate.duration = duration
    
    //重复次数 Float.infinity 一直重复 OC：HUGE_VALF
    animate.repeatCount = repeatCount ?? 0
    
    //设置动画在该时间内重复
    //        animate.repeatDuration = 5
    
    //延时动画开始时间，使用CACurrentMediaTime() + 秒(s)
    //        animate.beginTime = CACurrentMediaTime() + 2;
    
    //设置动画的速度变化
    /*
     kCAMediaTimingFunctionLinear: String        匀速
     kCAMediaTimingFunctionEaseIn: String        先慢后快
     kCAMediaTimingFunctionEaseOut: String       先快后慢
     kCAMediaTimingFunctionEaseInEaseOut: String 两头慢，中间快
     kCAMediaTimingFunctionDefault: String       默认效果和上面一个效果极为类似，不易区分
     */
    
    animate.timingFunction = CAMediaTimingFunction(name: timingFunction.map { CAMediaTimingFunctionName(rawValue: $0) } ?? CAMediaTimingFunctionName.easeInEaseOut)
    
    
    //动画在开始和结束的时候的动作
    /*
     kCAFillModeForwards    保持在最后一帧，如果想保持在最后一帧，那么isRemovedOnCompletion应该设置为false
     kCAFillModeBackwards   将会立即执行第一帧，无论是否设置了beginTime属性
     kCAFillModeBoth        该值是上面两者的组合状态
     kCAFillModeRemoved     默认状态，会恢复原状
     */
    animate.fillMode = CAMediaTimingFillMode.forwards
    animate.isRemovedOnCompletion = isRemove
    
    //动画结束时，是否执行逆向动画
    //        animate.autoreverses = true
    
    return animate
    
}
}

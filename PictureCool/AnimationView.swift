//
//  AnimationView.swift
//  PictureCool
//
//  Created by lighayes on 2019/6/30.
//  Copyright © 2019 flyingPigs. All rights reserved.
//

import UIKit
import CoreMotion

class AnimationView:UIView,UICollisionBehaviorDelegate{
    var ball:[UIView] = []
    var animator: UIDynamicAnimator!
    var collision: UICollisionBehavior!
    var gravity:UIGravityBehavior!
    var itemBehavior:UIDynamicItemBehavior!
    var pushBehavior:UIPushBehavior!
    var motionManager = CMMotionManager()
    var tapGes:UITapGestureRecognizer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.tintDark
        addBall()
        addBehavior()
        addMotionControl()
        addTapGes()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addBall(){
        for i in 1...25{
            let tempBall = UIView(frame: CGRect(x: 50, y: 50, width: Int(i/5)*5+30, height: Int(i/5)*5+30))
            tempBall.backgroundColor = UIColor.skyBlue
            tempBall.layer.cornerRadius = tempBall.frame.width/2
            ball.append(tempBall)
            self.addSubview(ball[i-1])
        }
        
    }
    
    func collisionBehavior(_ behavior: UICollisionBehavior, beganContactFor item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?, at p: CGPoint) {
        let collidingView = item as! UIView
        if collidingView.backgroundColor == UIColor.stillBlue{
        collidingView.backgroundColor = UIColor.skyBlue
        }else{
            collidingView.backgroundColor = UIColor.stillBlue
        }
//        UIView.animateWithDuration(0.3) {
//            collidingView.backgroundColor = UIColor.grayColor();
//        }
    }
    
    private func addBehavior(){
        animator = UIDynamicAnimator(referenceView: self)
        collision = UICollisionBehavior(items: ball)
        collision.translatesReferenceBoundsIntoBoundary = true//边界
        collision.collisionDelegate = self
        gravity = UIGravityBehavior(items: ball);
        gravity.angle = 1.6;
        gravity.magnitude = 0.1;
        
        // 将重力行为添加到UIKit物理引擎类中
        animator.addBehavior(gravity)
        animator.addBehavior(collision)
        self.additemBehavior()
        self.addPushBehavior()
    }
    
    private func additemBehavior(){
        let itemBehaviour = UIDynamicItemBehavior(items: ball)
        itemBehaviour.elasticity = 1
        animator.addBehavior(itemBehaviour)
    }
    
     func addPushBehavior(){
        pushBehavior = UIPushBehavior(items: ball, mode: .instantaneous)
        pushBehavior.angle = (CGFloat.pi * 2).arc4random()
        pushBehavior.magnitude = CGFloat(1)+(CGFloat(4)).arc4random()
        pushBehavior.action = {[weak self] in
            self!.animator.removeBehavior(self!.pushBehavior!)
        }
        animator.addBehavior(pushBehavior)
    }
    
    private func addMotionControl(){
        motionManager.accelerometerUpdateInterval = 1/60
        
        if motionManager.isAccelerometerAvailable {
            let queue = OperationQueue.current
            
            motionManager.startAccelerometerUpdates(to: queue!) { (accelerometerData, error) in
                let totalAcce = (accelerometerData!.acceleration.x)*(accelerometerData!.acceleration.x)+(accelerometerData!.acceleration.y)*(accelerometerData!.acceleration.y)
                let tempSin = Double(accelerometerData!.acceleration.y) /  sqrt(totalAcce)
//                print("sin:\(tempSin)")
//                print("total:\(totalAcce)")
                if accelerometerData!.acceleration.x > 0{
                    let tempAngle = -tempSin*1.6
                    self.gravity.angle = CGFloat(tempAngle)
                }else{
                    let tempAngle = 3.2+tempSin*1.6
                    self.gravity.angle = CGFloat(tempAngle)
                }
                self.gravity.magnitude = CGFloat(totalAcce)
                
            }
        
        }
    }
    private func addTapGes(){
        tapGes = UITapGestureRecognizer()
        tapGes.addTarget(self, action: #selector(tapTap))
        self.addGestureRecognizer(tapGes)
    }
    
    @objc func tapTap(){
        self.addPushBehavior()
    }
}
extension CGFloat{
    func arc4random()->CGFloat{
        if self>0{
            return CGFloat(arc4random_uniform(UInt32(self)))
        }else if self == 0{
            return 0
        }else{
            return  CGFloat(arc4random_uniform(UInt32(-self)))
        }
    }
    
}

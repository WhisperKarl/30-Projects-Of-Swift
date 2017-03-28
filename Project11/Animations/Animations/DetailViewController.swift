//
//  DetailViewController.swift
//  Animations
//
//  Created by Karl on 2017/3/28.
//  Copyright © 2017年 whisperkarl.com. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var barTitle = ""
    var animationView: UIView!
    fileprivate let duration = 2.0
    fileprivate let delay = 0.2
    fileprivate let  scale = 1.2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRect()
        setupNavigationBar()
    }
    
    fileprivate func setupNavigationBar() {
        navigationController?.navigationBar.topItem?.title =  barTitle
    }
    
    fileprivate func setupRect() {
        switch barTitle {
        case "BezierCurve Position":
            animationView = drawCircleView()
        case "View Fade In":
            animationView = UIImageView(image: UIImage(named: "whatsapp"))
            animationView.frame = generalFrame
            animationView.center = generalCenter
        default:
            animationView = drawRectView(UIColor.red, frame: generalFrame, center: generalCenter)
        }
        view .addSubview(animationView)
    }
    
    @IBAction func animationAction(_ sender: Any) {
        switch barTitle {
        case "2-Color":
            changeColor(UIColor.green)
        case "Simple 2D Rotation":
            rotateView(M_PI)
        case "Multicolor":
            multiColor(UIColor.green, UIColor.blue)
        case "Multi Point Position":
            multiPosition(CGPoint.init(x: animationView.frame.origin.x, y: 100), CGPoint.init(x: animationView.frame.origin.x, y: 350))
        case "BezierCurve Position":
            var controlPoint1 = self.animationView.center
            controlPoint1.y -= 125.0
            var controlPoint2 = controlPoint1
            controlPoint2.x += 40.0
            controlPoint2.y -= 125.0
            var endPoint = self.animationView.center
            endPoint.x += 75.0
            curvePath(endPoint, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
        case "Color and Frame Change":
            let currentFrame = self.animationView.frame
            let firstFrame = currentFrame.insetBy(dx: -30, dy: -50)
            let secondFrame = firstFrame.insetBy(dx: 10, dy: 15)
            let thirdFrame = secondFrame.insetBy(dx: -15, dy: -20)
            colorFrameChange(firstFrame, secondFrame, thirdFrame, UIColor.purple, UIColor.cyan, UIColor.black)
        case "View Fade In":
            viewFadeIn()
        case "Pop":
            Pop()
        default:
            break
        
        }
    }

    //MARK: - Pricvate Methods for animations
    fileprivate func Pop() {
        UIView.animate(withDuration: duration / 4, animations: { 
            self.animationView.transform = CGAffineTransform.init(scaleX: CGFloat(self.scale), y: CGFloat(self.scale))
        }) { (finished) in
            UIView.animate(withDuration: self.duration / 4, animations: { 
                self.animationView.transform = CGAffineTransform.identity
            }, completion: nil)
        }
    }
    fileprivate func viewFadeIn() {
        let secondView = UIImageView.init(image: UIImage.init(named: "facebook"))
        secondView.frame = self.animationView.frame
        secondView.alpha = 0.0
        
        view.insertSubview(secondView, aboveSubview: self.animationView)
        
        UIView.animate(withDuration: duration, animations: { 
            secondView.alpha = 1
            self.animationView.alpha = 0
        }, completion: nil)
    }
    fileprivate func colorFrameChange(_ firstFrame: CGRect, _ secondFrame: CGRect, _ thirdFrame: CGRect, _ firstColor: UIColor, _ secondColor: UIColor, _ thirdColor: UIColor){
        UIView.animate(withDuration: self.duration, animations: { 
            self.animationView.backgroundColor = firstColor
            self.animationView.frame = firstFrame
        }) { (finished) in
            UIView.animate(withDuration: self.duration, animations: { 
                self.animationView.backgroundColor = secondColor
                self.animationView.frame = secondFrame
            }, completion: { (finished) in
                UIView.animate(withDuration: self.duration, animations: { 
                    self.animationView.frame = thirdFrame
                    self.animationView.backgroundColor = thirdColor
                }, completion: nil)
            })
        }
    }
    fileprivate func curvePath(_ endPoint: CGPoint, controlPoint1: CGPoint, controlPoint2: CGPoint) {
        let path = UIBezierPath()
        path.move(to: self.animationView.center)
        path.addCurve(to: endPoint, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
        
        //关键帧动画
        let animation = CAKeyframeAnimation.init(keyPath: "position")
        animation.path = path.cgPath
        animation.duration = self.duration
        
        self.animationView.layer.add(animation, forKey: "animate position along path")
        self.animationView.center = endPoint
    }
    fileprivate func simplePosition(_ pos: CGPoint) {
        UIView.animate(withDuration: duration, animations: { 
            self.animationView.frame.origin = pos
        }, completion: nil)
    }
    fileprivate func multiPosition(_ firstPos: CGPoint, _ secondPos: CGPoint) {
        UIView.animate(withDuration: duration, animations: { 
            self.animationView.frame.origin = firstPos
        }) { finished in
            self.simplePosition(secondPos)
        }
    }
    fileprivate func multiColor(_ firstColor: UIColor, _ secondColor: UIColor) {
        UIView.animate(withDuration: duration, animations: { 
            self.animationView.backgroundColor = firstColor
        }) { (finished) in
            self.changeColor(secondColor)
        }
    }
    fileprivate func rotateView(_ angle: Double) {
        UIView.animate(withDuration: duration, delay: delay, options: [.repeat], animations: { 
            self.animationView.transform = CGAffineTransform.init(rotationAngle: CGFloat(angle))
        }, completion: nil)
    }
    fileprivate func changeColor(_ color: UIColor) {
        UIView.animate(withDuration: self.duration) { 
            self.animationView.backgroundColor = color
        }
    }
}

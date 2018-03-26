//
//  QuartzFunView.swift
//  Quartz Fun
//
//  Created by Aaron Dougher on 3/19/18.
//  Copyright © 2018 Erin Dougher. All rights reserved.
//

import UIKit


    
    extension UIColor {
        class func randomColor() -> UIColor {
            let red = CGFloat(Double(arc4random_uniform(255))/255)
            let green = CGFloat(Double(arc4random_uniform(255))/255)
            let blue = CGFloat(Double(arc4random_uniform(255))/255)
            return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        }
    }
    

    enum Shape : UInt {
        case line = 0, rect, elipse, image
    }
    
    enum DrawingColor : UInt {
        case red = 0, blue, yellow, green, random
    }


class QuartzFunView: UIView  {
    
    var shape = Shape.line
    var currentColor = UIColor.red
    var useRandomColor = false
    
    private let image = UIImage(named: "iphone")
    private var firstTouchLocation = CGPoint.zero
    private var lastTouchLocation = CGPoint.zero
    private var redDrawRect = CGRect.zero
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if useRandomColor {
                currentColor = UIColor.randomColor()
            }
            firstTouchLocation = touch.location(in: self)
            lastTouchLocation = firstTouchLocation
            redDrawRect = CGRect.zero
            setNeedsDisplay()
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            lastTouchLocation = touch.location(in: self)
            
            if shape == .image{
                let horizontalOffset = image!.size.width / 2
                let verticalOffset = image!.size.height / 2
                redDrawRect = redDrawRect.union(CGRect(x: lastTouchLocation.x - horizontalOffset, y: lastTouchLocation.y - verticalOffset, width: image!.size.width, height: image!.size.height))
            } else {
                redDrawRect = redDrawRect.union(currentRect())
            }
            setNeedsDisplay(redDrawRect)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            lastTouchLocation = touch.location(in: self)
            
            if shape == .image {
                let horizontalOffset = image!.size.width / 2
                let verticalOffset = image!.size.height / 2
                redDrawRect = redDrawRect.union(CGRect(x: lastTouchLocation.x - horizontalOffset, y: lastTouchLocation.y - verticalOffset, width: image!.size.width, height: image!.size.height))
            } else {
                redDrawRect = redDrawRect.union(currentRect())
            }
            
            setNeedsDisplay(redDrawRect)
        }
    }
    
  
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        context?.setLineWidth(2.0)
        context?.setStrokeColor(currentColor.cgColor)
        context?.setFillColor(currentColor.cgColor)
        
       
        
        switch shape {
        case .line:
            context?.move(to: CGPoint(x: firstTouchLocation.x, y: firstTouchLocation.y))
            context?.addLine(to: CGPoint(x: lastTouchLocation.x, y: lastTouchLocation.y))
            
            context?.strokePath()
            
        case .rect:
            context?.addRect(currentRect())
            context?.drawPath(using: .fillStroke)
            
        case .elipse:
            context?.addEllipse(in: currentRect())
            context?.drawPath(using: .fillStroke)
            
        case .image:
            let horizontalOffset = image!.size.width / 2
            let verticalOffset = image!.size.height / 2
            let drawPoint = CGPoint(x: lastTouchLocation.x - horizontalOffset, y: lastTouchLocation.y - verticalOffset)
            image!.draw(at: drawPoint)
        }
    }
    
    func currentRect() -> CGRect {
        return CGRect(x: firstTouchLocation.x, y: firstTouchLocation.y, width: lastTouchLocation.x - firstTouchLocation.x, height: lastTouchLocation.y - firstTouchLocation.y)
    }
    
}



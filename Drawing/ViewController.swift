//
//  ViewController.swift
//  Drawing
//
//  Created by takayuki abe on 2015/05/20.
//  Copyright (c) 2015年 takayuki abe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var canvas: UIImageView!
    
    var lastDrawImage: UIImage!
    var bezierPath: UIBezierPath!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        let touch = touches.first as! UITouch
        let currentPoint:CGPoint = touch.locationInView(canvas)
        bezierPath = UIBezierPath()
        bezierPath.lineCapStyle = kCGLineCapRound
        bezierPath.lineWidth = 1.0
        bezierPath.moveToPoint(currentPoint)
    }

    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        if bezierPath == nil {
            return
        }
        let touch = touches.first as! UITouch
        let currentPoint:CGPoint = touch.locationInView(canvas)
        bezierPath.addLineToPoint(currentPoint)
        drawLine(bezierPath)
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        if bezierPath == nil {
            return
        }
        let touch = touches.first as! UITouch
        let currentPoint:CGPoint = touch.locationInView(canvas)
        bezierPath.addLineToPoint(currentPoint)
        drawLine(bezierPath)
        lastDrawImage = canvas.image
    }
    
    func drawLine(path:UIBezierPath) {
        UIGraphicsBeginImageContext(canvas.frame.size)
        if lastDrawImage != nil {
            lastDrawImage.drawAtPoint(CGPointZero)
        }
        var blackColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        blackColor.setStroke()
        path.stroke()
        canvas.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
}


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

}


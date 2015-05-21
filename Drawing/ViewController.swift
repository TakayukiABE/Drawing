//
//  ViewController.swift
//  Drawing
//
//  Created by takayuki abe on 2015/05/20.
//  Copyright (c) 2015年 takayuki abe. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var canvas: UIImageView!
    
    var image:UIImage!
    var lastDrawImage: UIImage!
    var bezierPath: UIBezierPath!
    
    var cameraViewController:ViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func didTapCameraButton(sender: UIBarButtonItem) {
        self.pickImageFromCamera()
        self.pickImageFromLibrary()
        
    }
    func pickImageFromCamera() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            let controller = UIImagePickerController()
            controller.delegate = self
            controller.sourceType = UIImagePickerControllerSourceType.Camera
            self.presentViewController(controller, animated: true, completion: nil)
        }
    }
    func pickImageFromLibrary() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
            let controller = UIImagePickerController()
            controller.delegate = self
            controller.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            self.presentViewController(controller, animated: true, completion: nil)
        }
    }
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        if info[UIImagePickerControllerOriginalImage] != nil {
            image = info[UIImagePickerControllerOriginalImage] as? UIImage
            println(image)
        }
        self.view.backgroundColor = UIColor(patternImage: image)
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        let touch = touches.first as! UITouch
        let currentPoint:CGPoint = touch.locationInView(canvas)
        bezierPath = UIBezierPath()
        bezierPath.lineCapStyle = kCGLineCapRound
        bezierPath.lineWidth = 10.0
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
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        cameraViewController = segue.destinationViewController as? ViewController
    }
    
    
}
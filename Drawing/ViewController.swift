//
//  ViewController.swift
//  Drawing
//
//  Created by takayuki abe on 2015/05/20.
//  Copyright (c) 2015年 takayuki abe. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var penSegment: UISegmentedControl!
    @IBOutlet weak var penSizeSegment: UISegmentedControl!
    
    @IBOutlet weak var canvas: UIImageView!
    var undoStack: NSMutableArray!
    var redoStack: NSMutableArray!
    var image:UIImage!
    var lastDrawImage: UIImage!
    var bezierPath: UIBezierPath!
    var penColor:UIColor = UIColor.blackColor()
    var penSize:CGFloat = 10.0
    var cameraViewController:ViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        penSizeSegment.selectedSegmentIndex = 1
    }
    
    
    @IBAction func didChangePenType(sender: UISegmentedControl) {
        switch penSegment.selectedSegmentIndex {
        case 0: penColor = UIColor.blackColor()
        case 1: penColor = UIColor.whiteColor()
        case 2: penColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
        default: break
        }
    }
    
    @IBAction func didChangePenSize(sender: UISegmentedControl) {
        switch penSizeSegment.selectedSegmentIndex {
        case 0: penSize = 5.0
        case 1: penSize = 10.0
        case 2: penSize = 20.0
        default: break
        }
    }
    
    @IBAction func didTapCameraButton(sender: UIBarButtonItem) {
        self.pickImageFromCamera()
        self.pickImageFromLibrary()
        self.canvas.image = nil
        self.lastDrawImage = nil
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
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        image.drawInRect(self.view.bounds)
        var backgroundImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.view.backgroundColor = UIColor(patternImage: backgroundImage)
        
        
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        let touch = touches.first as! UITouch
        let currentPoint:CGPoint = touch.locationInView(canvas)
        bezierPath = UIBezierPath()
        bezierPath.lineCapStyle = kCGLineCapRound
        bezierPath.moveToPoint(currentPoint)
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        if bezierPath == nil {
            return
        }
        let touch = touches.first as! UITouch
        let currentPoint:CGPoint = touch.locationInView(canvas)
        bezierPath.strokeWithBlendMode(kCGBlendModeClear, alpha: 0.0)
        bezierPath.addLineToPoint(currentPoint)
        bezierPath.lineWidth = penSize
        drawLine(bezierPath)
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        if bezierPath == nil {
            return
        }
        let touch = touches.first as! UITouch
        let currentPoint:CGPoint = touch.locationInView(canvas)
                bezierPath.strokeWithBlendMode(kCGBlendModeClear, alpha: 0.0)
        bezierPath.addLineToPoint(currentPoint)
        drawLine(bezierPath)
        lastDrawImage = canvas.image
       // undoStack.addObject(bezierPath)
       // redoStack.removeAllObjects()
    }
    
    func drawLine(path:UIBezierPath) {
        UIGraphicsBeginImageContext(canvas.frame.size)
        if lastDrawImage != nil {
            lastDrawImage.drawAtPoint(CGPointZero)
        }
        penColor.setStroke()
        path.stroke()
        canvas.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
    @IBAction func didTapTrashButton(sender: UIBarButtonItem) {
        self.canvas.image = nil
        self.lastDrawImage = nil
    }
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
//        cameraViewController = segue.destinationViewController as? ViewController
//    }
}
//
//  CameraViewController.swift
//  Drawing
//
//  Created by takayuki abe on 2015/05/20.
//  Copyright (c) 2015年 takayuki abe. All rights reserved.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController {

    @IBOutlet weak var cameraView: UIImageView!
    var mySession : AVCaptureSession!
    var myDevice : AVCaptureDevice!
    var myImageOutput : AVCaptureStillImageOutput!
    var imageTaken : UIImage!
    override func viewDidLoad() {
        super.viewDidLoad()

        // セッションの作成.
        mySession = AVCaptureSession()
        
        // デバイス一覧の取得.
        let devices = AVCaptureDevice.devices()
        
        // バックカメラをmyDeviceに格納.
        for device in devices{
            if(device.position == AVCaptureDevicePosition.Back){
                myDevice = device as! AVCaptureDevice
            }
        }
        
        // バックカメラからVideoInputを取得.
        let videoInput = AVCaptureDeviceInput.deviceInputWithDevice(myDevice, error: nil) as! AVCaptureDeviceInput
        
        // セッションに追加.
        mySession.addInput(videoInput)
        
        // 出力先を生成.
        myImageOutput = AVCaptureStillImageOutput()
        
        // セッションに追加.
        mySession.addOutput(myImageOutput)
        
//        // 画像を表示するレイヤーを生成.
        let myVideoLayer : AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer.layerWithSession(mySession) as! AVCaptureVideoPreviewLayer
        
//        myVideoLayer.frame = self.view.bounds
       // cameraView.videoGravity = AVLayerVideoGravityResizeAspectFill
        
        // Viewに追加.
      //  self.view.layer.addSublayer(myVideoLayer)
        
        // セッション開始.
        mySession.startRunning()
        
        // UIボタンを作成.
//        let myButton = UIButton(frame: CGRectMake(0,0,120,50))
//        myButton.backgroundColor = UIColor.redColor();
//        myButton.layer.masksToBounds = true
//        myButton.setTitle("撮影", forState: .Normal)
//        myButton.layer.cornerRadius = 20.0
//        myButton.layer.position = CGPoint(x: self.view.bounds.width/2, y:self.view.bounds.height-50)
//        myButton.addTarget(self, action: "onClickMyButton:", forControlEvents: .TouchUpInside)
//        
//        // UIボタンをViewに追加.
//        self.view.addSubview(myButton);
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    @IBAction func didTapShutterButton(sender: UIButton) {
        
        // ビデオ出力に接続.
        let myVideoConnection = myImageOutput.connectionWithMediaType(AVMediaTypeVideo)
        
        // 接続から画像を取得.
        self.myImageOutput.captureStillImageAsynchronouslyFromConnection(myVideoConnection, completionHandler: { (imageDataBuffer, error) -> Void in
            
            // 取得したImageのDataBufferをJpegに変換.
            let myImageData : NSData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(imageDataBuffer)
            
            // JpegからUIIMageを作成.
            let myImage : UIImage = UIImage(data: myImageData)!
        })
        

        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func didTapBackButton(sender: UIButton) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
}

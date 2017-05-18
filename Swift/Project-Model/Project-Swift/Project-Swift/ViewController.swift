//
//  ViewController.swift
//  Project-Swift
//
//  Created by Erico GT on 3/31/17.
//  Copyright © 2017 Atlantic Solutions. All rights reserved.
//

import UIKit

class ViewController: UIViewController, InternetHelperDelegate, LoadingViewDelegate {

    var soundManager:SoundManager?
    var locationManager:LocationServiceControl?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)   {
        self.soundManager = SoundManager.init()
        locationManager = nil
        //
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.soundManager = SoundManager.init()
        locationManager = nil
        //
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor = App.Style.colorView_Light
        
        let arrayImages:Array<UIImage> = [UIImage(named:"flame_a_0001.png")!,
                                 UIImage(named:"flame_a_0002.png")!,
                                 UIImage(named:"flame_a_0003.png")!,
                                 UIImage(named:"flame_a_0004.png")!,
                                 UIImage(named:"flame_a_0005.png")!,
                                 UIImage(named:"flame_a_0006.png")!]
        
        let alert:SCLAlertViewPlus = SCLAlertViewPlus.createRichAlert(bodyMessage: "Este aplicativo é um projeto modelo para Swift 3.1. Várias classes, frameworks e pods já constam no projeto, prontas para uso.\n\nBasta fazer uma cópia e renomear para um novo projeto!", images: arrayImages, animationTimePerFrame: 0.1)
        alert.addButton(title: "OK", type: SCLAlertButtonType.Default) {
            //
        }
        alert.showSuccess("Bem vindo!", subTitle: "")
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        locationManager = LocationServiceControl.initAndStartMonitoringLocation()
    }
    
    @IBAction func actionPlaySound(sender:UIButton) {
        
        let iH:InternetHelper = InternetHelper.init()
        
        //URL destino
        var urlRequest:String = "http://md5.jsontest.com/?text=<text>"
        urlRequest = urlRequest.replacingOccurrences(of: "<text>", with: "erico.gimenes")
        
        //Parameters
        let parameters:Dictionary = [
            "x": App.RandInt(1, 100),
            "y": App.RandInt(1, 100)
        ]
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        iH.post(toURL: urlRequest, httpBodyData: parameters, delegate: self)
    }
    
    @IBAction func actionLoading(sender:UIButton){
        
        App.Delegate.activityView?.useBlurEffect = true
        App.Delegate.activityView?.useCancelButton = true
        //
        App.Delegate.activityView?.startActivity(.saving, true, false, self, nil)
        
    }
    
    func didFinishTaskWithError(error: NSError) {
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        
        DispatchQueue.main.async {
            let alert:SCLAlertViewPlus = SCLAlertViewPlus.init()
            alert.addButton(title: "OK", type: SCLAlertButtonType.Error) {
                print("teste")
            }
            
            alert.showError("Error", subTitle: error.userInfo["message"] as! String)
        }
    }
    
    func didFinishTaskWithSuccess(resultData: Dictionary<String, Any>) {
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        
        DispatchQueue.main.async {
            let alert:SCLAlertViewPlus = SCLAlertViewPlus.init()
            alert.addButton(title: "OK", type: SCLAlertButtonType.Success) {
                print("teste")
            }
            
            alert.showSuccess("Success", subTitle: String.init(format: "%@", [resultData]))
        }
    }
    
    func loadingViewWillShow(lV: LoadingView) {
        print("loadingViewWillShow")
    }
    
    func loadingViewDidShow(lV: LoadingView) {
        print("loadingViewDidShow")
    }
    
    func loadingViewDidHide(lV: LoadingView) {
        print("loadingViewDidHide")
    }
    
    func loadingViewWillHide(lV: LoadingView) {
        print("loadingViewWillHide")
    }
 
    func loadingViewCanceled(lV: LoadingView) {
        print("loadingViewCanceled")
        //
        App.Delegate.activityView?.stopActivity()
        
    }
}


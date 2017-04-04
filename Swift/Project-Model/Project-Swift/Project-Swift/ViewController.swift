//
//  ViewController.swift
//  Project-Swift
//
//  Created by Erico GT on 3/31/17.
//  Copyright © 2017 Atlantic Solutions. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lblResult:UILabel!
    //
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
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //NotificationCenter.default.addObserver( self, selector: #selector(self.locationUpdate), name: NSNotification.Name(rawValue: App.Constants.SYSNOT_LOCATION_SERVICE_UPDATE_WITH_GEOCODEINFO), object: nil)
        //NotificationCenter.default.addObserver( self, selector: #selector(self.locationUpdate2), name: NSNotification.Name(rawValue: App.Constants.SYSNOT_LOCATION_SERVICE_UPDATE_WITH_GEOCODEINFO), object: nil)
        
        //locationManager = LocationServiceControl.initAndStartMonitoringLocation()
        
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
        
        iH.post(toURL: urlRequest, httpBodyData: parameters) { (response, statusCode, error) in
            
            print("StatusCode: %li", statusCode)
            
            if let erro:NSError = error{
                DispatchQueue.main.async {
                    self.lblResult.text = String.init(format:"Error: %@, %@", [erro.domain, erro.userInfo["message"]])
                }
            }
            
            if let data:Dictionary = response{
                DispatchQueue.main.async {
                    self.lblResult.text = String.init(format:"Result: %@", [data])
                }
            }
        }
    }
    

    
    
//    func locationUpdate(notification:Notification){
//        print("Notification: \(notification.userInfo)")
//    }
//    
//    func locationUpdate2(notification:Notification){
//        print("Notification: \(notification.userInfo)")
//    }
    
}


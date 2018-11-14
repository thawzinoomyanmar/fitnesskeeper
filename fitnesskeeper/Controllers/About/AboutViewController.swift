//
//  AboutViewController.swift
//  fitnesskeeper
//
//  Created by user on 11/12/18.
//  Copyright © 2018 Min Aung Hein. All rights reserved.
//
//
//  ViewController.swift
//  About
//
//  Created by user on 11/5/18.
//  Copyright © 2018 App Dev. All rights reserved.
//

import UIKit
import Firebase
import LGSideMenuController
import WebKit
class AboutViewController: UIViewController,WKNavigationDelegate {
    var webView :WKWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    @IBAction func onChannelButtonWasPressed(_ sender: UIButton) {
        UIApplication.shared.open(URL(string: "https://www.facebook.com/Fitness-Keeper-929486060582299/")! as URL, options:[:] , completionHandler: nil)
    }
   
    
    @IBAction func Creditbtn(_ sender: UIButton) {
        let alert = UIAlertController(title: "Credit", message: "Thaw Zin Oo ", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
            case .default:
                print("default")
                
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
                
                
            }}))
        self.present(alert, animated: true, completion: nil)
        
        
        
    }
    
    @IBAction func versionBtn(_ sender: UIButton) {
        let alert = UIAlertController(title: "Version", message: "Version 0.1.1", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
            case .default:
                print("default")
                
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
                
                
            }}))
          self.present(alert, animated: true, completion: nil)
        
        
    }
    @IBAction func Aboutusbtn(_ sender: UIButton) {
        let alert = UIAlertController(title: "Aboutus", message: "Tech+ Solution", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
            case .default:
                print("default")
                
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
                
                
            }}))
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
    
    
    
    
    
    
    
}



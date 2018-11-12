//
//  ViewController.swift
//  About
//
//  Created by user on 11/5/18.
//  Copyright © 2018 App Dev. All rights reserved.
//

import UIKit
import WebKit
class AboutViewController: UIViewController,WKNavigationDelegate {
    var webView :WKWebView!
 
   
    override func viewDidLoad() {
        super.viewDidLoad()
      
        
    }
    @IBAction func onChannelButtonWasPressed(_ sender: UIButton) {
          UIApplication.shared.open(URL(string: "https://www.facebook.com/Fitness-Keeper-929486060582299/")! as URL, options:[:] , completionHandler: nil)
    }
    
    @IBAction func Teambtn(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Terms & Condition", message: "This application users coordinates nearest to stations arround the town and the actual notifications might differ depending upon IOS versions and devices variance. We have no responsible to loss or damage associated to the app contents and features and you do accept these terms and conditions by using City Train app.Thanks.", preferredStyle: UIAlertController.Style.alert)
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
    
    @IBAction func Creditbtn(_ sender: UIButton) {
         let alert = UIAlertController(title: "Credit", message: "Min Aung Hein\nThaw Zin Oo", preferredStyle: UIAlertController.Style.alert)
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
//    let aboutStoryBoard = UIStoryboard(name: "Main", bundle: nil)
//    
//    let aboutVC = aboutStoryBoard.instantiateViewController(withIdentifier: "aboutID") as! About
//    self.present(aboutVC, animated: false, completion: nil)

    
    
    
    
    
}


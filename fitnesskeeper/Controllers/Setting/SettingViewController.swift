//
//  SettingViewController.swift
//  fitnesskeeper
//
//  Created by Min Aung Hein on 11/12/18.
//  Copyright © 2018 Min Aung Hein. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    @IBAction func restore(_ sender: UIButton) {
        self.showBusy = true
        
         NotificationCenter.default.post(name: Notification.Name("restore"), object: nil)
         self.showBusy = false
    }
    @IBAction func unlockPremium(_ sender: Any) {
        self.showBusy = true
         NotificationCenter.default.post(name: Notification.Name("purchase"), object: nil)
         self.showBusy = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

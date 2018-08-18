//
//  SplashViewController.swift
//  fitnesskeeper
//
//  Created by Min Aung Hein on 8/11/18.
//  Copyright © 2018 Min Aung Hein. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

      
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        var runtime =   UserDefaults.standard.integer(forKey:   "runtime")
        if runtime > 0 {
            performSegue(withIdentifier: "loginsegue", sender: nil)
        }
        else {
            performSegue(withIdentifier: "onboardingsegue", sender: nil)
        }
        runtime += 1
        UserDefaults.standard.set(runtime, forKey: "runtime")
        UserDefaults.standard.synchronize() 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  LoginViewController.swift
//  fitnesskeeper
//
//  Created by Min Aung Hein on 8/11/18.
//  Copyright © 2018 Min Aung Hein. All rights reserved.
//

import UIKit
import Firebase
class LoginViewController: UIViewController {
   
var mode = 0 // for mode signin = 1
   

    @IBOutlet weak var signUpInBtn: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func SignUpSignIn(_ sender: UIButton) {

        
        
    }
    func singUp() {
        guard let email = emailTextField.text ,email != "" else{
        return
    }
        guard let pwd = passwordTextField.text ,pwd != "" else {
            return
        }
        Auth.auth().createUser(withEmail: email, password: pwd) { (user, error) in
            
           
            
        }
    }
    
    
    func signIn() {
        guard let email = emailTextField.text , email != "" else {
            return
        }
        guard let pwd = passwordTextField.text , pwd != "" else {
            return
        }
        
        Auth.auth().signIn (withEmail: email, password: pwd) { (user, error) in
            
           
          
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Token
        Auth.auth().addStateDidChangeListener{(auth, user) in
            if user != nil {
                //user is active
               
                
                
            }
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func signUp() {
        guard let email = emailTextField.text , email != "" else {
            return
        }
        guard let pwd = passwordTextField.text , pwd != ""  else {
            return
        }
        Auth.auth().createUser(withEmail: email ,password: pwd){(user, error) in#imageLiteral(resourceName: "ic_menu_white")
            if error == nil{
           
        }
        
        
    }

    func showBusy() {
        
        let busyInd = UIActivityIndicatorView()
        self.view.addSubview(busyInd)
        busyInd.activityIndicatorViewStyle = .whiteLarge
        busyInd.center = self.view.center
        busyInd.startAnimating()
        
        
    }
        func hideBusy() {
            for view in self.view.subviews {
                if view is UIActivityIndicatorView {
                    view.removeFromSuperview()
                }
            }
}
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    }}

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
   
var mode = 0 // for mode signup = 1
   

    @IBOutlet weak var signUpInBtn: UIButton!
    @IBOutlet weak var changeModeBtn: UIButton!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var lblCaution: UILabel!
    
    @IBAction func SignUpSignIn(_ sender: UIButton) {
        self.view.endEditing(true)
       self.lblCaution.text = ""
        if mode == 0 {
            signIn()
        } else if mode == 1 {
            SignUp()
        }
        
    }
    func SignUp() {
        guard let email = emailTextField.text ,email != "" else{
        return
    }
        guard let pwd = passwordTextField.text ,pwd != "" else {
            return
        }
        Auth.auth().createUser(withEmail: email, password: pwd) { (user, error) in
            
            if error == nil {
             
             self.hideBusy()
                
            }
            else {
                self.hideBusy()
                
                print(error?.localizedDescription)
            }

            
        }
    }
    
    
    func signIn() {
        guard let email = emailTextField.text , email != "" else {
            return
        }
        guard let pwd = passwordTextField.text , pwd != "" else {
            return
        }
        
        Auth.auth().signIn (withEmail: self.emailTextField.text!, password: self.passwordTextField.text!) { (user, error) in
           
            let dialog = UIAlertController(title: error!.localizedDescription, message: "", preferredStyle: UIAlertControllerStyle.alert)
            dialog.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            DispatchQueue.main.async(execute: {
                self.present(dialog, animated: true, completion: nil)
            })//Alert Error Message
            
//            if let error = error {
//                print(error.localizedDescription)
//           self.lblCaution.text = "\(error.localizedDescription)"
//            }
//            else if let user = user {
//                print (user)
//                self.lblCaution.text = " \(email)"
            //            }(NOTE: Label Show in View Controller Page)
          
        }
    }
    
    
    @IBAction func changeMode(_ sender: UIButton) {
        
        mode == 0 ?( mode = 1) : (mode  = 0)
        switch mode {
            case  0: setLoginUI( )
            case  1:setSignUpUI( )
        default: break
        }
        
    }
    
            func setLoginUI( ) {
                self.signUpInBtn.setTitle("Log In", for: .normal)
                self.changeModeBtn.setTitle("New user? Sign Up", for: .normal)
            }
            func setSignUpUI( ) {
                self.signUpInBtn.setTitle("Sign up", for: .normal)
                self.changeModeBtn.setTitle("Already register? Log In", for: .normal)
                
            }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
       setLoginUI()
        Auth.auth().addStateDidChangeListener{(auth, user) in
            if user != nil {
                //user is active
               self.loadHomeVC()
                
                
            }
        }
        
    }

    //MARK: Load HomeVC
    func loadHomeVC( ) {
        let sb =  UIStoryboard(name: "ExerciseStoryboard", bundle: nil)
        if  let homeVC = sb.instantiateInitialViewController() as? UINavigationController {
            present(homeVC, animated: true, completion: nil)
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
        
     
        
    
    
}


//
//  LoginViewController.swift
//  fitnesskeeper
//
//  Created by Min Aung Hein on 8/11/18.
//  Copyright © 2018 Min Aung Hein. All rights reserved.
//

import UIKit
import Firebase
import LGSideMenuController
class LoginViewController: UIViewController {
   //sideMenuVC?.showLeftView(animated: true, completionHandler: nil)
var mode = 0 // for mode signup = 1
   

    @IBOutlet weak var loginUIView: UIView!
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
            self.hideBusy()
            if let error =  error {
                self.alert(title: "Error", message: error.localizedDescription   )
            }else {
                //Login Success
                self.clearInputField()
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
        self.showBusy()
        Auth.auth().signIn (withEmail: self.emailTextField.text!, password: self.passwordTextField.text!) { (user, error) in
           self.hideBusy()
            if let error =  error {
                self.alert(title: "Error", message: error.localizedDescription   )
            }
            else {
                //Login Success
                self.clearInputField()
            }
          
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
    func  clearInputField(){
        self.emailTextField.text = ""
        self.passwordTextField.text = ""
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
       setLoginUI()
        loginUIView.backgroundColor = Default.backgroundColor
       view.backgroundColor = Default.backgroundColor
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
        if  let homeVC = sb.instantiateInitialViewController() as?  LGSideMenuController {
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


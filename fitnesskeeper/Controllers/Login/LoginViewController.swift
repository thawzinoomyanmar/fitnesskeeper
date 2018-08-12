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
    
    @IBAction func SignUpSignIn(_ sender: UIButton) {

        if mode == 0 {
            signIn()
        } else if mode == 1 {
            singUp()
        }
        
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
        
     
        
    
    
}
}

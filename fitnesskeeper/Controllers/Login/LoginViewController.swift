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
     self.showBusy()
        if mode == 0{
            signUp()
        }
        else if mode == 1 {
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
            
            if error == nil {
                print(user?.uid, user?.email, user?.displayName)
                self.hideBusy()
                //self.proceedNextScreen()
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
        
        Auth.auth().signIn (withEmail: email, password: pwd) { (user, error) in
            
            if error == nil {
                self.hideBusy()
                print(user?.uid, user?.email, user?.displayName)
                //self.proceedNextScreen()
            }
            else {
                self.hideBusy()
                print(error?.localizedDescription)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Token
        Auth.auth().addStateDidChangeListener{(auth, user) in
            if user != nil {
                //user is active
                self.proceedNextScreen()
                
                
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
                print(user?.uid, user?.email, user?.displayName)
                self.hideBusy()
            }
            else {
                self.hidBusy()
                print(error?.localizedDescription)
                
            }
        }
        
        
    }

    func showBusy() {
        
        let busyInd = UIActivityIndicatorView()
        self.view.addSubview(busyInd)
        busyInd.activityIndicatorViewStyle = .whiteLarge
        busyInd.center = self.view.center
        busyInd.startAnimating()
        
        
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

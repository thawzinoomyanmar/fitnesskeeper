//
//  ChooseNavigationController.swift
//  LGSideMenuControllerDemo
//
import LGSideMenuController
class ChooseNavigationController: UINavigationController {

    override var shouldAutorotate : Bool {
        return true
    }
    
//    override var prefersStatusBarHidden : Bool {
//        return UIInterfaceOrientation.isLandscape(UIApplication.shared.statusBarOrientation) && UI_USER_INTERFACE_IDIOM() == .phone
//    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    
    
    
    override var preferredStatusBarUpdateAnimation : UIStatusBarAnimation {
        return .none
    }

}

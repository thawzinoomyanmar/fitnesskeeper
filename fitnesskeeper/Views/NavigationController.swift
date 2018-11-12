//
//  NavigationController.swift
//  LGSideMenuControllerDemo
//
import LGSideMenuController
class NavigationController: UINavigationController {

    override var shouldAutorotate : Bool {
        return true
    }
    
//    override var prefersStatusBarHidden : Bool {
//        return UIInterfaceOrientation.isLandscape(UIApplication.shared.statusBarOrientation) && UI_USER_INTERFACE_IDIOM() == .phone
//    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .default
    }
    
    override var preferredStatusBarUpdateAnimation : UIStatusBarAnimation {
        return sideMenuController!.isRightViewVisible ? .slide : .fade
    }

}

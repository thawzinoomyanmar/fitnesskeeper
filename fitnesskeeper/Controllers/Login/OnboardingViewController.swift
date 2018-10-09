//
//  OnboardingViewController.swift
//  template01
//
//  Created by MAH on 12/11/17.
//  Copyright © 2017 MAH. All rights reserved.
//

import UIKit
import paper_onboarding

class OnboardingViewController:UIViewController, PaperOnboardingDataSource, PaperOnboardingDelegate {
    
    
    
    @IBOutlet weak var getStartButton:UIButton!
    
    func onboardingWillTransitonToIndex(_ index: Int) {
        if index == 3 {
            UIView.animate(withDuration: 0.4, delay: 0.8, options: .curveEaseIn, animations: {
                self.getStartButton.alpha = 1.0
            }, completion: { ( status ) in
                
            })
            
        }
        else {
            self.getStartButton.alpha = 0.0
        }
        
    }
    
    func onboardingDidTransitonToIndex(_ index: Int) {
        
    }
    
    func onboardingConfigurationItem(_ item: OnboardingContentViewItem, index: Int) {
        
    }
    
    @IBAction func getStart(_ sender: UIButton) {
        
        performSegue(withIdentifier: "onboard2homeviewid", sender: nil)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func onboardingItem(at index: Int) -> OnboardingItemInfo {
        
        let textColor =  Default.tabarColor
        let backgroundColor1 =  UIColor.white
        let backgroundColor2 =  UIColor.white
        let backgroundColor3 =  UIColor.white
        let backgroundColor4 =  UIColor.white
        let iconImage =  UIImage(named:"runningman.png")!
        let descriptionColor  = UIColor.lightGray
        let textFont =  UIFont.systemFont(ofSize: 30)
        let descriptionFont = UIFont.boldSystemFont(ofSize: 20)
        //imageName: String, title: String, description: String, iconName: String, color: UIColor, titleColor: UIColor, descriptionColor: UIColor, titleFont: UIFont, descriptionFont: UIFont)
        
        let info1 = OnboardingItemInfo(informationImage: UIImage(named:"screen1.png")!, title: "Pro Fitness Tracker", description: "Keeping Track of Various Activities and its siblings", pageIcon: iconImage, color: backgroundColor1, titleColor: textColor, descriptionColor: descriptionColor, titleFont: textFont, descriptionFont:descriptionFont)
        let info2 = OnboardingItemInfo(informationImage: UIImage(named:"screen2.png")!, title: "Fantastic Activities", description: "Walking, Jogging, Swimming, Gym and Workouts , Martial Art, Yoga and many more...", pageIcon:iconImage, color: Default.tabarColor , titleColor: Default.runningManColor, descriptionColor: UIColor.white, titleFont: textFont, descriptionFont:descriptionFont)
        let info3 = OnboardingItemInfo(informationImage: UIImage(named:"screen3.png")!, title: "Details matters", description: "Every activity comes with informational, applicable hand-on and supportive descriptions", pageIcon: iconImage, color: backgroundColor3, titleColor: textColor, descriptionColor: descriptionColor,  titleFont: textFont, descriptionFont:descriptionFont)
        let info4 = OnboardingItemInfo(informationImage: UIImage(named:"screen4.png")!, title: "Recordable history", description: "Review your activities and leap forward to next level ", pageIcon:iconImage, color: Default.tabarColor , titleColor: Default.runningManColor, descriptionColor: UIColor.white, titleFont: textFont, descriptionFont:descriptionFont)
        
        return [info1,info2,info3,info4
            ][index]
    }
    
    func onboardingItemsCount() -> Int {
        return 4
    }
    
    
    
    
}


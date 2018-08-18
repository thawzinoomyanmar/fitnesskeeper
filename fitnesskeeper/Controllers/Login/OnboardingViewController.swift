//
//  OnboardingViewController.swift
//  fitnesskeeper
//
//  Created by Min Aung Hein on 8/11/18.
//  Copyright © 2018 Min Aung Hein. All rights reserved.
//

import UIKit
//import paper_onboarding
class OnboardingViewController: UIViewController   { //} ,PaperOnboardingDelegate,PaperOnboardingDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Showing onbarding...")
    }
      /*  onboarding.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(onboarding)
        
        if (onboarding.currentIndex == 0) {
            let button1 = UIButton()
            button1.frame = CGRect(x: 20, y: 40, width: 200, height: 100)
            button1.backgroundColor = UIColor.black
            
            button1.setTitle("accountsignup", for: .normal)
            
            button1.layer.masksToBounds = false
            button1.layer.cornerRadius = 10
            view.addSubview(button1)
        }
        //view.addSubview(button1)
        
        // add constraints
        for attribute: NSLayoutAttribute in [.left, .right, .top, .bottom] {
            let constraint = NSLayoutConstraint(item: onboarding,
                                                attribute: attribute,
                                                relatedBy: .equal,
                                                toItem: view,
                                                attribute: attribute,
                                                multiplier: 1,
                                                constant: 0)
            view.addConstraint(constraint)
        }
    }
    
    
    func onboardingItem(at index: Int) -> OnboardingItemInfo {
        
        
        
        
        return [
            OnboardingItemInfo(informationImage: #imageLiteral(resourceName: "logo"),
                               title: "title",
                               description: "description",
                               pageIcon: #imageLiteral(resourceName: "logo"),
                               color: UIColor.red,
                               titleColor: UIColor.white,
                               descriptionColor: UIColor.white,
                               titleFont: UIFont.boldSystemFont(ofSize: 12),
                               descriptionFont: UIFont.boldSystemFont(ofSize: 14)),
            
            OnboardingItemInfo(informationImage: #imageLiteral(resourceName: "logo"),
                               title: "title",
                               description: "description",
                               pageIcon: #imageLiteral(resourceName: "logo"),
                               color: UIColor.green,
                               titleColor: UIColor.red,
                               descriptionColor: UIColor.blue,
                               titleFont: UIFont.boldSystemFont(ofSize: 12),
                               descriptionFont: UIFont.boldSystemFont(ofSize: 14)),
            
            OnboardingItemInfo(informationImage: #imageLiteral(resourceName: "logo"),
                               title: "title",
                               description: "description",
                               pageIcon: #imageLiteral(resourceName: "logo"),
                               color: UIColor.red,
                               titleColor: UIColor.green,
                               descriptionColor: UIColor.blue,
                               titleFont: UIFont.boldSystemFont(ofSize: 12),
                               descriptionFont: UIFont.boldSystemFont(ofSize: 14))
            ][index]
    }
    
    func onboardingItemsCount() -> Int {
        return 3
    }*/
        

}

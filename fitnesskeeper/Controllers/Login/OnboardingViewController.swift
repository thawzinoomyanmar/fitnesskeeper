//
//  OnboardingViewController.swift
//  fitnesskeeper
//
//  Created by Min Aung Hein on 8/11/18.
//  Copyright © 2018 Min Aung Hein. All rights reserved.
//

import UIKit
import paper_onboarding

class OnboardingViewController: UIViewController,PaperOnboardingDataSource,PaperOnboardingDelegate {
    var onboarding = PaperOnboarding()
    override func viewDidLoad() {
        super.viewDidLoad()
        onboarding.dataSource = self
        onboarding.delegate = self
        onboarding.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(onboarding)
        
//        if (onboarding.currentIndex == 2) {
//            let button1 = UIButton()
//            button1.frame = CGRect(x: 20, y: 40, width: 200, height: 100)
//            button1.backgroundColor = UIColor.black
//            //.init(red: 251/255, green: 33/255, blue: 38/255, alpha: 1)
//            button1.setTitle("accountsignup", for: .normal)
//            //        button1.layer.shadowColor = UIColor.init(red: 254/255, green: 234/255, blue: 233/255, alpha: 1).cgColor
//            //        button1.layer.shadowOffset = CGSize(width: 0.0, height: 20.0)
//            //        button1.layer.shadowOpacity = 0.8
//            //        button1.layer.shadowRadius = 0.0
//            button1.layer.masksToBounds = false
//            button1.layer.cornerRadius = 10
//            view.addSubview(button1)
//        }
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func onboardingItemsCount() -> Int {
        return 3
    }
    
    func onboardingItem(at index: Int) -> OnboardingItemInfo {
        return [
            OnboardingItemInfo(informationImage: #imageLiteral(resourceName: "logo"),
                               title: "title",
                               description: "description",
                               pageIcon: #imageLiteral(resourceName: "logo"),
                               color: UIColor.red,
                               titleColor: UIColor.black,
                               descriptionColor: UIColor.black,
                               titleFont: UIFont.boldSystemFont(ofSize: 18),
                               descriptionFont: UIFont.boldSystemFont(ofSize: 16)),
            
            OnboardingItemInfo(informationImage: #imageLiteral(resourceName: "logo"),
                               title: "title",
                               description: "description",
                               pageIcon: #imageLiteral(resourceName: "logo"),
                               color: UIColor.green,
                               titleColor: UIColor.black,
                               descriptionColor: UIColor.black,
                               titleFont: UIFont.boldSystemFont(ofSize: 18),
                               descriptionFont: UIFont.boldSystemFont(ofSize: 16)),
            
            OnboardingItemInfo(informationImage: #imageLiteral(resourceName: "logo"),
                               title: "title",
                               description: "description",
                               pageIcon: #imageLiteral(resourceName: "logo"),
                               color: UIColor.blue,
                               titleColor: UIColor.black,
                               descriptionColor: UIColor.black,
                               titleFont: UIFont.boldSystemFont(ofSize: 18),
                               descriptionFont: UIFont.boldSystemFont(ofSize: 16))
            ][index]
    }
    func onboardingConfigurationItem(item: OnboardingContentViewItem, index: Int) {
        
        
        
            item.titleLabel?.backgroundColor = UIColor.white
            item.descriptionLabel?.backgroundColor = UIColor.white
//            item.imageView = ...
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

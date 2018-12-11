//
/*------------------------------------------------------------------------------
  
  This source is part of the Thaw Zin Oo and Team Members.
  Copyright  2018,2019, Thaw Zin Oo and/or its affiliates. All rights reserved.
  
  No part of this work may be reproduced, stored in a retrieval system,
  adopted or transmitted in any form or by any means, electronic, mechanical,
  photographic, graphic, optic recording or otherwise, translated in any language
  or computer language, without the prior written permission of Thaw Zin Oo and its affiliates.
  

  Yangon,
  Myanmar.
  
  Modification History
  
  Date        Version        Author               Description
  ----------  -----------    ---------------      ----------------------------------------
  <#Date DD/MM/YYYY#>  <#1.0#>            <#Your Name#>        Initial Version
  
  
  ------------------------------------------------------------------------------*/

import UIKit
import Kingfisher
class ExerciseInfoViewController: UIViewController {

    var activity:Activity! //will allocate later , given by other
    var totalRecord:Int!
    
    @IBOutlet weak var exerciseImageView: UIImageView!
    
    @IBOutlet weak var execiseTitle: UILabel!
    
    @IBOutlet weak var exerciseDescTextView: UITextView!
    
    
    @IBAction func addActivity(_ sender:UIButton) {
       
        
        let addActivityVC = AddNewActivityViewController(nibName: "AddNewActivityViewController", bundle: nil)
        addActivityVC.activity =  activity
        
        if totalRecord > 20 {
            if checkIAPStatus()  {
               
             navigationController?.pushViewController(addActivityVC, animated: true)
        } else {
            self.alert(title: "Unlock Premium", message: "Adding more than 20 records required to unlock premium features", actionStrings: ["Cancel","Proceed"]) { (action) in
                if action.title == "Proceed" {
                        self.showBusy = true
                        self.purchasePremium()
                }
            }
        
        }
        } else {
              navigationController?.pushViewController(addActivityVC, animated: true)
        }
//        navigationController?.viewControllers.first?.present(addActivityVC, animated: true, completion: {
//                    self.navigationController?.popViewController(animated: false )
//        })
        
        
    }
    func  purchasePremium() {
         NotificationCenter.default.post(name: Notification.Name("purchase"), object: nil)
    }
    
    func checkIAPStatus()-> Bool  {
           return  UserDefaults.standard.bool(forKey: "premium")
    }
    func setIAPStatus()   {
          UserDefaults.standard.set(true, forKey: "premium")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        execiseTitle.text = activity.name
        exerciseDescTextView.text = activity.desc
        
        
        if let imageURLs = activity.imageURLs , let firstImageStr =  imageURLs.first {
            let url =     URL(string:  firstImageStr)!
            exerciseImageView.kf.indicatorType =  .activity
            exerciseImageView.kf.setImage(with: url)
        }
        
       

       NotificationCenter.default.addObserver(self, selector: #selector(updatePremiumstate), name: Notification.Name("premiumpurchased"), object: nil)
    }
    
    @objc func  updatePremiumstate( ) {
        setIAPStatus()
        addActivity(UIButton())
        self.showBusy = false
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

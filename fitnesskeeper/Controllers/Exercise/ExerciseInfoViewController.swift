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
    
    
    @IBOutlet weak var exerciseImageView: UIImageView!
    
    @IBOutlet weak var execiseTitle: UILabel!
    
    @IBOutlet weak var exerciseDescTextView: UITextView!
    
    
    @IBAction func addActivity(_ sender:UIButton) {
       
        let addActivityVC = AddNewActivityViewController(nibName: "AddNewActivityViewController", bundle: nil)
        addActivityVC.activity =  activity
        
        navigationController?.viewControllers.first?.present(addActivityVC, animated: true, completion: {
                    self.navigationController?.popViewController(animated: false )
        })
        
        //navigationController?.pushViewController(addActivityVC, animated: true)
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
        
       

        // Do any additional setup after loading the view.
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

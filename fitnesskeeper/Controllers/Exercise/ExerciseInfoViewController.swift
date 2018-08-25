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
    @IBOutlet weak var exerciseImageView: UIImageView!
    @IBOutlet weak var exercisetitle:UILabel!
    @IBOutlet weak var exerciseDescTextView:UITextView! 
    var activity:Activity! //will allocate later , given by other 
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addActivity(_sender:UIButton){
        let addActivityVC = AddNewAcitivityViewController(nibName:"AddNewActivityViewController",bundle:nil)
        addActivityVC.activity = activity
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

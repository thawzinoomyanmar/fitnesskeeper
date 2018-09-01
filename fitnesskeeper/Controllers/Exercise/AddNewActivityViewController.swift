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
import Eureka
/*
 
 
 
 
 private var _unit:String = ""
 var unit :String { return _unit }
 var   imageURLs:[String]?
 
 
 
 
 var remark = ""*/
class AddNewActivityViewController: FormViewController {
    
    var activity:Activity!
    
    override func viewDidLoad() {
        super.viewDidLoad()
<<<<<<< Updated upstream

         setup( )
       constructInputForm( )
        // Do any additional setup after loading the view.
    }
    
    func setup() {
        let rightSaveBtn = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(save))
        navigationItem.setRightBarButton(rightSaveBtn, animated: false)
    }
    
    
    func constructInputForm( ) {
=======
        setup()
        constructInputForm() }
    func constructInputForm()
    {
         
>>>>>>> Stashed changes
        form
            +++  Section()
            
            <<< LabelRow() { row in
                row.title = "Activity Name"
                row.value = activity.name
            }
            
            <<< PickerInlineRow<Int>("Duration"){ row in
                row.options  =  [1 ,2,3,4,5,6,7,8,9,10]
                row.title = "Duration"
            }
            
            <<< PickerInlineRow<Int>("times"){ row in
                row.options  =  [1 ,2,3,4,5,6,7,8,9,10]
                row.title = "Times"
        }
        
        if let rep = activity.reps {
            form.allSections.first! <<<  PickerInlineRow<Int>("reps"){ row in
                row.options  =  [1 ,2,3,4,5,6,7,8,9,10]
                row.title = "Reps"
            }
        }
<<<<<<< Updated upstream
        
        form.allSections.first! <<< PickerInlineRow<String>("unit"){ row in
            row.options  =   activity.units
            row.title = "Unit"
            row.value = activity.units.first ?? ""
        }
=======
            
        form.allSections.first! <<< PickerInlineRow<String>(){ row in
                row.options  =   activity.unit 
                row.title = "Unit"
                row.value = activity.unit.first ?? ""
            }
            
             form.allSections.first!  <<< TextAreaRow  ( "remark") { row in
                row.placeholder = "Note here"
        }
        
       
>>>>>>> Stashed changes
        
        form.allSections.first!  <<< TextAreaRow  ( "remark") { row in
            row.placeholder = "Note here"
        }
    }

    @objc func save( ) {
        let values =  form.values()
        //check for non optional fields , duration / times
        guard let duration =  values["Duration"] as? Int else  {
            return
        }
        guard let times =  values["times"] as? Int, times > 0 else {
            return
        }
        let reps =  values["reps"] as? Int
        let unit =  values["units"] as? String
        let remark = values["remark"] as? String
        
        activity.duration = TimeInterval( duration ) ?? 0
         activity.reps =  reps
        activity.remark = remark ?? ""
        activity.freq = times ?? 0
        activity.unit = unit ?? ""
        
          //  self.navigationController?.popViewController(animated: true )
            //self.dismiss(animated: true, completion: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

/*(<<< PickerInlineRow<String>(){
 
 $0.options = DefaultValue.radiusArray
 
 //                displayValueFor = {
 //                    guard let date = $0 else {
 //                        return nil
 //                    }
 //                    let hour = Calendar.current.component(.hour, from: date)
 //                    let min = Calendar.current.component(.minute, from: date)
 //                    if hour == 1 {
 //                        return "\(hour) hour \(min) min"
 //                    }
 //                    return "\(hour) hours \(min) min"
 //                }
 //$0.value = $0.options.first
 let defaultDist = AppState.shared.distanceRange / 1000
 $0.title =     "\(defaultDist) km"
 }.onChange({ (row) in
 debugPrint("cell change")
 if let value = row.value, value != ""  {
 row.title =  value  + " km"
 row.value = ""
 //                        row.displayValueFor = { value in
 //                            return row.value! + " km"
 //                        }
 self.newDistance =  Int( value )! *  1000
 }
 }).onCellSelection({ (cell, row) in
 
 }).onExpandInlineRow({ (cell, row, pickerrow) in
 
 //row.value = String( AppState.shared.distanceRange / 1000)
 
 
 })
*/

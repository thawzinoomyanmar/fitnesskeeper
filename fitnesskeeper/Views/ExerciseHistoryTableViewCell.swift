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

class ExerciseHistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var exerciseImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var freqLabel: UILabel!
 
    @IBOutlet weak var setsLabel: UILabel!
    @IBOutlet weak var repsLabel: UILabel!
    @IBOutlet weak var techniqueLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func config(_ activity:Activity) {
        if let imageURLs = activity.imageURLs, let firstImageStr = imageURLs.first {
            let url = URL(string: firstImageStr)
            exerciseImageView.kf.indicatorType = .activity
            exerciseImageView.kf.setImage(with: url)
        }
        
        titleLabel.text =  activity.name
        if let distance =  activity.distance, distance > 0 {
                distanceLabel.text = String(distance) + " " +  activity.unit
        }
        else {
            distanceLabel.isHidden = true
        }
        
        if activity.duration  > 0 {
            durationLabel.text = String(activity.duration) + " " +  activity.unit
        }
        else {
            durationLabel.isHidden = true
        }
        if    activity.freq > 0 {
            freqLabel.text = String(activity.freq)  
        }
        else {
            freqLabel.isHidden = true
        }
        if   let sets =  activity.sets, sets  > 0 {
            setsLabel.text = String(sets)
        }
        else {
            setsLabel.isHidden = true
        }
        
        if   let reps =  activity.reps, reps  > 0 {
            repsLabel.text = String(reps)
        }
        else {
            repsLabel.isHidden = true
        }
        if   let technique =  activity.technique {
            techniqueLabel.text = technique
        }
        else {
            techniqueLabel.isHidden = true
        }
        
        let formatter =  DateFormatter()
       let exeDate =  activity.date
        dateLabel .text = String(describing:Date())
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

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

    
    @IBOutlet weak var distanctStackView: UIStackView!
    @IBOutlet weak var durationStackView: UIStackView!
    @IBOutlet weak var freqStackView: UIStackView!
    @IBOutlet weak var setStackView: UIStackView!
    @IBOutlet weak var repsStackView: UIStackView!
    @IBOutlet weak var techniqueStackView: UIStackView!
    @IBOutlet weak var dateStackView: UIStackView!
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
            distanctStackView.isHidden = false 
        }
        else {
            distanctStackView.isHidden = true
        }
        
        if activity.duration  > 0 {
            durationLabel.text = String(activity.duration) + " " +  activity.unit
            durationStackView.isHidden = false
        }
        else {
            durationStackView.isHidden = true
        }
        if    activity.freq > 0 {
            freqLabel.text = String(Float(activity.freq))
            freqStackView.isHidden = false
        }
        else {
            freqStackView.isHidden = true
        }
        if   let sets =  activity.sets, sets  > 0 {
            setsLabel.text = String(sets)
            setStackView.isHidden = false
        }
        else {
            setStackView.isHidden = true
        }
        
        if   let reps =  activity.reps, reps  > 0 {
            repsLabel.text = String(reps)
            repsStackView.isHidden = false 
        }
        else {
            repsStackView.isHidden = true
        }
        if   let technique =  activity.technique, technique != "" {
            techniqueLabel.text = technique
            techniqueStackView.isHidden = false
        }
        else {
            techniqueStackView.isHidden = true
        }
        
        let formatter =  DateFormatter()
        formatter.dateFormat = "MMM-dd-YY ( hh:mm )"
        dateLabel .text =   formatter.string(from: activity.date ?? Date() )
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

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


class ExerciseListsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var exerciseImage: UIImageView!
    
    @IBOutlet weak var exerciselbl: UILabel!
    
    func config(_ activity:Activity) {
        self.backgroundColor =  Default.cellBkColor
        exerciselbl.text =  activity.name
        if let firstImageStr =  activity.imageURLs?.first, firstImageStr != ""  {
            exerciseImage.kf.indicatorType = .activity
            exerciseImage.kf.setImage(with: URL(string:firstImageStr))
        }
        
        if let imageURLs = activity.imageURLs, let firstImageStr = imageURLs.first {
            let url = URL(string: firstImageStr)
            exerciseImage.kf.indicatorType = .activity
             exerciseImage.kf.setImage(with: url)
        }
        
    }
}

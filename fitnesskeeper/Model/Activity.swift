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
  18/08/2018  1.0            Min Aung Hein        Initial Version
 
  
  
  ------------------------------------------------------------------------------*/
/*
 
 "remark" : "",
 "unit" : "m",
 "urls" : [ "firebasestorage.googleapis.com", "" ]*/
import Foundation

class Activity {
    private var _id:Int
    
    var id:Int {return _id }
    
   private  var _name:String
    var name:String { return _name }
    
    var reps:Int? = nil
    
    var desc:String
    private var _unit:[String] =  [String]()
    var units :[String] { return _unit }
    var unit : String = ""
    var   imageURLs:[String]?
    
    
    var duration:TimeInterval  = 0
    var freq:Int = 0
    var remark = ""
    
    init(id:Int, name:String ,desc:String, unit:[String] ) {
        self._id = id
        self._name = name
        self.desc = desc
        self._unit = unit
    }
}



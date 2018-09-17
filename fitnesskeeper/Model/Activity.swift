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
import Firebase

//class FirebaseManager{
//    static var main = FirebaseManager()
//    func save(_activity : Activity,forUserId:String )
//    {
//        let dbRef = Database.database().reference()
//        let userActivity = dbRef.child(forUserId).child("Activity")
//        let newRecordID = userActivityDbRef.childByAutoId()
//        newRecordID.setValue(["id":_activity.id,"duration":activity.duration,"freq":activity.freq,"unit":activity.unit])
//    }
//}


class FirebaseManager {
    static var main =  FirebaseManager( )
  
 
    func save(_ activity:Activity, forUserId:String  ) {
        let currentTime =  Date().timeIntervalSince1970 ?? 0.0
        let dbRef =  Database.database().reference()
        let userActivityDbRef = dbRef.child(forUserId).child("Activity")
        let newRecordID = userActivityDbRef.childByAutoId()
        
        let weight = activity.weight ?? 0
        let dist = activity.distance ?? 0
        let url = (activity.imageURLs?.first ?? "")
        newRecordID.setValue(["id": activity.id ,"name": activity.name , "duration": activity.duration,"weight": weight , "freq": activity.freq, "unit": activity.unit ,"distance": dist,"date": currentTime , "url": url] )
    }
}



class Activity {
    private var _id:Int
    
    var id:Int {return _id }
    
   private  var _name:String
    var name:String { return _name }
    
    var reps:Int? = nil
    var subActivities:[Activity] = [Activity]( )
    var desc:String
    private var _units:[String] =  [String]()
    var units :[String] { return _units }
    var unit : String = ""
    var   imageURLs:[String]?
    
    var distance: Float? = 0.0
    var sets:Int? =  0
    var weight:Float? = 0.0
    var duration:TimeInterval  = 0
    var date:Date?
    var technique:String? 
    var freq:Int = 1
    var remark = ""
    
    init(id:Int, name:String ,desc:String, unit:[String] ) {
        self._id = id
        self._name = name
        self.desc = desc
        self._units = unit
    }
    
    init(id:Int, name:String , unit:String ) {
        self._id = id
        self._name = name
        self.desc = ""
        self.unit = unit
    }
    
    //Methods
    func save(_ uid:String) {
        FirebaseManager.main.save(self, forUserId: uid)
    }
}



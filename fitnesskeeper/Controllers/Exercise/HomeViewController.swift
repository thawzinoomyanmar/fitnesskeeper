    //
//  HomeViewController.swift
//  fitnesskeeper
//
//  Created by Min Aung Hein on 8/11/18.
//  Copyright © 2018 Min Aung Hein. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {
    
    
    var activities = [Activity]()
    var historyActivities = [Activity]()
    var isSubActivities =  false
    
    var activitiyCellWidth:CGFloat = 0
     var activitiyCellHeight :CGFloat = 0
    var hGap:CGFloat = 2
    var colPerRows:CGFloat = 3
    @IBOutlet weak var exerciseListCollection: UICollectionView!
    @IBOutlet weak var historyTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        historyTableView.dataSource = self
        historyTableView.delegate = self
       setup()
     
        
    }
    
    func setup()  {
        let segmentCtrl = UISegmentedControl()
        segmentCtrl.insertSegment(withTitle: "Activity", at: 0, animated: false)
         segmentCtrl.insertSegment(withTitle: "History", at: 1, animated: false)
        segmentCtrl.frame = CGRect(x: 0, y: 0, width: view.frame.size.width / 2 , height: (self.navigationController?.navigationBar.frame.size.height)! - 20 )
        
        self.navigationItem.titleView = segmentCtrl
        segmentCtrl.selectedSegmentIndex = 0
        segmentCtrl.addTarget(self, action:  #selector(clickSegment(_:)) , for: .valueChanged)
        segmentCtrl.tintColor =  Default.segmentTintColor
        
        activitiyCellWidth = ( self.view.frame.width - hGap * ( colPerRows - 1) ) / colPerRows
        activitiyCellHeight =  activitiyCellWidth * 1.2
        exerciseListCollection.delegate = self
        
        if !isSubActivities {
            addObserver( )
        }
       
        
        
 
        
    }
    
    
    @objc func clickSegment(_ segment: UISegmentedControl) {
        if segment.selectedSegmentIndex == 0 {
            exerciseListCollection.isHidden = false
        } else {
             exerciseListCollection.isHidden = true 
        }
         historyTableView.isHidden = !exerciseListCollection.isHidden
        
        
    }
    
    func addObserver( ) {
        let dbRef =  Database.database().reference()
        let activityRef =  dbRef.child("Activities")
        let historyRef =  dbRef.child(Auth.auth().currentUser?.uid ?? "").child("Activity")
        
        
        activityRef.observe(.value) { (ss) in
            if  let  value = ss.value as? [String:Any] {
                self.activities.removeAll() //***
                for (k,v) in value  {
                    
                    if  let activity = v as? [String:Any] {
                        let id = activity["id"] as? Int
                        let duration = TimeInterval ( activity["duration"] as? Int ?? 0 )
                        let hasSC:Bool = activity["hasSC"] as? Bool ?? false
                        let desc =  activity["desc"] as? String
                        let freq = activity["freq"] as?  Int
                        let name = activity["name"] as? String
                        let remark = activity["remark"] as? String
                        let unit = ( activity["unit"] as? [String] ) ?? [""]
                        let urls:[String]? =  activity["urls"]  as? [String]
                        let reps:Int? = activity["reps"] as? Int
                        let distance:Float? = activity["distance"] as? Float
                        let weight:Float? = activity["weight"] as? Float
                        let parentID:Int? = activity["parentid"] as? Int
                        
                        if let id = id , let name = name , let desc = desc, parentID == nil  {
                            let activity = Activity(id: id, name: name, desc: desc, unit: unit)
                            self.activities.append(activity)
                            activity.duration = duration
                            
                            if let freq = freq {
                                activity.freq = freq
                            }
                            if let remark = remark {
                                activity.remark = remark
                            }
                            
                            if let urls = urls {
                                activity.imageURLs = urls
                            }
                            
                            activity.reps = reps
                            activity.distance = distance
                            activity.weight =  weight 
                        }
                        else if let id = id , let name = name , let desc = desc , parentID != nil { //for sub cat
                            let subactivity = Activity(id: id, name: name, desc: desc, unit: unit)
                            
                            for parent in self.activities {
                                if parent.id    == parentID {
                                    parent.subActivities.append(subactivity)
                                }
                            }
                        }
                    }
                }
                self.activities.sort(by: { (a, b) -> Bool in
                    return  a.id < b.id
                })
                 self.exerciseListCollection.reloadData()
            }
        }
        
        historyRef.observe(.value) { (ss) in
            if  let  value = ss.value as? [String:Any] {
                self.historyActivities.removeAll() //***
                for (k,v) in value  {
                    
                    if  let activity = v as? [String:Any] {
                        let id = activity["id"] as? Int
                        let duration = TimeInterval ( activity["duration"] as? Int ?? 0 )
                        let freq = activity["freq"] as?  Int
                        let name = activity["name"] as? String
                        let remark = activity["remark"] as? String
                        let unit = activity["unit"] as? String
                        let url = activity["url"] as? String
                        let reps:Int? = activity["reps"] as? Int
                        let distance:Float? = activity["distance"] as? Float
                        let weight:Float? = activity["weight"] as? Float
                        let dateValue:Float? = activity["date"] as? Float
                        
                        if let id = id , let name = name   {
                            let activity = Activity(id: id, name: name, unit: unit ?? "")
                            self.activities.append(activity)
                            activity.duration = duration
                            
                            if let freq = freq {
                                activity.freq = freq
                            }
                            if let remark = remark {
                                activity.remark = remark
                            }
                            
                            if let url = url {
                                activity.imageURLs = [url]
                            }
                            
                            activity.reps = reps
                            activity.distance = distance
                            activity.weight =  weight
                            if let dateValue = dateValue {
                                activity.date =  Date.init(timeIntervalSince1970: TimeInterval(dateValue))
                            }
                            self.historyActivities.append(activity)
                        }
                    }
                }
                
                self.historyTableView.reloadData()
            }
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        //TODO: Load exe info in proper place
       // let exerciseInfoVC =  UIViewController(nibName: "ExerciseInfoViewController", bundle: nil)
        //self.navigationController?.pushViewController(exerciseInfoVC, animated: true)
        //present(exerciseInfoVC, animated: true, completion: nil)
    }
}

    
    
    //MARK: Collection View
extension HomeViewController:  UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return activities.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = exerciseListCollection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? ExerciseListsCollectionViewCell
        let currentActivity =   activities[indexPath.row]
        cell?.config(currentActivity )
      
       
        return cell!
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let currentActivity = activities[indexPath.row] //**
        if  currentActivity.subActivities.count > 0 {
            
            guard let vc = storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController else {
                    return
                }
                vc.activities =  currentActivity.subActivities
                vc.isSubActivities = true
                navigationController?.pushViewController(vc, animated: true)
        }
    else {
            let exerciseInfoVC = ExerciseInfoViewController(nibName: "ExerciseInfoViewController", bundle: nil)
        exerciseInfoVC.activity = currentActivity
            navigationController?.pushViewController(exerciseInfoVC, animated: true)
        }
    }
    
    
}


extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: activitiyCellWidth, height: activitiyCellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return hGap
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
         return hGap
    }
}

    extension HomeViewController: UITableViewDelegate {
        
    }

    extension HomeViewController: UITableViewDataSource {
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
             return historyActivities.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
             let cell = tableView.dequeueReusableCell(withIdentifier: "historycell", for: indexPath) as? ExerciseHistoryTableViewCell
            cell?.config(historyActivities[ indexPath.row] )
            return cell!
        }
    }

 

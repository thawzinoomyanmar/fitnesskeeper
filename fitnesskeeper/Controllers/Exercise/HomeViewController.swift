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
    
    @IBOutlet weak var exerciseListCollection: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        let act = Activity(id: 0, name: "Test", desc: "test")
       
        activities.append(act)
        exerciseListCollection.delegate = self
        
        
        let dbRef =  Database.database().reference()
       let activityRef =  dbRef.child("Activities")
        activityRef.observe(.value) { (ss) in
            let  values = ss.children.allObjects as? [Any]
            for value in (values as! [String:Any]) {
                print(value)
            }
        }
    }
    
    
    @objc func clickSegment(_ segment: UISegmentedControl) {
        if segment.selectedSegmentIndex == 0 {
        } else {
            
        }
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //TODO: Load exe info in proper place
       // let exerciseInfoVC =  UIViewController(nibName: "ExerciseInfoViewController", bundle: nil)
        //self.navigationController?.pushViewController(exerciseInfoVC, animated: true)
        //present(exerciseInfoVC, animated: true, completion: nil)
    }
}

extension HomeViewController:  UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return activities.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = exerciseListCollection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? ExerciseListsCollectionViewCell
      let index =   activities[indexPath.row]
        
        
        return cell!
        
    }
    
    
}


extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 180, height: 180)
    }
}


extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
          let exerciseInfoVC = ExerciseInfoViewController(nibName: "ExerciseInfoViewController", bundle: nil)  
        exerciseInfoVC.activity = activities [ indexPath.row] 
            navigationController?.pushViewController(exerciseInfoVC, animated: true)
     
    }
}

//
//  HomeViewController.swift
//  fitnesskeeper
//
//  Created by Min Aung Hein on 8/11/18.
//  Copyright © 2018 Min Aung Hein. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    var exercistLists = [
        ["photo":"photo1.png","name":"Skiing"],
        ["photo":"photo1.png","name":"Skiing"],
        ["photo":"photo1.png","name":"Skiing"],
        ["photo":"photo1.png","name":"Skiing"],
        ["photo":"photo1.png","name":"Skiing"],
        ["photo":"photo1.png","name":"Running"],
        ["photo":"photo1.png","name":"Running"],
        ["photo":"photo1.png","name":"Running"],
        ["photo":"photo1.png","name":"Running"],
        ["photo":"photo1.png","name":"Running"],
        ["photo":"photo1.png","name":"Running"],
        ["photo":"photo1.png","name":"Running"],
    ]
    @IBOutlet weak var exerciseListCollection: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()

    }
    func setup()  {
        let segmentCtrl = UISegmentedControl()
        segmentCtrl.insertSegment(withTitle: "Activity", at: 0, animated: false)
         segmentCtrl.insertSegment(withTitle: "History", at: 1, animated: false)
        self.navigationItem.titleView?.addSubview(segmentCtrl)
        segmentCtrl.addTarget(self, action:  #selector(clickSegment(_:)) , for: .valueChanged)
    }
    @objc func clickSegment(_ segment: UISegmentedControl) {
        if segment.selectedSegmentIndex == 0 {
        } else {
            
        }
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return exercistLists.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = exerciseListCollection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? ExerciseListsCollectionViewCell
      let index =   exercistLists[indexPath.row]
        cell?.exerciselbl.text = index["name"]
        cell?.exerciseImage.image = UIImage(named: index["photo"]!)
        
        return cell!
        
    }
    
    
}
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 180, height: 180)
    }
}


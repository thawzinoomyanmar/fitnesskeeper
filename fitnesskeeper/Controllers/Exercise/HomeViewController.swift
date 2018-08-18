//
//  HomeViewController.swift
//  fitnesskeeper
//
//  Created by Min Aung Hein on 8/11/18.
//  Copyright © 2018 Min Aung Hein. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
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
        downloadImage()
        
    }
    func downloadImage(){
//     let reference =  Storage.stor..child("https://firebasestorage.googleapis.com/v0/b/fitnesskeeper-c903f.appspot.com/o/ActivityImages%2Factivity1_1.png?alt=media&token=f0a10c42-cc2e-4032-b04f-0734613bad1c")
        let reference = Storage.storage().reference(withPath: "https://firebasestorage.googleapis.com/v0/b/fitnesskeeper-c903f.appspot.com/o/ActivityImages%2Factivity1_1.png?alt=media&token=f0a10c42-cc2e-4032-b04f-0734613bad1c")
       
        reference.getData(maxSize: (1 * 1024 * 1024)) { (data, error) in
            if let _error = error{
                print(_error)
             //   failure(_error)
            } else {
                print("Downloaded complete")
//                if let _data  = data {
//                    let myImage:UIImage! = UIImage(data: _data)
//                    success(myImage)
//                }
            }
        }
    }
    func setup()  {
        let segmentCtrl = UISegmentedControl()
        
        segmentCtrl.insertSegment(withTitle: "Activity", at: 0, animated: false)
         segmentCtrl.insertSegment(withTitle: "History", at: 1, animated: false)
        segmentCtrl.frame = CGRect(x: 0, y: 0, width: view.frame.size.width / 2 , height: (self.navigationController?.navigationBar.frame.size.height)! - 20 )
        
        self.navigationItem.titleView = segmentCtrl
        segmentCtrl.selectedSegmentIndex = 0
        segmentCtrl.addTarget(self, action:  #selector(clickSegment(_:)) , for: .valueChanged)
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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let VC = ExerciseInfoViewController(nibName: "ExerciseInfoViewController", bundle: nil)
    //    self.present(myViewController, animated: true, completion: nil)
   //  let VC =    self.storyboard?.instantiateViewController(withIdentifier: "info") as! ExerciseInfoViewController
//        let VC:ExerciseInfoViewController = UIViewController(nibName: "ExerciseInfoViewController", bundle: nil) as! ExerciseInfoViewController
        navigationController?.pushViewController(VC, animated: true)
   //     self.present(VC,animated: true,completion: nil)
    }
    
    
    
}
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 180, height: 180)
    }
}


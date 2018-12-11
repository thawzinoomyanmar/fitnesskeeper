    //
//  HomeViewController.swift
//  fitnesskeeper
//
//  Created by Min Aung Hein on 8/11/18.
//  Copyright © 2018 Min Aung Hein. All rights reserved.
//

import UIKit
import Firebase
import LGSideMenuController
import StoreKit
class HomeViewController: UIViewController,SKPaymentTransactionObserver, SKRequestDelegate , SKProductsRequestDelegate  {
    
    
    var activities                                     = [Activity]()
    var subActivities                                     = [Activity]()
    var historyActivities                              = [Activity]()
    var isSubActivities                                =  false
    let saleID =  "com.techplus.fitnessapp.premium"
    var activitiyCellWidth                    :CGFloat = 0
     var activitiyCellHeight                  :CGFloat = 0
    var hGap                                  :CGFloat = 2
    var colPerRows                            :CGFloat = 3
    
    @IBOutlet weak var exerciseListCollection : UICollectionView!
    @IBOutlet weak var historyTableView       : UITableView!
    
    @IBAction func sidemenuBtn(_ sender: UIBarButtonItem) {
        sideMenuController?.showLeftView(animated: true, completionHandler: nil)

        
    }
    @IBAction func logoutbtn(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            self.navigationController?.dismiss(animated: true, completion: nil)
        } catch {
            print("Error in logout")
        }
        
        
        
        
    }
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        historyTableView.dataSource = self
        historyTableView.delegate   = self
        setup()
        
        
      
//self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "Back")
       self.navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
       
       
        
    }

    
    func setup()  {
        let segmentCtrl   = UISegmentedControl()
        segmentCtrl.insertSegment(withTitle  : "Activity", at  : 0, animated  : false)
        segmentCtrl.insertSegment(withTitle : "History", at : 1, animated : false)
        segmentCtrl.frame = CGRect(x         : 0, y         : 0, width         : view.frame.size.width / 2 , height         : (self.navigationController?.navigationBar.frame.size.height)! - 20 )
        
        self.navigationItem.titleView    = segmentCtrl
        segmentCtrl.selectedSegmentIndex = 0
        segmentCtrl.addTarget(self, action :  #selector(clickSegment(_ :)) , for : .valueChanged)
        segmentCtrl.tintColor            =  Default.segmentTintColor
        self.view.backgroundColor = Default.tabarColor
        
        activitiyCellWidth               = ( self.view.frame.width - hGap * ( colPerRows - 1) ) / colPerRows
        activitiyCellHeight              =  activitiyCellWidth * 1.2
        exerciseListCollection.delegate  = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(startPurchase), name: Notification.Name("purchase"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(restorePremium), name: Notification.Name("restore"), object: nil)
        
         if  !isSubActivities {
            addObserver( isSubActivities)
         }
       
        
        
 
        
    }
    
    
    @objc func clickSegment(_ segment: UISegmentedControl) {
        if segment.selectedSegmentIndex == 0 {
            exerciseListCollection.isHidden  = false
        } else {
             exerciseListCollection.isHidden = true 
        }
         historyTableView.isHidden           = !exerciseListCollection.isHidden
        
        
    }
    
    func addObserver(_ isSubActivities:Bool  ) {
        let dbRef =  Database.database().reference()
        let activityRef =  dbRef.child("Activities")
        let historyRef =  dbRef.child(Auth.auth().currentUser?.uid ?? "").child("Activity")
        
        
        activityRef.observe(.value) { (ss) in
            if  let  value = ss.value as? [String:Any] {
                self.activities.removeAll() //***
                for (k,v) in value  {
                    
                   
                    
                    if  let activity = v as? [String:Any] {
                        let parentID:Int? = activity["parentid"] as? Int
                        
                        
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
                       
                       
//                        if isSubActivities &&  parentID == nil {
//                            continue
//                        }
                        
                        
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
                            subactivity.parentID = parentID
                            subactivity.duration = duration
                            
                            if let freq = freq {
                                subactivity.freq = freq
                            }
                            if let remark = remark {
                                subactivity.remark = remark
                            }
                            
                            if let urls = urls {
                                subactivity.imageURLs = urls
                            }
                            self.subActivities.append(subactivity)
                        }
                    }
                }
                
                for parent in self.activities {
                    for subActivity in self.subActivities {
                        if parent.id    == subActivity.parentID {
                            parent.subActivities.append(subActivity)
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
                        let dateValue:Double? = activity["date"] as? Double
                        
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
            exerciseInfoVC.totalRecord = self.historyActivities.count
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
        
        
        
        //MARK: IAP
   
        @objc func restorePremium() {
            SKPaymentQueue.default().add(self)
            SKPaymentQueue.default().restoreCompletedTransactions()
        }
        
        @objc func startPurchase(){
            self.showBusy = true
            if self.canMakePayments() {
                print( "IAP Ready")
                
                let product:Set<String> = [saleID]
                let productRequest = SKProductsRequest(productIdentifiers: product)
                
                productRequest.delegate = self
                productRequest.start()
            }
            else {
                print(  "Sorry")
                self.showBusy = false
                
            }
        }
        func canMakePayments() -> Bool {
            return SKPaymentQueue.canMakePayments()
        }
        
        func savePremiumState(state:Bool)
        {
            
            self.showBusy = false
            UserDefaults.standard.set( state, forKey: "premium")
            UserDefaults.standard.synchronize()
        }
        //IAP Standard Code for single product
        func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
            print("Loaded list of products...")
            let products = response.products
            
            if (products.count > 0)
            {
                for p in products {
                    print("Found product: \(p.productIdentifier) \n\(p.localizedTitle) \n\(p.price.floatValue)\n---------")
                }
                
                //If you are try to buy a single product then call purchaseProduct with the first element of array
                
                self.purchaseProduct(products[0]) //*****
                
            }
            else
            {
                print("sorry can't find the productid")
                alert(title:"Product Error",message:"Can't find the product during this time.\nPlease try again in a few minute!" )
                
            }
        }
        
        
        
        func requestProductInfo(_ productIDs:Set<String>) {
            if SKPaymentQueue.canMakePayments() {
                
                
                let productRequest = SKProductsRequest(productIdentifiers:productIDs)
                
                productRequest.delegate = self
                
                print("Proceed to perform IAP")
                productRequest.start()
                
            }
            else {
                print("Cannot perform IAP")
                alert(title:"Permission Error",message:"In app-purchase is disable.\nPlease enable and try again!")
            }
        }
        
        /// Initiates purchase of a product.
        func purchaseProduct(_ product: SKProduct) {
            print("Buying \(product.productIdentifier)...")
            let payment = SKPayment(product: product)
            SKPaymentQueue.default().add(self)
            SKPaymentQueue.default().add(payment)
        }
        
        func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
            for transaction in transactions {
                switch (transaction.transactionState) {
                case .purchased:
                    print("Purchased")
                    //
                    completeTransaction(transaction)
                    self.showBusy = false
                    break
                case .failed:
                    print("Transaction Failed")
                    failedTransaction(transaction)
                    self.showBusy = false
                    break
                case .restored:
                    //Called when Product is purposely restored
                    print("Restored")
                    restoreTransaction(transaction)
                    self.showBusy = false
                     SKPaymentQueue.default().finishTransaction(transaction)
                    break
                case .deferred:
                    print("Deferring....")
                    self.showBusy = false
                    break
                case .purchasing:
                    print("Purchasing....")
                    break
                }
            }
        }
        
        fileprivate func provideContentForProductIdentifier(_ productIdentifier: String) {
            
            if productIdentifier == saleID { // only one product  it has so
                savePremiumState(state:true)
                
                NotificationCenter.default.post(name: Notification.Name("premiumpurchased"), object: nil)
                self.showBusy = false
            }
            
            
        }
        
        
        fileprivate func completeTransaction(_ transaction: SKPaymentTransaction) {
            print("completeTransaction...")
            provideContentForProductIdentifier(transaction.payment.productIdentifier)
            SKPaymentQueue.default().finishTransaction(transaction)
            
            
        }
        
        fileprivate func restoreTransaction(_ transaction: SKPaymentTransaction) {
            let productIdentifier = transaction.original!.payment.productIdentifier
            print("restoreTransaction... \(productIdentifier)")
            provideContentForProductIdentifier(productIdentifier)
            
            self.showBusy = false
            alert(title: "Success", message: "Your previous purchase has been successfully restored")
             SKPaymentQueue.default().finishTransaction(transaction)
        }
        fileprivate func failedTransaction(_ transaction: SKPaymentTransaction) {
            print("failedTransaction...")
            
            //   print("Transaction error: \(transaction.error!.localizedDescription)")
            alert(title:"Transaction error",message:transaction.error!.localizedDescription )
            SKPaymentQueue.default().finishTransaction(transaction)
            self.showBusy = false
            
        }
        
        func request(_ request: SKRequest, didFailWithError error: Error) {
            print("Failed to load list of products.")
            alert(title:"Error",message:error.localizedDescription )
            self.showBusy = false
            
        }
        
        
        
    }

 

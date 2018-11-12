//
//  LeftViewController.swift
//  LGSideMenuControllerDemo
//
import LGSideMenuController
import Firebase

class LeftViewController: UITableViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .fade
    }
    
    // MARK: - UITableViewDataSource
    
    
    
    
    // MARK: - UITableViewDelegate
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mainViewController = sideMenuController
        
        let navCtrl = mainViewController?.rootViewController as? UINavigationController
        let exeStoryBoard = UIStoryboard.init(name: "ExerciseStoryboard", bundle: nil)
        switch indexPath.row {
        case 0:if let vc = exeStoryBoard.instantiateViewController(withIdentifier: "setting") as?      SettingViewController {
            navCtrl?.pushViewController(vc, animated: true)
        }
        mainViewController?.hideLeftView( animated: true, completionHandler: nil)
        case 1: if let vc = exeStoryBoard.instantiateViewController(withIdentifier: "about") as? UIViewController  {
            navCtrl?.pushViewController(vc, animated: true)
        }
        mainViewController?.hideLeftView( animated: true, completionHandler: nil)
        case 2:do {
            try Auth.auth().signOut()
             mainViewController?.dismiss(animated: true, completion: nil)
        } catch {
            print("Error in logout")
            }
        default:break;
        }
        
        
        
        
        
    }
    
}

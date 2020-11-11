//
//  ViewController.swift
//  GoSurf
//
//  Created by Pop on 18/09/19.
//  Copyright © 2019 Piyush Makwana. All rights reserved.
//

import UIKit
import Firebase

extension UINavigationController {
    open override var childForStatusBarStyle: UIViewController? {
        topViewController
    }
}


class ViewController: UITabBarController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Auth.auth().currentUser?.uid == nil {
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
        }
        
        view.backgroundColor = .gray
        
//        self.tabBar.barTintColor = UIColor(r: 22, g: 128, b: 210)
//
        self.tabBar.tintColor = UIColor(r: 22, g: 128, b: 210)
        self.tabBar.unselectedItemTintColor = UIColor(r: 42, g: 42, b: 42)
    
        // Do any additional setup after loading the view.
    }
    

    
    
    @objc func handleLogout() {
           
           do {
               try Auth.auth().signOut()
           } catch let logoutError {
               print(logoutError)
           }
           
           let loginController = LoginController()
           loginController.modalPresentationStyle = .fullScreen
           present(loginController, animated: true, completion: nil)
       }


}


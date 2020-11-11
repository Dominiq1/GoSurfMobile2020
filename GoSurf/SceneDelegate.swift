//
//  SceneDelegate.swift
//  GoSurf
//
//  Created by Pop on 18/09/19.
//  Copyright © 2019 Piyush Makwana. All rights reserved.
//

import UIKit
import SwiftUI

@available(iOS 13.4, *)

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    

 
    @available(iOS 13.4, *)
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
        

        guard let windowScene = (scene as? UIWindowScene) else { return }
               
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene

        

    
        self.splashScreen()
        
    }
    
    
    @available(iOS 13.4, *)
    private func splashScreen(){
        
        let launchScreenVC = UIStoryboard.init(name: "LaunchScreen", bundle: nil)
        let rootVC = launchScreenVC.instantiateViewController(withIdentifier: "splashController")
        self.window?.rootViewController = rootVC
        self.window?.makeKeyAndVisible()
        Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(dismissSplashScreen), userInfo: nil, repeats: false)
    }
    
    @available(iOS 13.4, *)
    @available(iOS 13.4, *)
    @available(iOS 13.4, *)
    @objc func dismissSplashScreen(){
        
            let mainTabBarController = ViewController()
            
            let layout = UICollectionViewFlowLayout()
            
            
          
        
            let campViewContoroller = UINavigationController(rootViewController: CampViewController(collectionViewLayout: layout))
            campViewContoroller.title = "Camp"

            
            let DashboardVC = UINavigationController(rootViewController:
                                                    GoSurfFeed(collectionViewLayout: layout))
        
        
       
           
        //let DashboardVC = UINavigationController(rootViewController: UIHostingController(rootView: DashboardView()))
        
            DashboardVC.title = "Dashboard"

  
        
        
        //can edit the uitabbar and uinavbar from the scene delegate before dashboard view is called
        
            
            let resourcesViewController = UINavigationController(rootViewController: GoSurfViewController(collectionViewLayout: layout))
                resourcesViewController.title = "GoSurf"
     
            
            
            let coachViewController = UINavigationController(rootViewController: CoachViewController())
            coachViewController.title = "Coach"
            
            let chatViewController = UINavigationController(rootViewController: ChatViewController())
            chatViewController.title = "Chat"
            
            let profileViewController = UINavigationController(rootViewController: ProfileViewController())
            profileViewController.title = "Profile"
        
            let newProfileViewController = UINavigationController(rootViewController: NewProfileViewController())
            newProfileViewController.title = "Profile"
        
            let shellViewController = UINavigationController(rootViewController: ShellfileViewController())
            shellViewController.title = "Profile"
            
            //let loginController = LoginController()
            mainTabBarController.viewControllers = [DashboardVC ,resourcesViewController,chatViewController,shellViewController]
 
            
            
            
            let mainController = UINavigationController(rootViewController: mainTabBarController)
            mainController.setNavigationBarHidden(true, animated: false)
        

        
        
            
            
            
            
        
        self.window?.rootViewController = mainController
        self.window?.makeKeyAndVisible()
        
        
    }

    @available(iOS 13.4, *)
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    @available(iOS 13.4, *)
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    @available(iOS 13.4, *)
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    @available(iOS 13.4, *)
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    @available(iOS 13.4, *)
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}


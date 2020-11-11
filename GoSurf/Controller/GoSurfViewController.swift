//
//  ResourcesViewController.swift
//  GoSurf
//
//  Created by Pop on 28/10/19.
//  Copyright © 2019 Piyush Makwana. All rights reserved.
//

import UIKit
import Firebase


@available(iOS 13.4, *)
class GoSurfViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    
    var posts = [Post]()
    
//    var images = [UIImage(named: "photographerImage"),UIImage(named: "videographerImage"),UIImage(named: "storefrontImage"),UIImage(named: "rentalImage"),UIImage(named: "repairImage"),UIImage(named: "shaperImage"), UIImage(named: "glassingImage")]
//    var titles = ["Photographers", "Videographers", "Storefronts","Rentals","Repairs","Shapers","Glassing"]
    
    var images = [UIImage(named: "campImage"), UIImage(named: "instructorImage"), UIImage(named: "photographerImage"),UIImage(named: "videographerImage") ]
    var titles = ["Camps", "Instructors / Coaches" ,"Photographers", "Videographers"]

    var businessType = ["Camp","Instructor","dummy","Photographer","Videographer","Storefront","Rental","Repairs","Shaper","Glassing"]
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
        //return UIStatusBarStyle.default   // Make dark again
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addLogoToNavigationBarItem()
        

        if Auth.auth().currentUser?.uid == nil {
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
        }
        
             
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "marker"), style: .plain, target: self, action: #selector(openMapButton))
        
        //add action to this button
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "invisible"), style: .plain, target: self, action: nil)
        
        setupNavBar()
        
         
        collectionView?.backgroundColor = .white
        
        collectionView?.register(CampCell.self, forCellWithReuseIdentifier: "cellID")
        collectionView?.register(PostHeaderCell.self, forCellWithReuseIdentifier: "cellID2")
        
        self.tabBarController?.tabBar.items?[3].image = UIImage(named: "profile")
        self.tabBarController?.tabBar.items?[0].image = UIImage(named: "dashboard")
        self.tabBarController?.tabBar.items?[1].image = UIImage(named: "goSurfIcon")
        self.tabBarController?.tabBar.items?[2].image = UIImage(named: "chatIcon-1")

    }
    
    override func viewWillAppear(_ animated: Bool) {
 
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    @objc func openMapButton() {
        let newPostController = MapViewController()
        let navController = UINavigationController(rootViewController: newPostController)
        present(navController, animated: true, completion: nil)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        //returns the number of
        return images.count + 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
         print( "cell for row at : " + String(indexPath.row))
        
        if indexPath.row == 0 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID2", for: indexPath) as! PostHeaderCell
            
            cell.titleLable.text = "Explore"
            
            cell.titleLable.textColor = UIColor(r: 42, g: 42, b: 42)
            cell.isUserInteractionEnabled = false
            
            return cell
        
            
        }else if indexPath.row < 3
        {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as! CampCell
        
        let image = images[indexPath.row - 1]
        let title = titles[indexPath.row - 1]
        
        
        cell.titleLable.text = title
        
        cell.thumbnailImageView.image = image

        return cell
            
        } else if indexPath.row == 3 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID2", for: indexPath) as! PostHeaderCell
            
            cell.titleLable.text = "Resources"
            
            cell.titleLable.textColor = UIColor(r: 42, g: 42, b: 42)
            cell.isUserInteractionEnabled = false
            
            return cell
            
        } else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as! CampCell
            
            let image = images[indexPath.row - 2]
            let title = titles[indexPath.row - 2]
            
            
            cell.titleLable.text = title
            
            cell.thumbnailImageView.image = image

            return cell
            
        }

            
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.row == 0 || indexPath.row == 3 {
            
            return CGSize(width: view.frame.height, height: 40)
            
        }else {
            
        let height = ((view.frame.width - 16 - 16)*(9/19))
        
        return CGSize(width: view.frame.width, height: height + 32 )
            
        }

    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

            showCoachControllerForType(businessType[indexPath.row - 1 ])

    }
    
    func showCoachControllerForType(_ type: String) {
        let coachViewController = CoachViewController()
        coachViewController.type = type
        coachViewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(coachViewController, animated: true)
    }
    
    
        func setupNavBar() {

            
            self.navigationController?.navigationBar.tintColor = UIColor.white
            
            if #available(iOS 13.0, *) {
                let navBarAppearance = UINavigationBarAppearance()
                navBarAppearance.configureWithOpaqueBackground()
                navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
                navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
                navBarAppearance.backgroundColor = UIColor(r: 22, g: 128, b: 199)
                self.navigationController?.navigationBar.standardAppearance = navBarAppearance
                self.navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
            }
            
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
    
    
        func fetchUser() {
            Database.database().reference().child("post").observe(.childAdded, with: { (snapshot) in
                
                if let dictionary = snapshot.value as? [String: AnyObject] {
                    
                    let user = Post( dictionary: dictionary)
                    
                    user.id = snapshot.key
                    
            
                    self.posts.append(user)
                    
                    //this will crash because of background thread, so lets use dispatch_async to fix
                    DispatchQueue.main.async(execute: {
                        self.collectionView.reloadData()
                    })
    //                user.name = dictionary["name"]
                }
                }, withCancel: nil)
        }


}

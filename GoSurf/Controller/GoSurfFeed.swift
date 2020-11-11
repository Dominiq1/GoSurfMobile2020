//
//  ImprovementViewController.swift
//  GoSurf
//
//  Created by Pop on 28/10/19.
//  Copyright © 2019 Piyush Makwana. All rights reserved.
//



import Firebase
import SwiftUI

@available(iOS 13.4, *)
class GoSurfFeed: UICollectionViewController, UICollectionViewDelegateFlowLayout{
    
    var showAppointmentStatus: Bool = false
    var ref: DatabaseReference!
       var user: User? 

    

    
    var posts = [Post]()
    var images = [UIImage(named: "campImage"),UIImage(named: "instructorImage")]
    var titles = ["Camps", "Instructors / Coaches" ]
    var businessType = ["Camp","Instructor","Coach"]
    var swiftUIMainView: String = "Dash"
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
        //return UIStatusBarStyle.default   // Make dark again
    }
    
    
    
    var AdminsDashView = UIHostingController(rootView: AdminDashView())
    var dashboardUIVc = UIHostingController(rootView: DashboardView())
    var userDashView = UIHostingController(rootView: UserDashView())
    
   
    
    override func viewDidLoad() {
        
        fetchUser()
        
        super.viewDidLoad()
        
     
       
        
        if Auth.auth().currentUser?.uid == nil {
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
        }
        

        transitionIVew()
        //how you set up a swiftuiviewin uikit
        setupNavBar()
        //==========================
    
            let controller = dashboardUIVc
              controller.view.translatesAutoresizingMaskIntoConstraints = false
      
 
        
              self.addChild(controller)
        self.view.addSubview(controller.view)
              controller.didMove(toParent: self)
              
              NSLayoutConstraint.activate(
                  [
                    
        
                      controller.view.widthAnchor.constraint(equalToConstant: 450),
                    controller.view.heightAnchor.constraint(equalToConstant: 800),
                  controller.view.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                  controller.view.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
              ])
        
      
      
        addLogoToNavigationBarItem()
        
        
       
        //------------------------------------------------------------
        
        // self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "marker"), style: .plain, target: self, action: #selector(handleNewPost))
       
      
    
        
       // collectionView?.register(CampCell.self, forCellWithReuseIdentifier: "cellID")
        //DashViewVC.preferredContentSize = .init(width: 100000, height: 1000000000)

        if Auth.auth().currentUser?.uid == nil {
            
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
            
        }
     
        // setup nav bar
        
        //self.navigationController?.navigationBar.tintColor = UIColor.white
        
//        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "marker"), style: .plain, target: self, action: #selector(openMapViewController))
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "invisible"), style: .plain, target: self, action: nil)
  
        
        
       
           // let navBarAppearance = UINavigationBarAppearance()
           // navBarAppearance.configureWithOpaqueBackground()
           // navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
           // navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
           // navBarAppearance.backgroundColor = UIColor(r: 22, g: 128, b: 199)
           // self.navigationController?.navigationBar.standardAppearance = navBarAppearance
          //  self.navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance

           // self.tabBarController?.tabBar.items?[3].image = UIImage(named: "profile")
           // self.tabBarController?.tabBar.items?[0].image = UIImage(named: "dashboard")
          //  self.tabBarController?.tabBar.items?[1].image = UIImage(named: "goSurfIcon")
          //  self.tabBarController?.tabBar.items?[2].image = UIImage(named: "chatIcon-1")
        

//        fetchUser()

      //  collectionView?.backgroundColor = .white
       // collectionView?.register(CampCell.self, forCellWithReuseIdentifier: "cellID")
        
       // collectionView?.register(PostHeaderCell.self, forCellWithReuseIdentifier: "cellID2")
        
        self.tabBarController?.tabBar.items?[3].image = UIImage(named: "profile")
        self.tabBarController?.tabBar.items?[0].image = UIImage(named: "dashboard")
        self.tabBarController?.tabBar.items?[1].image = UIImage(named: "goSurfIcon")
        self.tabBarController?.tabBar.items?[2].image = UIImage(named: "chatIcon-1")

    }
    
    func transitionIVew(){
      reloadInputViews()
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.isNavigationBarHidden = true
        // setupNavBarButton()
        //navigationController?.navigationBar.prefersLargeTitles = false
        //self.addLogoToNavigationBarItem()
        
        
    }
    
    @objc func OpenDashboardController() {
        
        if user?.type == "Business"{
            let VC = AdminDashboardViewController()
            VC.hidesBottomBarWhenPushed = true
              VC.modalTransitionStyle = .flipHorizontal
              present(VC, animated: true)
        }else if user?.type == "User"{
            let VC =  UserDashboardViewController()
            VC.hidesBottomBarWhenPushed = true
              VC.modalTransitionStyle = .flipHorizontal
              present(VC, animated: true)
        }else{
            
            //take this out to prevent it from coming up when it can not connect to the network
            let VC =  UserDashboardViewController()
            VC.hidesBottomBarWhenPushed = true
              VC.modalTransitionStyle = .flipHorizontal
              present(VC, animated: true)
            print("User is not connected so there is not way to present the dashboard")
        }
        
       // vc.modalPresentationStyle = .fullScreen
   
        
        /*
        if showAppointmentStatus == false{
            showAppointmentStatus = true
        }else if showAppointmentStatus == true {
            showAppointmentStatus = false
        }
        */
   
        //self.Controller = UIHostingController(rootView: acceptDecline())
       viewDidLoad()
        
     //  let navController = UINavigationController(rootViewController: newPostController)
     //   self.present(navController, animated: true, completion: nil)
    }
    
    
    /*
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       // return images.count + 2
        return 1
    }
    
    
   
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        print( "cell for row at : " + String(indexPath.row))
        
        
        if indexPath.row == 0 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as! CampCell
            
            //cell.titleLable.text = "Dashboard"
            //-----added subview---------
            let uiview = UIHostingController(rootView: DashboardView())
            cell.addSubview(uiview.view!)
            
            //-------------------------
            
            cell.isUserInteractionEnabled = false
            
            return cell
        
            
        }else
        {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as! CampCell
        
            let image = images[indexPath.row - 1]
            let title = titles[indexPath.row - 1]
            
            cell.bookButton.setTitle("VIEW", for: .normal)
            cell.titleLable.text = title
            cell.thumbnailImageView.image = image
    
            return cell
        }
        
    }
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        print( "size for Itema at  " + String(indexPath.row))
        
        
        if indexPath.row == 0 {
            
            return CGSize(width: view.frame.width, height: 40)
            
        }else {
            
        let height = ((view.frame.width - 16 - 16)*(9/19))
        
        return CGSize(width: view.frame.width, height: height + 32 )
        }


    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
            showCoachControllerForType(businessType[indexPath.row - 1])
        
    }
    
    func showCoachControllerForType(_ type: String) {
        let coachViewController = CoachViewController()
        coachViewController.type = type
        coachViewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(coachViewController, animated: true)
    }
    
    
    //this function should bring up the swift ui view

    
   

     */
    
    func fetchUser() {
        
        guard let uid = Auth.auth().currentUser?.uid else {

        return
            }
            
            Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
                
                if let dictionary = snapshot.value as? [String: AnyObject] {
    //                self.navigationItem.title = dictionary["name"] as? String
                    
                    self.user = User(dictionary: dictionary)

                }
                
                }, withCancel: nil)
        }

    //----------------------------
    
    
    func setupNavBar() {

             
             self.navigationController?.navigationBar.tintColor = UIColor.white
             
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "create"), style: .plain, target: self, action: #selector(OpenDashboardController))
  
        
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "invisible"), style: .plain, target: self, action: nil)
        
                 let navBarAppearance = UINavigationBarAppearance()
                 navBarAppearance.configureWithOpaqueBackground()
                 navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
                 navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
                 navBarAppearance.backgroundColor = UIColor(r: 22, g: 128, b: 199)
                 self.navigationController?.navigationBar.standardAppearance = navBarAppearance
                 self.navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
             
             
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


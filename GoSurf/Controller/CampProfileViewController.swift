//
//  CampProfileViewController.swift
//  GoSurf
//
//  Created by Pop on 02/05/20.
//  Copyright © 2020 Piyush Makwana. All rights reserved.
//


import Firebase
import UIKit

@available(iOS 13.4, *)
class CampProfileViewController: UITableViewController, UINavigationControllerDelegate {
    
    var user: User? {
        
        didSet {
            
            self.tableView.reloadData()
            
            if checker == 0 {
                
                self.title = "Camp Profile"
                
                self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "chat"), style: .plain, target: self, action: #selector(openChatViewController))
                
            } else if checker == 1 {
                    
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit ✎", style: .plain, target: self, action: #selector(openEditCampProfileViewController))
                
            self.title = "Profile"
                
            } else {
                
                self.title = "Camp Profile"
                
            }
            
            
        }
    }
    
    var media = [Post]()

    

    var name: String? {
        
        didSet {
            
            print(self.name!)
        }
    }
    
    var email: String? {
        
        didSet {
            
            print(self.email!)
            
            fetchUser(self.email!)
            
            fetchViewer()
            
            fetchMedia()
            
        }
    }
    
    var checker: Int = 0
    
    func fetchUser(_ email : String) {
            
            Database.database().reference().child("users").observe(.childAdded, with: { (snapshot) in
                
                if let dictionary = snapshot.value as? [String: AnyObject] {
                    let user = User(dictionary: dictionary)
                    user.id = snapshot.key
                    
                    if user.email == self.email {
                        
                        self.user = user
                        
                    }
                    
                    //this will crash because of background thread, so lets use dispatch_async to fix
                    DispatchQueue.main.async(execute: {
                        self.tableView.reloadData()
                    })
                    
    //                user.name = dictionary["name"]
                }
                
                }, withCancel: nil)
        }
    
    
        func fetchMedia() {
            
               Database.database().reference().child("post").observe(.childAdded, with: { (snapshot) in
                   
                   if let dictionary = snapshot.value as? [String: AnyObject] {
                       
                       let post = Post( dictionary: dictionary)
                       
                       post.id = snapshot.key
                        
                        if self.email == post.postedBy {
                            
                            self.media.append(post)
                    
                            if self.media.count == 3 {
                                return
                            }
                        }
                       
                       //this will crash because of background thread, so lets use dispatch_async to fix
                       DispatchQueue.main.async(execute: {
                           self.tableView.reloadData()
                       })
                       
       //                user.name = dictionary["name"]
                   }
                   
                   }, withCancel: nil)
           }
    

    
    var Viewer: User?
    
    func fetchViewer() {
        
        guard let uid = Auth.auth().currentUser?.uid else {
                //for some reason uid = nil
        return
            }
            
            Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
                
                if let dictionary = snapshot.value as? [String: AnyObject] {
    //                self.navigationItem.title = dictionary["name"] as? String
                    
                    let user = User(dictionary: dictionary)
                    self.Viewer = user
                    print(dictionary)
                    print(dictionary.count)
                
                    print("---------")
            
                }
                
                }, withCancel: nil)
        
        //-----------------------------------------------------
        }
    
    
    
    
    
        var placeText = "To sorry world an at do spoil along. Incommode he depending do frankness remainder to. Edward day almost active him friend thirty piqued. People as period twenty my extent as. Set was better abroad ham plenty secure had horses. Admiration has sir decisively excellence say everything inhabiting acceptance. Sooner settle add put you sudden him. "
    
    
        
    var tags = [[String]]()
    
    var count: Int = 0
    
    let cellID = "cellid"
    let cellID1  = "cellid1"
    let cellID3 = "cellid3"
    let cellID4 = "cellid4"
    let cellID5 = "cellid5"
    let cellID6 = "cellid6"

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "chat"), style: .plain, target: self, action: #selector(openChatViewController))
        
        view.backgroundColor = .white
        
        setupNavBar()
//        fetchReviews()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        tableView.register(ProfileFieldCell.self, forCellReuseIdentifier: cellID)
        tableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: cellID1)
        tableView.register(OfferingTableViewCell.self, forCellReuseIdentifier: cellID3)
        tableView.register(MediaTableViewCell.self, forCellReuseIdentifier: cellID4)
        tableView.register(ButtonTableViewCell.self, forCellReuseIdentifier: cellID5)
        tableView.register(ReviewTableViewCell.self,forCellReuseIdentifier: cellID6)
        
        tableView.separatorStyle = .none
        

        
        // Do any additional setup after loading the view.
    }
    

    
    var messagesController: ChatViewController?
    
    @objc func openChatViewController() {
        
        print("chat button clicked ")
        
        guard let user = self.user else { return }
        
        
        let chatLogController = ChatLogController(collectionViewLayout: UICollectionViewFlowLayout())
        chatLogController.user = user
        chatLogController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(chatLogController, animated: true)
        
        
    }
    
    @objc func openEditCampProfileViewController() {
        
        let viewController = EditCampProfileViewController()
        let navController = UINavigationController(rootViewController: viewController)
        present(navController, animated: true, completion: nil)
    
    }
    
    
    
    
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    func setupNavBar() {
    
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    @objc func openMapViewController() {
        
        let mapController = MapViewController()
        mapController.fromProfile = true
        mapController.user = self.user
        mapController.title = self.user?.address
        let navController = UINavigationController(rootViewController: mapController)
        present(navController, animated: true, completion: nil)
        
        
    }
    
     @objc func handleBookSession() {
       //backend stuff
             let viewController = SelectLessonTypeViewController()
            
            // creating admin and user id's
            viewController.userid = Viewer!.id
            viewController.adminid = user!.id
            viewController.adminType = "Photographer"
            
            //print user Id
            print(viewController.userid as Any )
            //print admin ID
         // both returning admin id
            print(viewController.adminid as Any)
            viewController.adminsName = user?.name!
            
            //above two lines were added by Dom
             let navController = UINavigationController(rootViewController: viewController)
             present(navController, animated: true, completion: nil)
            
          //administrator
            print(user!.id as Any)
            
        //user
            print("----------select session pressed------------")
            
          
          print(Viewer!.id as Any)
            
    }
    
     @objc func openGallery() {
         
         let viewController = CampViewController(collectionViewLayout: UICollectionViewFlowLayout())
         viewController.email = user?.email
         viewController.name = user?.name
         let navController = UINavigationController(rootViewController: viewController)
         present(navController, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID1, for: indexPath) as! ProfileTableViewCell
        
        cell.nameLable.text = self.user?.name
            
        cell.priceLable.isHidden = true
            
//        cell.locationLable.text = self.user?.address
            
        cell.locationLable.isHidden = true
        
        if ((self.user?.address) != nil) {
            
            cell.locationLable.isHidden = false
            
            if user?.shortAddress != "" && user?.shortAddress != nil{
                
                cell.locationLable.text = user?.shortAddress
            }
            
        }

            
            
            
        let tapLocationGesture = UITapGestureRecognizer(target: self, action: #selector(openMapViewController))
            
        cell.locationLable.addGestureRecognizer(tapLocationGesture)
            
        cell.locationLable.isUserInteractionEnabled = true
            
            if self.user?.profileImageUrl != nil {
        
            if let profileImageUrl = self.user?.profileImageUrl {
                
            cell.profileImageView.loadImageUsingCacheWithUrlString(profileImageUrl)

                }

            }
            
            
            var n = 0
            for i in reviews {
                n = n + i.rating!
            }
            
            if reviews.count != 0 {
            cell.ratingsImageView.image = starImage(rating: Double(n/reviews.count))
            cell.reviewsLable.text = "based on " + String(reviews.count) + " Ratings"
            } else {
                cell.ratingsImageView.image = #imageLiteral(resourceName: "0stars")
                cell.reviewsLable.text = "No Ratings available"
            }
        
        return cell
            
            
        }else if indexPath.row == 1 {
            
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! ProfileFieldCell

        cell.detailLable.text = placeText

        cell.nameLable.text = "About"
            
        cell.detailLable.text = self.user?.bio
        
            
        
        cell.selectionStyle = .none
            
        return cell
            
            
        }else if indexPath.row == 2 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: cellID4, for: indexPath) as! MediaTableViewCell
            
            if media.count > 0 {
                
                cell.imageViewOne.loadImageUsingCacheWithUrlString(media[0].imageURL!)
                
                if media.count > 1 {
                    
                    cell.imageViewTwo.loadImageUsingCacheWithUrlString(media[1].imageURL!)
                    
                    if media.count > 2 {
                        
                        cell.imageViewThree.loadImageUsingCacheWithUrlString(media[2].imageURL!)
                        
                    }
                    
                }
                
            }
            
            cell.mediaButton.addTarget(self, action: #selector(openGallery), for: .touchUpInside)
            cell.contentView.isUserInteractionEnabled = false
            
            return cell
            
        }else if indexPath.row  == 3 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: cellID5, for: indexPath) as! ButtonTableViewCell
            
            cell.button.addTarget(self, action: #selector(handleBookSession), for: .touchUpInside)
            
            return cell
            
        }else if indexPath.row  == 4 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: cellID6, for: indexPath) as! ReviewTableViewCell
            
            
            if Viewer?.email == self.email {
                
                cell.button.isHidden = true
                
            }else {
                
                cell.button.addTarget(self, action: #selector(showReviewViewController), for: .touchUpInside)
            }
            
            cell.reviews = self.reviews
            return cell
            
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: cellID3, for: indexPath) as! OfferingTableViewCell
            
            return cell
            
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        tableView.estimatedRowHeight = 72
        tableView.rowHeight = UITableView.automaticDimension
        fetchReviews()
        tableView.reloadData()
    }
    
    @objc func showReviewViewController() {
        let newPostController = ReviewVeiwController()
        newPostController.reviewFor = self.email!
        let navController = UINavigationController(rootViewController: newPostController)
        present(navController, animated: true, completion: nil)
    }
    
    var reviews = [Review]()
    
    func fetchReviews() {
        
        reviews = []
                
                Database.database().reference().child("reviews").observe(.childAdded, with: { (snapshot) in
    
                    if let dictionary = snapshot.value as? [String: AnyObject] {
                        let review = Review(dictionary: dictionary)
                        review.id = snapshot.key

    
                        if review.reviewFor == self.email! {
                        self.reviews.append(review)
                        }
    
                        //this will crash because of background thread, so lets use dispatch_async to fix
                        DispatchQueue.main.async(execute: {
                            self.tableView.reloadData()
   
                        })
    
        //                user.name = dictionary["name"]
                    }
    
                    }, withCancel: nil)
            }
    
    func starImage(rating: Double) -> UIImage {
        
        let roundedRating = round(rating)
        
        if roundedRating == 1 {
            return #imageLiteral(resourceName: "1stars")
            
        } else if roundedRating == 2 {
            return #imageLiteral(resourceName: "2stars")
            
        } else if roundedRating == 3 {
            return #imageLiteral(resourceName: "3stars")
                   
        } else if roundedRating == 4 {
            return #imageLiteral(resourceName: "4stars")
                   
        } else if roundedRating == 5 {
            return #imageLiteral(resourceName: "5stars")
                   
        } else {
            return #imageLiteral(resourceName: "0stars")
        }
    }

    
}

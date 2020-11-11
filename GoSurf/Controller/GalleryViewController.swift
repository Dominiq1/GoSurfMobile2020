//
//  CampViewController .swift
//  GoSurf
//
//  Created by Pop on 18/09/19.
//  Copyright © 2019 Piyush Makwana. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class CampViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var posts = [Post]()
    var email: String? {
        
        didSet {
            
            fetchMedia()
            fetchUser()
        }
        
    }
    
    var user: User? {
        
        didSet {
            
            self.collectionView.reloadData()
        }
    }
    
    var name: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavBar()
         
        collectionView?.backgroundColor = .white
        
        collectionView?.register(CampCell.self, forCellWithReuseIdentifier: "cellID")


    }
    
    @objc func handleNewPost() {
        let newPostController = CreatePostViewController()
        let navController = UINavigationController(rootViewController: newPostController)
        present(navController, animated: true, completion: nil)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as! CampCell
        
        let post = posts[indexPath.row]
        
        cell.titleLable.text = post.description
        cell.titleLable.font = UIFont.boldSystemFont(ofSize: 16)
        cell.bookButton.isHidden = true
        cell.titleLable.layer.shadowOpacity = 0.9
        
        if user?.email == self.email {
            
            cell.tapToDeleteLable.isHidden = false
            
        } else {

            cell.tapToDeleteLable.isHidden = true
        }
        

        
        if let profileImageUrl = post.imageURL {
            cell.thumbnailImageView.loadImageUsingCacheWithUrlString(profileImageUrl)
        }

        return cell
            
    }
    
    
    
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height = ((view.frame.width - 16 - 16)*(9/19))
        
        return CGSize(width: view.frame.width, height: height + 32 )

    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if user?.email == self.email {
            
            // delete action
            let media = posts[indexPath.row]
            let imageURL = media.imageURL
            let postRef = Database.database().reference().child("post").child(media.id!)
            let imageRef = Storage.storage().reference(forURL: imageURL!)

            
            let alert = UIAlertController(title: "Delete", message: "Are you sure you wnat to delete this image?", preferredStyle: .alert)
            
            
            alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: {
                (action) in
                
                // delete the post
                postRef.removeValue { error,arg  in
                  if error != nil {
                    print("error \(String(describing: error))")
                  }
                }
                
                // delete the image
                imageRef.delete { error in
                    if let error = error {
                        print(error)
                    } else {
                        // File deleted successfully
                    }
                }
                
                //
                self.posts.remove(at: indexPath.row)
                
                self.collectionView.deleteItems(at: [indexPath])
                
                
            }))
            
            alert.addAction(UIAlertAction(title: "No", style: .default, handler: {
                (action) in
                
            }))
            
            self.present(alert,animated: true)

            
        } else {

            // do nothing
        }
    }
    
    
    
        func setupNavBar() {

            self.title = name! + "'s Gallery"
            self.navigationController?.navigationBar.prefersLargeTitles = false
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(handleCancel))

        }
    
    @objc func handleCancel() {
        self.dismiss(animated: true, completion: nil)
    }
    
        
    
    
        func fetchMedia() {
            Database.database().reference().child("post").observe(.childAdded, with: { (snapshot) in
                
                if let dictionary = snapshot.value as? [String: AnyObject] {
                    
                    let user = Post( dictionary: dictionary)
                    
                    user.id = snapshot.key
                    
                    if user.postedBy == self.email {
                        self.posts.append(user)
                    }
 
    
                    
                    //this will crash because of background thread, so lets use dispatch_async to fix
                    DispatchQueue.main.async(execute: {
                        self.collectionView.reloadData()
                    })
                    
    //                user.name = dictionary["name"]
                }
                
                }, withCancel: nil)
        }
    
    func fetchUser() {
        
        guard let uid = Auth.auth().currentUser?.uid else {

        return
            }
            
            Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
                
                if let dictionary = snapshot.value as? [String: AnyObject] {

                    let currentUser = User(dictionary: dictionary)
                    
                    self.user = currentUser
    
                    
                }
                
                }, withCancel: nil)
        
    }


}

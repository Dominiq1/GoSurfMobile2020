//
//  Posts.swift
//  GoSurf
//
//  Created by Pop on 09/10/19.
//  Copyright © 2019 Piyush Makwana. All rights reserved.
//

import Foundation
import Firebase

class Post {
    var id: String?
    var title: String?
    var imageURL: String?
    var description: String?
    var postedBy: String?
    var contact: String?
    var type: String?
    private var image: UIImage!
    
//    init(dictionary: [String: AnyObject]) {
//        self.title = dictionary["title"] as? String
//        self.description = dictionary["description"] as? String
//        self.postedBy = dictionary["postedBy"] as? String
//        self.imageURL = dictionary["imageURL"] as? String
//        self.contact = dictionary["contact"] as? String
//    }
    
    init(image: UIImage, dictionary: [String: AnyObject]  ) {
                self.image = image
                self.title = dictionary["title"] as? String
                self.description = dictionary["description"] as? String
                self.postedBy = dictionary["postedBy"] as? String
                self.contact = dictionary["contact"] as? String
                self.type = dictionary["type"] as? String
        
    }
    
    init(dictionary: [String: AnyObject]) {
        self.id = dictionary["id"] as? String
        self.imageURL = dictionary["imageURL"] as? String
        self.title = dictionary["title"] as? String
        self.description = dictionary["description"] as? String
        self.postedBy = dictionary["postedBy"] as? String
        self.contact = dictionary["contact"] as? String
        self.type = dictionary["type"] as? String
    }
    
    func save() {
        let newPostRef = Database.database().reference().child("post").childByAutoId()
        
        let newPostKey  = newPostRef.key!
        
        if let imageData = self.image.jpegData(compressionQuality: 0.4) {
            
            let imageStorageRef = Storage.storage().reference().child("images")
            let newImageRef = imageStorageRef.child(newPostKey)
            
            newImageRef.putData(imageData).observe(.success, handler:
                { (snapshot) in
                    newImageRef.downloadURL { (url, error) in
                        guard let downloadURL = url?.absoluteString else {
                        // Uh-oh, an error occurred!
                        return
                      }
                        
                        print("testing - 1")

                        self.imageURL = downloadURL
                        
                        let newPostDictionary = [
                            "imageURL": self.imageURL,
                            "description" : self.description,
                            "title" : self.title,
                            "postedBy": self.postedBy,
                            "contact" : self.contact,
                            "type" : self.type
                        ]
                        
                        newPostRef.setValue(newPostDictionary)
                    }

            })
            
        }
        
    }
    
}
